//  Created by bob on 2019/1/20.
//

#import "WeakDecorator.h"

@interface WeakDecorator ()

@end

@implementation WeakDecorator

- (instancetype)initWithTarget:(id)target {
    return [self initWithTarget:target type:(DecoratorTargetTypeWeak)];
}

- (instancetype)initWithTarget:(id)target type:(DecoratorTargetType)targetType {
    return [super initWithTarget:target type:(DecoratorTargetTypeWeak)];
}

@end
