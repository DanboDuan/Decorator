//  Created by bob on 2019/1/15.
//

#import <UIKit/UIKit.h>
#import "UIScrollView+Decorator.h"
//hook UITableView 的 delegate的相关方法


NS_ASSUME_NONNULL_BEGIN

@interface DTableViewDelegateDecorator: DScrollViewDelegateDecorator

@end

@interface UITableView (Decorator)

+ (void)startSwizzle;

@end

NS_ASSUME_NONNULL_END
