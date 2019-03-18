//
//  Decorator.m
//  Decorator
//
//  Created by bob on 2019/2/21.
//

#import "Decorator.h"
#import "TargetDeallocNotifier.h"
#import <objc/runtime.h>

static const void * kDecoratorTargetNilNotifier = &kDecoratorTargetNilNotifier;

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

// handling nil target
// https://github.com/Flipboard/FLAnimatedImage/blob/76a31aefc645cc09463a62d42c02954a30434d7d/FLAnimatedImage/FLAnimatedImage.m#L786-L807

- (instancetype)initWithTarget:(id)target type:(DecoratorTargetType)targetType nilBlock:(dispatch_block_t)block {
    if (targetType == DecoratorTargetTypeWeak) {
        TargetDeallocNotifier *notifier = [[TargetDeallocNotifier alloc] initWithBlock:block];
        objc_setAssociatedObject(target, kDecoratorTargetNilNotifier, notifier, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        self.weakTarget = target;
    } else {
        self.strongTarget = target;
    }
    self.targetType = targetType;

    return self;
}

+ (instancetype)weakDecoratorWithTarget:(id)target notifyBlock:(dispatch_block_t)block {
    NSCAssert(target, @"target should not be nil");
    NSCAssert(block, @"nilBlock should not be nil");
    return [[self alloc] initWithTarget:target type:DecoratorTargetTypeWeak nilBlock:block];
}

+ (instancetype)strongDecoratorWithTarget:(id)target {
    NSCAssert(target, @"target should not be nil");
    return [[self alloc] initWithTarget:target type:DecoratorTargetTypeStrong nilBlock:nil];
}

- (id)target {
    switch (self.targetType) {
        case DecoratorTargetTypeStrong:     return self.strongTarget;
        case DecoratorTargetTypeWeak:       return self.weakTarget;
    }

    return nil;
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    [invocation invokeWithTarget:self.target];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    return [self.target methodSignatureForSelector:sel];
}

@end
