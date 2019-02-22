//
//  AlertViewController.m
//  DecoratorDemo
//
//  Created by bob on 2019/2/22.
//  Copyright © 2019 bob. All rights reserved.
//

#import "AlertViewController.h"

@interface AlertViewController ()

@end

@implementation AlertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    UIButton *button;
    button = [[UIButton alloc] initWithFrame:CGRectMake((width - 200)/2, 200, 200, 44)];
    button.backgroundColor = [UIColor redColor];
    [button setTitle:@"展示Alert" forState:(UIControlStateNormal)];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(showAlert) forControlEvents:(UIControlEventTouchUpInside)];

    button = [[UIButton alloc] initWithFrame:CGRectMake((width - 200)/2, 300, 200, 44)];
    button.backgroundColor = [UIColor redColor];
    [button setTitle:@"展示ActionSheet" forState:(UIControlStateNormal)];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(showActionSheet) forControlEvents:(UIControlEventTouchUpInside)];

    button = [[UIButton alloc] initWithFrame:CGRectMake((width - 200)/2, 400, 200, 44)];
    button.backgroundColor = [UIColor redColor];
    [button setTitle:@"展示old Alert" forState:(UIControlStateNormal)];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(oldAlert) forControlEvents:(UIControlEventTouchUpInside)];

    button = [[UIButton alloc] initWithFrame:CGRectMake((width - 200)/2, 500, 200, 44)];
    button.backgroundColor = [UIColor redColor];
    [button setTitle:@"展示old ActionSheet" forState:(UIControlStateNormal)];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(showOldActionSheet) forControlEvents:(UIControlEventTouchUpInside)];

    button = [[UIButton alloc] initWithFrame:CGRectMake((width - 200)/2, 600, 200, 44)];
    button.backgroundColor = [UIColor redColor];
    [button setTitle:@"present" forState:(UIControlStateNormal)];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(showPresent) forControlEvents:(UIControlEventTouchUpInside)];

    button = [[UIButton alloc] initWithFrame:CGRectMake((width - 200)/2, 700, 200, 44)];
    button.backgroundColor = [UIColor redColor];
    [button setTitle:@"dismiss" forState:(UIControlStateNormal)];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(showDismiss) forControlEvents:(UIControlEventTouchUpInside)];
}

- (void)showPresent {
    AlertViewController *alertController = [AlertViewController new];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)showDismiss {
    //    UIViewController *presenting = self.presentingViewController;
    //    while (presenting.presentingViewController) {
    //        presenting = presenting.presentingViewController;
    //    }
    //  presenting 优先 dismiss presentedViewController 然后才是自己
    //    [presenting dismissViewControllerAnimated:YES completion:nil];
    //  没有 presentedViewController 则是自己
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)showAlert {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Alert Title"
                                                                             message:@"The message is ...mm"
                                                                      preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"OK Action");
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"Cancel Action");
    }];

    UIAlertAction *dAction = [UIAlertAction actionWithTitle:@"Destructive" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"OK Destructive");
    }];

    [alertController addAction:okAction];
    [alertController addAction:cancelAction];
    [alertController addAction:dAction];

    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)showActionSheet {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Alert Title"
                                                                             message:@"The message is ...mm"
                                                                      preferredStyle:UIAlertControllerStyleActionSheet];

    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"OK Action");
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"Cancel Action");
    }];

    UIAlertAction *dAction = [UIAlertAction actionWithTitle:@"Destructive" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"OK Destructive");
    }];

    [alertController addAction:okAction];
    [alertController addAction:cancelAction];
    [alertController addAction:dAction];

    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
#pragma clang diagnostic ignored "-Wprotocol"
#pragma clang diagnostic ignored "-Wincomplete-implementation"
#pragma clang diagnostic ignored "-Wincompatible-pointer-types"
// 警告的内容
- (void)oldAlert {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"类别修改" message:@"修改什么？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"修改",@"test1",nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSLog(@"alertViewCancel %@ - %@",alertView.title, alertView.message);
    NSLog(@"clickedButtonAtIndex %zd",buttonIndex);
}

- (void)alertViewCancel:(UIAlertView *)alertView {
    NSLog(@"alertViewCancel %@ - %@",alertView.title, alertView.message);
}

- (void)showOldActionSheet {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"这是UIActionSheet" delegate:(id)self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:@"确定"
                                                    otherButtonTitles:@"按钮1", @"按钮2",nil];
    actionSheet.actionSheetStyle = UIBarStyleDefault;
    [actionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSLog(@"actionSheet %@",actionSheet.title);
    NSLog(@"actionSheet clickedButtonAtIndex  %zd",buttonIndex);
}



#pragma clang diagnostic pop

@end
