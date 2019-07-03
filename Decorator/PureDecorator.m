//
//  PureDecorator.m
//  Decorator
//
//  Created by bob on 2019/2/21.
//

#import "PureDecorator.h"

@implementation PureDecorator

- (Class)class {
    if (self.target) {
        return [self.target class];
    }

    return [super class];
}

- (BOOL)isProxy {
    return NO;
}

@end
