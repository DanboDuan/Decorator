//
//  PureDecorator.m
//  Decorator
//
//  Created by bob on 2019/2/21.
//

#import "PureDecorator.h"

@implementation PureDecorator

- (Class)class {
    return [self.target class];
}

- (BOOL)isProxy {
    return NO;
}

@end
