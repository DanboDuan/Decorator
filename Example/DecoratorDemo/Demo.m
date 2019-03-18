//
//  Demo.m
//  DecoratorDemo
//
//  Created by bob on 2019/2/22.
//  Copyright © 2019 bob. All rights reserved.
//

#import "Demo.h"
#import "UIScrollView+Decorator.h"
#import "UITableView+Decorator.h"

@implementation Demo

+ (void)startDemo {
    [UIScrollView startSwizzle];
    [UITableView startSwizzle];
}

@end
