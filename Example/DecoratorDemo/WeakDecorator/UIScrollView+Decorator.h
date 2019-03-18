//  Created by bob on 2019/1/15.
//

#import <UIKit/UIKit.h>
#import <Decorator/Decorator.h>

//hook UIScrollView 的 delegate的相关方法

NS_ASSUME_NONNULL_BEGIN

@interface DScrollViewDelegateDecorator: Decorator


@end

@interface UIScrollView (Decorator)

@property (nonatomic, strong, nullable) DScrollViewDelegateDecorator *decorator;

+ (void)startSwizzle;

@end

NS_ASSUME_NONNULL_END
