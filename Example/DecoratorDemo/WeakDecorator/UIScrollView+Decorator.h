//  Created by bob on 2019/1/15.
//

#import <UIKit/UIKit.h>
#import <Decorator/WeakDecorator.h>

//hook UIScrollView 的 delegate的相关方法

NS_ASSUME_NONNULL_BEGIN

@interface DScrollViewDelegateDecorator: WeakDecorator


@end

@interface UIScrollView (Decorator)

@property (nonatomic, strong) DScrollViewDelegateDecorator *decorator;

+ (void)startSwizzle;

@end

NS_ASSUME_NONNULL_END
