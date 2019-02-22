//
//  DSwizzle.m
//  DecoratorDemo
//
//  Created by bob on 2019/2/21.
//  Copyright © 2019 bob. All rights reserved.
//

#import "DSwizzle.h"
#import <objc/message.h>

void d_swizzle_instance_method(Class oriCls, SEL originalSelector, SEL targetSelector) {
    Method swizzledMethod = class_getInstanceMethod(oriCls, targetSelector);
    Method originalMethod = class_getInstanceMethod(oriCls, originalSelector);

    BOOL oriSelectorAddMethod = class_addMethod(oriCls, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));

    if (oriSelectorAddMethod) {
        class_replaceMethod(oriCls, targetSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

void d_swizzle_class_method(Class cls, SEL originalSelector, SEL swizzledSelector) {
    Class metaClass = object_getClass(cls);
    Method originalMethod = class_getClassMethod(metaClass, originalSelector);
    Method swizzledMethod = class_getClassMethod(metaClass, swizzledSelector);

    BOOL didAddMethod = class_addMethod(metaClass,originalSelector,method_getImplementation(swizzledMethod),method_getTypeEncoding(swizzledMethod));

    if (didAddMethod) {
        class_replaceMethod(metaClass,swizzledSelector,method_getImplementation(originalMethod),method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

