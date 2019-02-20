//
//  WeakDecorator.h
//  BDAutoTracker
//
//  Created by bob on 2019/1/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WeakDecorator : NSProxy

@property (nonatomic, weak, readonly) id target;

- (instancetype)initWithTarget:(id)target;

@end

NS_ASSUME_NONNULL_END
