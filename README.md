# Decorator

新的思路实现swizzle。

## Demo演示

1. `git clone https://github.com/DanboDuan/Decorator.git`
2. `cd Decorator/Eample`
3. `pod install`
4. `open DecoratorDemo.xcworkspace`

## 要求

* iOS 8.0+

## 使用

直接copy代码，用你的项目prefix重命名文件和类名。

1. Decorator只能拦截`[obj method]`的调用，`[self method]`的调用只能使用swizzle

## Demo代码

### hook一个delegate

1. swizzle的问题：
	1. `_cmd`参数依赖
	2. 多次hook 
	3. 当前类、父类有无同时实现该方法时，hook先后顺序问题
2. Decorator方法
	1. 只需要管理Decorator的引用问题。

### 示例

#### hook一个UIActionSheetDelegate

```Objective-C
@interface DActionSheetDelegateDecorator: WeakDecorator<UIActionSheetDelegate>
@end

@implementation DActionSheetDelegateDecorator

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex  {
    // do some thing
    NSLog(@"ActionSheetDelegateDecorator do some thing");
    return [self.target actionSheet:actionSheet clickedButtonAtIndex:buttonIndex];
}

@end

// 使用DActionSheetDelegateDecorator装饰实际的delegate
DActionSheetDelegateDecorator *decorator = [[DActionSheetDelegateDecorator alloc] initWithTarget:delegate];
UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"这是UIActionSheet" delegate:(id)decorator
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:@"确定"
                                                    otherButtonTitles:@"按钮1", @"按钮2",nil];
//保存decorator，因为delegate一般都是weak属性，需要你主动引用decorator

```
#### hook一个UITableViewDelegate
你也可以同时用swizzle配合Decorator。

```Objective-C
@interface DScrollViewDelegateDecorator: WeakDecorator<UIScrollViewDelegate>


@end
@implementation DScrollViewDelegateDecorator

#pragma mark UIScrollViewDelegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // do some thing
//    NSLog(@"DScrollViewDelegateDecorator do some thing");
    if ([self.target respondsToSelector:@selector(scrollViewDidScroll:)]) {
        [self.target scrollViewDidScroll:scrollView];
    }
}

//如果你想无论delegate是否实现这个方法都想做一点事情，就重写这个，否则不会重写
-(BOOL)respondsToSelector:(SEL)aSelector {
    if (aSelector == @selector(scrollViewDidScroll:)) {
        return YES;
    }
    return [self.target respondsToSelector:aSelector];
}

@end

//如果是同时hook了scrollView的delegate

@interface DTableViewDelegateDecorator: DScrollViewDelegateDecorator <UITableViewDelegate>

@end

@implementation DTableViewDelegateDecorator

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // do some thing
    NSLog(@"TableViewDelegateDecorator do some thing");
    [self.target tableView:tableView didSelectRowAtIndexPath:indexPath];
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
    // 引用住decorator
    self.decorator = decorator;
    [self d_setTDelegate:decorator];
}

@end

```

这需要注意的问题：

1. UITableViewDelegate继承了UIScrollViewDelegate，你也可以分两个decorator，当然也可以分一个
2. 如果分两个，DTableViewDelegateDecorator需要继承DScrollViewDelegateDecorator
3. 如果分一个，不需要继承，但是需要注意好引用住DTableViewDelegateDecorator
4. DScrollViewDelegateDecorator可以再delegate没有实现对应方法的时候也得到回调，通过`-(BOOL)respondsToSelector:(SEL)aSelector`控制，如果不想特意回调，则不需要重写。
5. 使用WeakDecorator可以避免循环引用，因为WeakDecorator没有强引用target，这个需要需要分别引用住Decorator和target

#### Strong Decorator

```Objective-C
@interface  AppearanceDecorator: StrongDecorator

@end

@implementation AppearanceDecorator

- (void)beginAppearanceTransition:(BOOL)isAppearing
                         animated:(BOOL)animated {
    NSLog(@"AppearanceDecorator do some thing");
    [self.target beginAppearanceTransition:isAppearing animated:animated];
}

- (void)viewWillAppear:(BOOL)animated {
    // this won't work now, because call from [self viewWillAppear:animated]
    [self.target viewWillAppear:animated];
}

@end

@implementation DecoratorViewController

+ (instancetype)decoratorViewController {
    DecoratorViewController *vc = [self new];

    vc = (DecoratorViewController *)[[AppearanceDecorator alloc] initWithTarget:vc];

    return vc;
}

@end

```

1. 使用Strong Decorator只需要引用住Decorator，Decorator会强引用target。
2. 如果是非PureDecorator，可以通过[decorator isProxy]和[decorator class]判断是否是decorator还是target
3. PureDecorator则完全可以混淆，无法区分

## 应用

1. Decorator可以再一定程度上达到swizzle的效果，前提是，调用方式不是`[self method]`
2. Decorator可以按需加载，比如在对象创建的时候配置decorator策略，可以无限嵌套，只要引用住该引用的target
3. 必要情况可能需要swizzle的配合


## 证书

本项目使用[MIT 证书](LICENSE)。详细内容参见[证书](LICENSE)文件。

