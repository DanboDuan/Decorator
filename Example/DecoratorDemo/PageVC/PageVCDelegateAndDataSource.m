//  Created by bob on 2019/1/25.
//  Copyright © 2019 ByteDance. All rights reserved.
//

#import "PageVCDelegateAndDataSource.h"

@implementation PageVCDelegateAndDataSource

- (instancetype)init {
    self = [super init];
    if (self) {
        NSMutableArray *vcs = [NSMutableArray arrayWithCapacity:4];
        for (NSUInteger index = 0; index < 6; index ++) {
            UIViewController *vc = [UIViewController new];
            vc.view.backgroundColor = [UIColor whiteColor];
            UILabel *label = [[UILabel alloc] initWithFrame:[UIScreen mainScreen].bounds];
            label.backgroundColor =[UIColor blueColor];
            label.textAlignment = NSTextAlignmentLeft;
            label.text = [NSString stringWithFormat: @"page %zd", index];
            label.backgroundColor = [UIColor greenColor];
            label.userInteractionEnabled = YES;

            UITapGestureRecognizer *labelTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelTouchUpInside:)];
            [label addGestureRecognizer:labelTapGestureRecognizer];

            [vc.view addSubview:label];
            [vcs addObject:vc];
        }
        self.vcs =vcs;
    }
    return self;
}

- (void)labelTouchUpInside:(UIGestureRecognizer *)recognizer {
    UIView *view=recognizer.view;
    NSLog(@"%@-被点击了",NSStringFromClass([view class]));
}

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSUInteger index = [self.vcs indexOfObject:viewController];
    if (index == NSNotFound || index == 0) {
        return nil;
    }
    index--;
    return [self.vcs objectAtIndex:index];
}

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSUInteger index = [self.vcs indexOfObject:viewController];
    if (index == NSNotFound) {
        return nil;
    }
    index++;
    if (index == self.vcs.count) {
        return nil;
    }
    return [self.vcs objectAtIndex:index];
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    return self.vcs.count;
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    return 0;
}

@end
