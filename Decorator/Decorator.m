//
//  Decorator.m
//  Decorator
//
//  Created by bob on 2019/2/21.
//

#import "Decorator.h"

@interface Decorator ()

@property (nonatomic, strong) id strongTarget;
@property (nonatomic, weak) id weakTarget;
@property (nonatomic, assign) DecoratorTargetType targetType;


@end

@implementation Decorator

- (instancetype)initWithTarget:(id)target type:(DecoratorTargetType)targetType {
    switch (targetType) {
        case DecoratorTargetTypeStrong:     self.strongTarget = target; break;
        case DecoratorTargetTypeWeak:       self.weakTarget = target;   break;
    }
    self.targetType = targetType;
    return self;
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
