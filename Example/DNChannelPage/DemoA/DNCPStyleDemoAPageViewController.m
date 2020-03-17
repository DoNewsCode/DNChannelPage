//
//  DNCPStyleDemoAPageViewController.m
//  DNChannelPage_Example
//
//  Created by Ming on 2020/2/21.
//  Copyright © 2020 418589912@qq.com. All rights reserved.
//

#import "DNCPStyleDemoAPageViewController.h"

#import "DNCPStyleATableView.h"

static NSString *cellIdentifier = @"DNCPStyleDemoAPageViewControllerCell";

@interface DNCPStyleDemoAPageViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) DNCPStyleATableView *tableView;

@property (nonatomic, strong) NSArray *pages;

@end

@implementation DNCPStyleDemoAPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:100];
    for (NSInteger i = 0; i < 100; i++) {
        [array addObject:[NSString stringWithFormat:@"测试文本------%ld",i]];
    }
    self.pages = array.copy;
    self.view.backgroundColor = [UIColor yellowColor];
    
    [self.view addSubview:self.tableView];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"self.navigationController = %@",self.navigationController);
}

- (void)dealloc {
    NSLog(@"dealloc---DNCPStyleDemoAPageViewController---ChannelName=%@;",self.channelName);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.pages.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
    }
    cell.textLabel.text = self.pages[indexPath.row];
    return cell;
}

#pragma mark - Getter
- (DNCPStyleATableView *)tableView {
    if (!_tableView) {
        DNCPStyleATableView *tableView = [[DNCPStyleATableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
        tableView.delegate = self;
        tableView.dataSource = self;
        _tableView = tableView;
    }
    return _tableView;
}

@end
