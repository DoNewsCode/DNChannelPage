//
//  DNCPPageView.m
//  DNChannelPage
//
//  Created by Ming on 2020/2/20.
//

#import "DNCPPageView.h"

#import "DNCPPageCollectionViewCell.h"

#import "UIView+CTLayout.h"

static NSString *cellIdentifier = @"DNCPPageViewCell";

@interface DNCPPageView ()<UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>

@end

@implementation DNCPPageView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame dataSource:(id<DNCPPageViewDataSource>)dataSource
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor redColor];
        self.dataSource = dataSource;
        [self addSubview:self.pageCollectionView];
    }
    return self;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(numberOfRowsInPageView:)]) {
        return [self.dataSource numberOfRowsInPageView:self];
    }
    return 0;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DNCPPageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
       // 移除subviews 避免重用内容显示错误
       [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    if (indexPath.row == 0) {
        cell.backgroundColor = [UIColor grayColor];
    }else {
        cell.backgroundColor = [UIColor yellowColor];
    }
       return cell;
}

#pragma mark - UICollectionViewDelegate

#pragma mark - UIScrollViewDelegate

- (DNCPPageCollectionView *)pageCollectionView {
    if (!_pageCollectionView) {
        DNCPPageCollectionView *pageCollectionView = [[DNCPPageCollectionView alloc] initWithFrame:self.bounds collectionViewLayout:self.pageCollectionViewFlowLayout];
        [pageCollectionView setBackgroundColor:[UIColor clearColor]];
        if (@available(iOS 11.0, *)) {
            pageCollectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        pageCollectionView.bounces = YES;
        pageCollectionView.delegate = self;
        pageCollectionView.dataSource = self;
        pageCollectionView.scrollsToTop = NO;
        pageCollectionView.pagingEnabled = YES;
        pageCollectionView.showsHorizontalScrollIndicator = NO;
        [pageCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellIdentifier];
        _pageCollectionView = pageCollectionView;
    }
    return _pageCollectionView;
}

- (DNCPPageCollectionViewFlowLayout *)pageCollectionViewFlowLayout {
    if (!_pageCollectionViewFlowLayout) {
        DNCPPageCollectionViewFlowLayout *pageCollectionViewFlowLayout = [[DNCPPageCollectionViewFlowLayout alloc] init];
        pageCollectionViewFlowLayout.itemSize = self.bounds.size;
        pageCollectionViewFlowLayout.minimumLineSpacing = 0.0;
        pageCollectionViewFlowLayout.minimumInteritemSpacing = 0.0;
        pageCollectionViewFlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _pageCollectionViewFlowLayout = pageCollectionViewFlowLayout;
    }
    return _pageCollectionViewFlowLayout;
}

@end
