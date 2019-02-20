//
//  StrongDecorator.h
//  Decorator
//
//  Created by bob on 2019/2/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface StrongDecorator : NSProxy

@property (nonatomic, strong, readonly) id target;

- (instancetype)initWithTarget:(id)target;


@end

NS_ASSUME_NONNULL_END
