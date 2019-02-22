//  Created by bob on 2019/1/20.
//

#import <Foundation/Foundation.h>
#import "Decorator.h"
NS_ASSUME_NONNULL_BEGIN

@interface WeakDecorator : Decorator

- (instancetype)initWithTarget:(id)target;

@end

NS_ASSUME_NONNULL_END
