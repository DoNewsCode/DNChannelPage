//
//  DNCPViewController.m
//  DNChannelPage
//
//  Created by 418589912@qq.com on 02/19/2020.
//  Copyright (c) 2020 418589912@qq.com. All rights reserved.
//

#import "DNCPViewController.h"
#import "DNCPStyleDemoBViewController.h"
#import "DNCPStyleDemoAViewController.h"
#import "DNCPStyleDemoCViewController.h"

static NSString *cellIdentifier = @"DNCPViewControllerCell";

@interface DNCPViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *pages;

@end

@implementation DNCPViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"DNChannelPage";
    self.pages = @[@"Page:StyleDemoA",@"Page:StyleDemoB",@"Page:StyleDemoC"];
    [self createContent];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createContent {
    [self.view addSubview:self.tableView];
    
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

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
         [self.navigationController pushViewController:[DNCPStyleDemoAViewController new] animated:YES];
    } else if (indexPath.row == 1) {
        [self.navigationController pushViewController:[DNCPStyleDemoBViewController new] animated:YES];
    } else if (indexPath.row == 2) {
        [self.navigationController pushViewController:[DNCPStyleDemoCViewController new] animated:YES];
    } else if (indexPath.row == 3) {
        [self.navigationController pushViewController:[DNCPStyleDemoAViewController new] animated:YES];
    }
   
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

@end
