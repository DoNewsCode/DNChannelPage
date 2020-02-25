//
//  DNCPChannelView.m
//  DNChannelPage
//
//  Created by Ming on 2020/2/20.
//

#import "DNCPChannelView.h"

#import "UIView+CTLayout.h"

@implementation DNCPChannelView


#pragma mark - Override Methods
- (instancetype)initWithFrame:(CGRect)frame 
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blueColor];
    }
    return self;
}


#pragma mark - Intial Methods
- (instancetype)initWithFrame:(CGRect)frame dataSource:(id<DNCPChannelViewDataSource> __nullable)dataSource {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor redColor];
        self.dataSource = dataSource;
        
    }
    return self;
}

/// 初始化
- (void)initialization {
    
}

#pragma mark - Create Methods
- (void)createContent {
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(itemsInChannelView:)]) {
        self.items = [self.dataSource itemsInChannelView:self];
    }
    if (self.items == nil) {//数据校验
    NSAssert(NO, @"itemsInChannelView:不可返回为空");
    }
}

#pragma mark - Process Methods

#pragma mark - Event Methods

#pragma mark - Public Methods
- (void)processChannelSwitchFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex progress:(CGFloat)progress {
    NSAssert(NO, @"请在子类重写 processChannelSwitchFromIndex:toIndex:progress ");
}

- (void)proceseSelectedIndex:(NSInteger)selectedIndex {
    NSAssert(NO, @"请在子类重写 proceseSelectedIndex ");
}

#pragma mark - Setter Methods
- (void)setDataSource:(id<DNCPChannelViewDataSource>)dataSource {
    BOOL first = dataSource && _dataSource != dataSource;
    _dataSource = dataSource;
    if (first) {//保证数据在不为空不更换情况下只通过数据源填充一次
        [self createContent];
    }
}

- (void)setCurrentIndex:(NSInteger)currentIndex {
    _currentIndex = currentIndex;
}

- (void)setPreviousIndex:(NSInteger)previousIndex {
    _previousIndex = previousIndex;
}

#pragma mark - LazyLoad Methods

@end
