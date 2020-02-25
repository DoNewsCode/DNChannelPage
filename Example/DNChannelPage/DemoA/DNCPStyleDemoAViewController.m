//
//  DNCPStyleDemoAViewController.m
//  DNChannelPage_Example
//
//  Created by Ming on 2020/2/19.
//  Copyright © 2020 418589912@qq.com. All rights reserved.
//

#import "DNCPStyleDemoAViewController.h"

#import "DNCPStyleDemoAChannelView.h"
#import "DNCPChannelPageView.h"
#import "DNCPStyleDemoAPageView.h"

#import "DNCPStyleDemoAPageViewController.h"

@interface DNCPStyleDemoAViewController ()<DNCPChannelPageViewDataSource>

@property (nonatomic, strong) NSArray *pages;
@property (nonatomic, strong) DNCPChannelPageView *channelPageView;
@property (nonatomic, strong) DNCPStyleDemoAChannelView *channelView;
@property (nonatomic, strong) DNCPStyleDemoAPageView *pageView;
@end

@implementation DNCPStyleDemoAViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"StyleDemoA";
    [self createContent];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {

}

- (void)createContent {
    self.pages = @[@"新鲜事",@"推荐"];
    [self.view addSubview:self.channelPageView];
}

#pragma mark - DNCPChannelPageViewDataSource
- (NSArray *)itemsInChannelPageView:(DNCPChannelPageView *)channelPageView {
    return self.pages;
}

- (UIViewController<DNCPPageChildViewControllerDelegate> *)channelPageView:(DNCPChannelPageView *)channelPageView childViewControllerForRowAtIndex:(NSInteger)index {
    DNCPStyleDemoAPageViewController *styleDemoAPageViewController = [DNCPStyleDemoAPageViewController new];
    if (index == 0) {
        styleDemoAPageViewController.view.backgroundColor = [UIColor darkGrayColor];
    } else {
        styleDemoAPageViewController.view.backgroundColor = [UIColor purpleColor];
    }
    return styleDemoAPageViewController;
}

#pragma mark - DNCPChannelPageViewDataSource

#pragma mark - Getter
- (DNCPChannelPageView *)channelPageView {
    if (!_channelPageView) {
        CGFloat height = [UIApplication sharedApplication].statusBarFrame.size.height + 44;
        DNCPChannelPageView *channelPageView = [[DNCPChannelPageView alloc] initWithFrame:CGRectMake(0, height, self.view.bounds.size.width, self.view.bounds.size.height - height) viewController:self channelView:self.channelView dataSource:self];
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
