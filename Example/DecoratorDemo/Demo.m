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
#import "UIActionSheet+Decorator.h"

@implementation Demo

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
#pragma clang diagnostic ignored "-Wprotocol"
#pragma clang diagnostic ignored "-Wincomplete-implementation"
#pragma clang diagnostic ignored "-Wincompatible-pointer-types"

+ (void)startDemo {
    [UIScrollView startSwizzle];
    [UITableView startSwizzle];
    [UIActionSheet startSwizzle];
}

#pragma clang diagnostic pop
@end
