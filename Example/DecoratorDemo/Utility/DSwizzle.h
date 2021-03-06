//
//  DSwizzle.h
//  DecoratorDemo
//
//  Created by bob on 2019/2/21.
//  Copyright © 2019 bob. All rights reserved.
//

#import <Foundation/Foundation.h>

#define DWeakSelf __weak typeof(self) wself = self
#define DStrongSelf __strong typeof(wself) self = wself


NS_ASSUME_NONNULL_BEGIN

// swizzle 类的实例方法 即 -方法
extern void d_swizzle_instance_method(Class cls, SEL originalSelector, SEL swizzledSelector);

// swizzle 类的类方法，即 +方法
extern void d_swizzle_class_method(Class cls, SEL originalSelector, SEL swizzledSelector);

// swizzle delegate
extern void d_class_exchangeMethod(Class originalClass, SEL originalSel, Class replacedClass, SEL replacedSel, SEL orginReplaceSel);

NS_ASSUME_NONNULL_END
