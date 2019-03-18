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

+ (instancetype)weakDecoratorWithTarget:(id)target notifyBlock:(dispatch_block_t)block;

+ (instancetype)strongDecoratorWithTarget:(id)target;

@end

NS_ASSUME_NONNULL_END
