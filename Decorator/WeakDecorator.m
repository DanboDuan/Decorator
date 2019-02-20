//
//  WeakDecorator.m
//  BDAutoTracker
//
//  Created by bob on 2019/1/20.
//

#import "WeakDecorator.h"

@interface WeakDecorator ()

@property (nonatomic, weak) id target;

@end

@implementation WeakDecorator

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
