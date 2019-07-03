//
//  Decorator.h
//  Decorator
//
//  Created by bob on 2019/2/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Decorator : NSProxy

@property (nonatomic, readonly) id target;

+ (instancetype)weakDecoratorWithTarget:(id)target;

+ (instancetype)strongDecoratorWithTarget:(id)target;

// NSProxy do not have the methods
- (BOOL)respondsToSelector:(SEL)aSelector;
- (id)forwardingTargetForSelector:(SEL)aSelector;

@end

NS_ASSUME_NONNULL_END
