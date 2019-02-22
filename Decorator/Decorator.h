//
//  Decorator.h
//  Decorator
//
//  Created by bob on 2019/2/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, DecoratorTargetType) {
    DecoratorTargetTypeStrong = 1,
    DecoratorTargetTypeWeak
};

@interface Decorator : NSProxy

@property (nonatomic, strong, readonly) id target;

- (instancetype)initWithTarget:(id)target type:(DecoratorTargetType)targetType;

@end

NS_ASSUME_NONNULL_END
