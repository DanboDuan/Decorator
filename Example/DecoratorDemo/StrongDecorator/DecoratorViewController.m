//
//  DecoratorViewController.m
//  DecoratorDemo
//
//  Created by bob on 2019/2/23.
//  Copyright © 2019 bob. All rights reserved.
//

#import "DecoratorViewController.h"
#import <Decorator/StrongDecorator.h>

@interface  AppearanceDecorator: StrongDecorator

@end

@implementation AppearanceDecorator

- (void)beginAppearanceTransition:(BOOL)isAppearing
                         animated:(BOOL)animated {
    NSLog(@"AppearanceDecorator do some thing");
    [self.target beginAppearanceTransition:isAppearing animated:animated];
}

- (void)viewWillAppear:(BOOL)animated {
    // this won't work now, maybe in the future
    [self.target viewWillAppear:animated];
}

@end

@interface DecoratorViewController ()


@end

@implementation DecoratorViewController

+ (instancetype)decoratorViewController {
    DecoratorViewController *vc = [self new];

    vc = (DecoratorViewController *)[[AppearanceDecorator alloc] initWithTarget:vc];

    return vc;
}

@end
