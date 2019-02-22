//  Created by bob on 2019/1/25.
//  Copyright © 2019 ByteDance. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PageVCDelegateAndDataSource : NSObject<UIPageViewControllerDataSource,UIPageViewControllerDelegate>

@property (nonatomic, strong) NSArray *vcs;

@end

NS_ASSUME_NONNULL_END
