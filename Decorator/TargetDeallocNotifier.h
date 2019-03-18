//
//  TargetDeallocNotifier.h
//  Decorator
//
//  Created by bob on 2019/3/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TargetDeallocNotifier : NSObject

- (instancetype)initWithBlock:(dispatch_block_t)block;

@end

NS_ASSUME_NONNULL_END
