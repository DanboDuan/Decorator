//  Created by bob on 2019/1/15.
//

#import "UIScrollView+Decorator.h"
#import <objc/runtime.h>
#import "DSwizzle.h"

@interface DScrollViewDelegateDecorator() <UIScrollViewDelegate>

@property (nonatomic, assign) CGPoint contentOffset;

@end

@implementation DScrollViewDelegateDecorator

#pragma mark UIScrollViewDelegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // do some thing
//    NSLog(@"DScrollViewDelegateDecorator do some thing");
    if ([self.target respondsToSelector:@selector(scrollViewDidScroll:)]) {
        [self.target scrollViewDidScroll:scrollView];
    }
}

-(BOOL)respondsToSelector:(SEL)aSelector {
    if (aSelector == @selector(scrollViewDidScroll:)) {
        return YES;
    }
    return [self.target respondsToSelector:aSelector];
}

@end


@implementation UIScrollView (Decorator)

+ (void)startSwizzle {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        d_swizzle_instance_method([self class], @selector(setDelegate:), @selector(d_setSDelegate:));
    });
}

- (void)setDecorator:(id)object {
    objc_setAssociatedObject(self, @selector(decorator), object, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)decorator {
    return objc_getAssociatedObject(self, @selector(decorator));
}

- (void)d_setSDelegate:(id)delegate {

    if (delegate == nil || [object_getClass(delegate) isKindOfClass:object_getClass([DScrollViewDelegateDecorator class])]) {
        self.decorator = delegate;
        [self d_setSDelegate:delegate];
        return;
    }

    DWeakSelf;
    DScrollViewDelegateDecorator *decorator = [DScrollViewDelegateDecorator weakDecoratorWithTarget:delegate notifyBlock:^{
        DStrongSelf;
        self.decorator = nil;
        [self d_setSDelegate:nil];
    }];
    self.decorator = decorator;
    [self d_setSDelegate:decorator];
}

@end
