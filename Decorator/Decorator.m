//
//  Decorator.m
//  Decorator
//
//  Created by bob on 2019/2/21.
//

#import "Decorator.h"
#import <objc/runtime.h>

typedef NS_ENUM(NSInteger, DecoratorTargetType) {
    DecoratorTargetTypeStrong = 1,
    DecoratorTargetTypeWeak
};

@interface Decorator ()

@property (nonatomic, strong) id strongTarget;
@property (nonatomic, weak) id weakTarget;
@property (nonatomic, assign) DecoratorTargetType targetType;


@end

@implementation Decorator

- (instancetype)initWithTarget:(id)target type:(DecoratorTargetType)targetType {
    if (targetType == DecoratorTargetTypeWeak) {
        self.weakTarget = target;
    } else {
        self.strongTarget = target;
    }
    self.targetType = targetType;

    return self;
}

+ (instancetype)weakDecoratorWithTarget:(id)target {
    return [[self alloc] initWithTarget:target type:DecoratorTargetTypeWeak];
}

+ (instancetype)strongDecoratorWithTarget:(id)target {
    return [[self alloc] initWithTarget:target type:DecoratorTargetTypeStrong];
}

- (id)target {
    switch (self.targetType) {
        case DecoratorTargetTypeStrong:     return self.strongTarget;
        case DecoratorTargetTypeWeak:       return self.weakTarget;
    }

    return nil;
}

#pragma mark - standard

- (void)forwardInvocation:(NSInvocation *)invocation {
    if (!self.target) {
        void *nullPointer = NULL;
        [invocation setReturnValue:&nullPointer];
        return;
    }

    [invocation invokeWithTarget:self.target];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    if (!self.target) {
        return [NSObject instanceMethodSignatureForSelector:@selector(init)];
    }
    
    return [self.target methodSignatureForSelector:sel];
}

#pragma mark - extra work

//下面两个方法是适配IGListKit
- (BOOL)respondsToSelector:(SEL)aSelector {
    return [self.target respondsToSelector:aSelector];
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    return self.target;
}

// IGListKit 实现如下 导致消息转发一些问题

// handling unimplemented methods and nil target/interceptor
// https://github.com/Flipboard/FLAnimatedImage/blob/76a31aefc645cc09463a62d42c02954a30434d7d/FLAnimatedImage/FLAnimatedImage.m#L786-L807
#if 0
- (void)forwardInvocation:(NSInvocation *)invocation {
    void *nullPointer = NULL;
    [invocation setReturnValue:&nullPointer];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector {
    return [NSObject instanceMethodSignatureForSelector:@selector(init)];
}
#endif

@end
