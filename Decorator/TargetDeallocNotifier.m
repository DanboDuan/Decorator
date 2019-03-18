//
//  TargetDeallocNotifier.m
//  Decorator
//
//  Created by bob on 2019/3/18.
//

#import "TargetDeallocNotifier.h"

@interface TargetDeallocNotifier ()

@property (nonatomic, copy) dispatch_block_t block;

@end

@implementation TargetDeallocNotifier

- (instancetype)initWithBlock:(dispatch_block_t)block {
    NSCAssert(block, @"should not be nil");
    
    self = [super init];
    if (self) {
        self.block = block;
    }

    return self;
}

- (void)dealloc {
    if (self.block) {
        self.block();
    }
}

@end
