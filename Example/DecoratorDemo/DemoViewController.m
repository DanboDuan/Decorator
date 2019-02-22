//
//  DemoViewController.m
//  DecoratorDemo
//
//  Created by bob on 2019/2/21.
//  Copyright © 2019 bob. All rights reserved.
//

#import "DemoViewController.h"
#import "PageVCDelegateAndDataSource.h"

NSString * const CellReuseIdentifier = @"UITableViewCell_ri";


@interface BDFeedModel : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *actionVCName;
@property (nonatomic, assign) NSInteger actionVC;

@end

@implementation BDFeedModel



@end

static NSArray *testFeedList() {
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:({
        BDFeedModel *model = [BDFeedModel new];
        model.title = @"Test TableView";
        model.actionVCName = @"";
        model;
    })];

    [array addObject:({
        BDFeedModel *model = [BDFeedModel new];
        model.title = @"Test CollectionView";
        model.actionVCName = @"";
        model;
    })];

    [array addObject:({
        BDFeedModel *model = [BDFeedModel new];
        model.title = @"Test UIControl";
        model.actionVCName = @"";
        model;
    })];

    [array addObject:({
        BDFeedModel *model = [BDFeedModel new];
        model.title = @"Test ScrollView和PageControl";
        model.actionVCName = @"";
        model;
    })];

    [array addObject:({
        BDFeedModel *model = [BDFeedModel new];
        model.title = @"Test TabBarController";
        model.actionVCName = @"";
        model;
    })];

    [array addObject:({
        BDFeedModel *model = [BDFeedModel new];
        model.title = @"Test AlertVC";
        model.actionVCName = @"";
        model;
    })];

    [array addObject:({
        BDFeedModel *model = [BDFeedModel new];
        model.title = @"Test Demo";
        model.actionVCName = @"";
        model;
    })];

    [array addObject:({
        BDFeedModel *model = [BDFeedModel new];
        model.title = @"Test PageViewController";
        model.actionVCName = @"";
        model;
    })];

    [array addObject:({
        BDFeedModel *model = [BDFeedModel new];
        model.title = @"Test pure PageViewController";
        model.actionVC = 1;;
        model;
    })];

    [array addObject:({
        BDFeedModel *model = [BDFeedModel new];
        model.title = @"Test Present";
        model.actionVC = 2;;
        model;
    })];

    [array addObject:({
        BDFeedModel *model = [BDFeedModel new];
        model.title = @"Test ";
        model.actionVCName = @"";
        model;
    })];

    return array;
}

@interface DemoViewController ()

@property (nonatomic, strong) NSArray *feedList;
@property (nonatomic, strong) PageVCDelegateAndDataSource *delegateAndDataSource;

@end

@implementation DemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellReuseIdentifier];
    self.feedList = testFeedList();
    self.navigationItem.title = @"Demo";
    self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(showPickView)];
    self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc] initWithTitle:@"测试返回" style:UIBarButtonItemStylePlain target:self action:@selector(clickLeft)];
}

- (void)clickLeft {
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.feedList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellReuseIdentifier];
    if (!cell) {
        cell = [UITableViewCell new];
    }
    BDFeedModel *model = [self.feedList objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%zd: %@",(NSInteger)(indexPath.row + 1),model.title];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    NSLog(@"%zd-%zd --> %zd-%zd",sourceIndexPath.section, sourceIndexPath.row,destinationIndexPath.section, destinationIndexPath.row);
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%zd-%zd %zd",indexPath.section, indexPath.row, editingStyle);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BDFeedModel *model = [self.feedList objectAtIndex:indexPath.row];
    if (!model.actionVCName.length) {
        if (model.actionVC == 1) {
            [self showPurePageVC];
        } else if(model.actionVC == 2) {
            [self showPresent];
        }
    } else {
//        UIViewController *vc = (UIViewController *)[NSClassFromString(model.actionVCName) new];
//        vc.navigationItem.title = [model.title substringFromIndex:5];
//        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)showPresent {
    UIViewController *alertController =(UIViewController *)[NSClassFromString(@"AlertViewController") new];
    alertController.navigationItem.title = @"showPresent";
    [self.navigationController presentViewController:alertController animated:YES completion:nil];
}

- (void)showPurePageVC {
    NSDictionary *options1 = @{UIPageViewControllerOptionInterPageSpacingKey : @(10),
                               UIPageViewControllerOptionSpineLocationKey:@(UIPageViewControllerSpineLocationMid)
                               };
    UIPageViewController *pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:(UIPageViewControllerTransitionStylePageCurl) navigationOrientation:(UIPageViewControllerNavigationOrientationHorizontal) options:options1];

    self.delegateAndDataSource = [PageVCDelegateAndDataSource new];

    pageViewController.dataSource = self.delegateAndDataSource;
    pageViewController.delegate = self.delegateAndDataSource;

    [pageViewController setViewControllers:[NSArray arrayWithObjects:self.delegateAndDataSource.vcs.firstObject,[self.delegateAndDataSource.vcs objectAtIndex:1] , nil]
                                 direction:UIPageViewControllerNavigationDirectionForward
                                  animated:YES
                                completion:nil];

    pageViewController.navigationItem.title = @"showPurePageVC";
    [self.navigationController pushViewController:pageViewController animated:YES];

}

- (void)showPickView {
    static BOOL editing = NO;
    editing = !editing;
    [self.tableView setEditing:editing animated: YES];
}

@end

