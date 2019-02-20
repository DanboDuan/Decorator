//
//  StrongDecorator.m
//  Decorator
//
//  Created by bob on 2019/2/20.
//

#import "StrongDecorator.h"

@interface StrongDecorator ()

@property (nonatomic, strong) id target;

@end

@implementation StrongDecorator

- (instancetype)initWithTarget:(id)target {
    self.target = target;
    return self;
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    [invocation invokeWithTarget:self.target];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    return [self.target methodSignatureForSelector:sel];
}

@end
