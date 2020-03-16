//
//  DNCPStyleDemoCViewController.m
//  DNChannelPage_Example
//
//  Created by Ming on 2020/3/16.
//  Copyright © 2020 418589912@qq.com. All rights reserved.
//

#import "DNCPStyleDemoCViewController.h"

#import "DNCPStyleDemoAChannelView.h"
#import "DNCPChannelPageView.h"
#import "DNCPStyleDemoAPageView.h"

#import "DNCPStyleDemoAPageViewController.h"

#import "UIView+CTLayout.h"

@interface DNCPStyleDemoCViewController ()<UITableViewDataSource,UITableViewDelegate,DNCPChannelPageViewDataSource,DNCPChannelPageViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *pages;
@property (nonatomic, strong) DNCPChannelPageView *channelPageView;
@property (nonatomic, strong) DNCPStyleDemoAChannelView *channelView;
@property (nonatomic, strong) DNCPStyleDemoAPageView *pageView;
@property (nonatomic, strong) UIView *headerView;

@end

@implementation DNCPStyleDemoCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createContent];
}

- (void)createContent {
    self.title = @"StyleDemoC";
    self.pages = @[@"新鲜事",@"推荐"];
    self.view.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.tableView];
    
}

- (void)createNavigation {
    
}

- (void)createNotifications {
    
}

- (void)createThemeChange {
    
}

#pragma mark - DNCPChannelPageViewDataSource
- (NSArray *)itemsInChannelPageView:(DNCPChannelPageView *)channelPageView {
    return self.pages;
}

- (UIViewController<DNCPPageChildViewControllerDelegate> *)channelPageView:(DNCPChannelPageView *)channelPageView childViewControllerForRowAtIndex:(NSInteger)index {
    DNCPStyleDemoAPageViewController *styleDemoAPageViewController = [channelPageView dequeueReusableCellWithReuseIdentifier:@"viewController" forIndex:index];
    if (styleDemoAPageViewController == nil) {
        styleDemoAPageViewController = [DNCPStyleDemoAPageViewController new];
        styleDemoAPageViewController.channelName = self.pages[index];
        if (index == 0) {
            styleDemoAPageViewController.view.backgroundColor = [UIColor darkGrayColor];
        } else {
            styleDemoAPageViewController.view.backgroundColor = [UIColor purpleColor];
        }
    }
    
    
    NSLog(@"childViewControllerForRowAtIndex == %ld",(long)index);
    return styleDemoAPageViewController;
}

#pragma mark - DNCPChannelPageViewDelegate
- (void)channelPageView:(DNCPChannelPageView *)channelPageView didSelectRowAtIndex:(NSInteger)index {
    NSLog(@"didSelectRowAtIndex == %ld",(long)index);
}

- (void)channelPageView:(DNCPChannelPageView *)channelPageView willDisplayPageChildViewController:(UIViewController<DNCPPageChildViewControllerDelegate> *)pageChildViewController {
    NSLog(@"willDisplayPageChildViewController");
}

- (void)channelPageView:(DNCPChannelPageView *)channelPageView didEndDeceleratingBecomeDisplayAtIndex:(NSInteger)index viewController:(UIViewController<DNCPPageChildViewControllerDelegate> *)viewController {
    NSLog(@"didEndDeceleratingBecomeDisplayAtIndex==%ld",(long)index);
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return self.headerView.ct_height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return self.channelPageView.ct_height;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return self.headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return self.channelPageView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellIdentifier"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellIdentifier"];
        
    }
    cell.textLabel.text = self.pages[indexPath.row];
    return cell;
}

- (UITableView *)tableView {
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
        tableView.delegate = self;
        tableView.dataSource = self;
        _tableView = tableView;
    }
    return _tableView;
}

- (UIView *)headerView {
    if (!_headerView) {
        UIView *headerView = [[UIView alloc] initWithFrame:(CGRect){0.,0.,self.view.ct_width,150.}];
        _headerView = headerView;
    }
    return _headerView;
}

- (DNCPChannelPageView *)channelPageView {
    if (!_channelPageView) {
        CGFloat height = [UIApplication sharedApplication].statusBarFrame.size.height + 44;
        DNCPChannelPageView *channelPageView = [[DNCPChannelPageView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - height - self.headerView.ct_height) viewController:self channelView:self.channelView dataSource:self];
        channelPageView.parentViewController = self;
        channelPageView.delegate = self;
        _channelPageView = channelPageView;
        
    }
    return _channelPageView;
}

- (DNCPStyleDemoAChannelView *)channelView {
    if (!_channelView) {
        DNCPStyleDemoAChannelView *channelView = [[DNCPStyleDemoAChannelView alloc] initWithFrame:(CGRect){0.,0.,0.,0.} dataSource:nil];
        _channelView = channelView;
    }
    return _channelView;
}

- (DNCPStyleDemoAPageView *)pageView {
    if (!_pageView) {
        DNCPStyleDemoAPageView *pageView = [[DNCPStyleDemoAPageView alloc] init];
        _pageView = pageView;
    }
    return _pageView;
}

@end
