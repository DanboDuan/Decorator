//  Created by bob on 2019/1/15.
//

#import "UITableView+Decorator.h"
#import <objc/runtime.h>
#import "DSwizzle.h"


@interface DTableViewDelegateDecorator() <UITableViewDelegate>

@end

@implementation DTableViewDelegateDecorator

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // do some thing
    NSLog(@"TableViewDelegateDecorator do some thing");
    if ([self.target respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
        [self.target tableView:tableView didSelectRowAtIndexPath:indexPath];
    }
}

@end

@implementation UITableView (Decorator)

+ (void)startSwizzle {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        d_swizzle_instance_method([self class], @selector(setDelegate:), @selector(d_setTDelegate:));
    });
}

- (void)d_setTDelegate:(id)delegate {

    if (delegate == nil || [object_getClass(delegate) isKindOfClass:object_getClass([DTableViewDelegateDecorator class])] ) {
        self.decorator = delegate;
        [self d_setTDelegate:delegate];
        return;
    }

    DTableViewDelegateDecorator *decorator = [[DTableViewDelegateDecorator alloc] initWithTarget:delegate];
    self.decorator = decorator;
    [self d_setTDelegate:decorator];
}

@end
