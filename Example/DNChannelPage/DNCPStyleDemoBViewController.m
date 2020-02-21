//
//  DNCPStyleDemoBViewController.m
//  DNChannelPage_Example
//
//  Created by Ming on 2020/2/19.
//  Copyright © 2020 418589912@qq.com. All rights reserved.
//

#import "DNCPStyleDemoBViewController.h"

#import "DNCPStyleDemoBChannelView.h"
#import "DNCPChannelPageView.h"
#import "DNCPStyleDemoBPageView.h"

@interface DNCPStyleDemoBViewController ()

@property (nonatomic, strong) NSArray *pages;

@end

@implementation DNCPStyleDemoBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"StyleDemoB";
    [self createContent];
}

- (void)createContent {
    self.pages = @[@"新鲜事",@"相册",@"日志"];
    
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
