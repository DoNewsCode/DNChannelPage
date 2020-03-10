//
//  DNCPStyleDemoAPageViewController.m
//  DNChannelPage_Example
//
//  Created by Ming on 2020/2/21.
//  Copyright © 2020 418589912@qq.com. All rights reserved.
//

#import "DNCPStyleDemoAPageViewController.h"

@interface DNCPStyleDemoAPageViewController ()

@end

@implementation DNCPStyleDemoAPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor yellowColor];
}

- (void)dealloc {
    NSLog(@"dealloc---DNCPStyleDemoAPageViewController---ChannelName=%@;",self.channelName);
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
