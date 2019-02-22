//
//  StrongDecorator.m
//  Decorator
//
//  Created by bob on 2019/2/20.
//

#import "StrongDecorator.h"

@interface StrongDecorator ()

@end

@implementation StrongDecorator

- (instancetype)initWithTarget:(id)target {
    return [self initWithTarget:target type:(DecoratorTargetTypeStrong)];
}

- (instancetype)initWithTarget:(id)target type:(DecoratorTargetType)targetType {
    return [super initWithTarget:target type:(DecoratorTargetTypeStrong)];
}

@end
