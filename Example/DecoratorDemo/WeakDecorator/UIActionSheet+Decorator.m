//
//  UIActionSheet+Decorator.m
//  DecoratorDemo
//
//  Created by bob on 2019/2/22.
//  Copyright © 2019 bob. All rights reserved.
//

#import "UIActionSheet+Decorator.h"
#import <Decorator/WeakDecorator.h>
#import <objc/runtime.h>
#import "DSwizzle.h"

@interface DActionSheetDelegateDecorator: WeakDecorator<UIActionSheetDelegate>

@end


#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
#pragma clang diagnostic ignored "-Wprotocol"
#pragma clang diagnostic ignored "-Wincomplete-implementation"
#pragma clang diagnostic ignored "-Wincompatible-pointer-types"
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"
#pragma clang diagnostic ignored "-Wdeprecated-implementations"

@implementation DActionSheetDelegateDecorator


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex  {
    // do some thing
    NSLog(@"ActionSheetDelegateDecorator do some thing");
    return [self.target actionSheet:actionSheet clickedButtonAtIndex:buttonIndex];
}

@end

@implementation UIActionSheet (Decorator)

+ (void)startSwizzle {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        d_swizzle_instance_method([self class], @selector(setDelegate:), @selector(d_setDelegate:));
    });
}

- (void)setDecorator:(id)object {
    objc_setAssociatedObject(self, @selector(decorator), object, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)decorator {
    return objc_getAssociatedObject(self, @selector(decorator));
}

- (void)d_setDelegate:(id)delegate {

    if (delegate == nil || [object_getClass(delegate) isKindOfClass:object_getClass([DActionSheetDelegateDecorator class])] ) {
        [self d_setDelegate:delegate];
        self.decorator = delegate;
        return;
    }

    DActionSheetDelegateDecorator *decorator = [[DActionSheetDelegateDecorator alloc] initWithTarget:delegate];
    self.decorator = decorator;
    [self d_setDelegate:decorator];
}

@end
#pragma clang diagnostic pop
