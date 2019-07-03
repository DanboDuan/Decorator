//
//  AppDelegate.m
//  DecoratorDemo
//
//  Created by bob on 2019/2/20.
//  Copyright © 2019 bob. All rights reserved.
//

#import "AppDelegate.h"
#import "DemoViewController.h"
#import "Demo.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [Demo startDemo];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[DemoViewController new]];
    self.window.rootViewController = nav;
    //    self.window.rootViewController = [DemoViewController new];
    //    self.window.rootViewController = [BDTabBarController new];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
