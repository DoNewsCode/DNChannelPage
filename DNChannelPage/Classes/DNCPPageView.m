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


@property (nonatomic, strong) NSMutableDictionary *pageChildViewControllerDictionary;
@property (nonatomic, getter=isMultipleLoadPageChildViewController) BOOL multipleLoadPageChildViewController;

/// 禁止触摸调整位置，通常在点击标题或通过外界设置PageViewIndex时置为YES以禁用触摸位置调整
@property (nonatomic, getter=isForbidTouchToAdjustPosition) BOOL forbidTouchToAdjustPosition;

@end

@implementation DNCPPageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame dataSource:(id<DNCPPageViewDataSource>)dataSource
{
    self = [super initWithFrame:frame];
    if (self) {
        self.dataSource = dataSource;
        [self addSubview:self.pageCollectionView];
        [self createObserver];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)createObserver {
    //监听内存警告
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(processDidReceiveMemoryWarningNotification:) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
    
}

///  处理内存警告
- (void)processDidReceiveMemoryWarningNotification:(NSNotificationCenter *)notificationCenter {
    /// 释放除当前控制器之外的所有控制器
    __weak typeof(self) weakSelf = self;
    [self.pageChildViewControllerDictionary enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key,UIViewController<DNCPPageChildViewControllerDelegate> * _Nonnull childViewController, BOOL * _Nonnull stop) {
        __strong typeof(self) stringSelf = weakSelf;
        if (stringSelf) {
            if (childViewController != stringSelf.currentPageChildViewController) {
                
                [stringSelf.pageChildViewControllerDictionary removeObjectForKey:key];
                [stringSelf removeChildViewController:childViewController];
            }
        }
    }];
}

//移除控件中子控制器
- (void)removeChildViewController:(UIViewController *)childViewController {
    [childViewController willMoveToParentViewController:nil];
    [childViewController.view removeFromSuperview];
    [childViewController removeFromParentViewController];
}

#pragma mark - Public Methods
- (void)processPageContentOffset:(CGPoint)contentOffset animated:(BOOL)animated {
    self.forbidTouchToAdjustPosition = YES;
    NSInteger currentIndex = contentOffset.x / self.pageCollectionView.bounds.size.width;
    self.previousIndex = currentIndex;
    self.currentIndex = currentIndex;
    if (animated == NO) { // 不需要动画则直接设置 pageCollectionView 的 ContentOffset
        [self.pageCollectionView setContentOffset:contentOffset animated:animated];
        return;
    }
    
    CGFloat delta = contentOffset.x - self.pageCollectionView.contentOffset.x;
    NSInteger pageCount = fabs(delta)/self.pageCollectionView.bounds.size.width;
    if (pageCount >= 2) {// 需要滚动两页以上的时候, 跳过中间页的动画
        __weak typeof(self) weakSelf = self;
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            __strong typeof(weakSelf) strongSelf = weakSelf;
            if (strongSelf) {
                [strongSelf.pageCollectionView setContentOffset:contentOffset animated:NO];
            }
        }];
        return;
    }
    [self.pageCollectionView setContentOffset:contentOffset animated:animated];
    
}

- (__kindof UIViewController<DNCPPageChildViewControllerDelegate> *)dequeueReusableCellWithReuseIdentifier:(NSString *)identifier forIndex:(NSInteger)index {
    return [self.pageChildViewControllerDictionary valueForKey:[NSString stringWithFormat:@"%ld",(long)index]];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {//开始滚动
    if (self.forbidTouchToAdjustPosition || // 点击标题滚动
        scrollView.contentOffset.x <= 0 ||  // first or last
        scrollView.contentOffset.x >= scrollView.contentSize.width - scrollView.bounds.size.width) {
        return;
    }
    CGFloat tempProgress = scrollView.contentOffset.x / self.bounds.size.width;
    NSInteger tempIndex = tempProgress;
    
    CGFloat progress = tempProgress - floor(tempProgress);
    NSInteger deltaX = scrollView.contentOffset.x - self.previousContentOffset.x;
    if (deltaX > 0) { //向右➡️
        if (progress == 0.0) return;
        
        self.currentIndex = tempIndex + 1;
        self.previousIndex = tempIndex;
    } else if (deltaX < 0){// 向左⬅️
        progress = 1.0 - progress;
        self.previousIndex = tempIndex + 1;
        self.currentIndex = tempIndex;
        
    } else{
        return;
    }
    self.previousContentOffset = scrollView.contentOffset;
    if (self.delegate && [self.delegate respondsToSelector:@selector(pageView:scrollViewDidMoveFormIndex:toIndex:progress:)]) {
        [self.delegate pageView:self scrollViewDidMoveFormIndex:self.previousIndex toIndex:self.currentIndex progress:progress];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {//将要开始拖拽
    // 在将要开始拖拽时重置触摸交互标记并设置previousIndex
    self.previousIndex = scrollView.contentOffset.x / self.bounds.size.width;
    self.forbidTouchToAdjustPosition = NO;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {//已经停止拖拽
    //   UINavigationController *navigationController = (UINavigationController *)self.parentViewController.parentViewController;
    //   if ([navigationController isKindOfClass:[UINavigationController class]] &&
    //       navigationController.interactivePopGestureRecognizer) {
    //       navigationController.interactivePopGestureRecognizer.enabled = YES;
    //   }
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {//开始减速
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {//停止减速
    NSInteger currentIndex = (scrollView.contentOffset.x / self.bounds.size.width);
    if (self.delegate && [self.delegate respondsToSelector:@selector(pageView:scrollViewDidEndDeceleratingAtIndex:)]) {
        [self.delegate pageView:self scrollViewDidEndDeceleratingAtIndex:currentIndex];
    }
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

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
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    [self processWillDisplayCell:cell forItemAtIndexPath:indexPath];
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    [self processDidEndDisplayingCell:cell forItemAtIndexPath:indexPath];
}

#pragma mark - Process Methods
- (void)processWillDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.dataSource == nil || [self.dataSource respondsToSelector:@selector(pageView:childViewControllerForRowAtIndex:)] == NO) {//数据源校验
        NSAssert(NO, @"必须设置数据源并实现实现数据源方法");
    }
    self.currentPageChildViewController = nil;
    UIViewController<DNCPPageChildViewControllerDelegate> *currentPageChildViewController = [self.dataSource pageView:self childViewControllerForRowAtIndex:indexPath.row];
    
    if (currentPageChildViewController == nil) {//控制器校验
        NSAssert(NO, @"pageView:childViewControllerForRowAtIndex:不可返回为空");
        if ([currentPageChildViewController conformsToProtocol:@protocol(DNCPPageChildViewControllerDelegate)] == NO) {
            NSAssert(NO, @"子控制器必须遵守DNCPPageChildViewControllerDelegate协议");
        }
        // 这里建立子控制器和父控制器的关系
        if ([currentPageChildViewController isKindOfClass:[UINavigationController class]]) {
            NSAssert(NO, @"不要添加UINavigationController包装后的子控制器");
        }
        
    }
    self.currentPageChildViewController = currentPageChildViewController;
    if (self.currentPageChildViewController != [self.pageChildViewControllerDictionary valueForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]]) {
        [self.pageChildViewControllerDictionary setValue:self.currentPageChildViewController forKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
        
    }
    if ([self.parentViewController.childViewControllers containsObject:self.currentPageChildViewController] == NO) {
        [self.parentViewController addChildViewController:self.currentPageChildViewController];
        self.currentPageChildViewController.view.frame = self.bounds;
    }
    
    // TODO 控制器index和控制器扩展方法 @implementation UIViewController (DNPageController) mm_scrollViewController
    // 通知代理
    if (self.delegate && [self.delegate respondsToSelector:@selector(pageView:willDisplayPageChildViewController:)]) {
        [self.delegate pageView:self willDisplayPageChildViewController:self.currentPageChildViewController];
    }
    
    [cell.contentView addSubview:self.currentPageChildViewController.view];
    [self.currentPageChildViewController didMoveToParentViewController:self.parentViewController];
    
    if (self.isMultipleLoadPageChildViewController) {// TODO 处理首次加载控制器的生命周期方法
        self.multipleLoadPageChildViewController = YES;
        [self processFirstLoadViewController];
    }
}

- (void)processFirstLoadViewController {
    
}

- (void)processDidEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    // 该方法主要用于生命周期管理
    if (self.currentIndex == indexPath.row) {// 没有滚动完成
        
    } else {
        if (self.previousIndex == indexPath.row) {// 滚动完成
            
        } else { // 滚动没有完成又快速反向打开另一页
            
        }
    }
}

#pragma mark - LazyLoad Methods
- (void)setParentViewController:(UIViewController *)parentViewController {
    _parentViewController = parentViewController;
    UINavigationController *navi = (UINavigationController *)self.parentViewController.parentViewController;
    
    if ([navi isKindOfClass:[UINavigationController class]]) {
        if (navi.viewControllers.count == 1) return;
        
        if (navi.interactivePopGestureRecognizer) {
            
            __weak typeof(self) weakSelf = self;
            [self.pageCollectionView returnScrollViewShouldBeginPanGestureHandler:^BOOL(DNCPPageCollectionView * _Nonnull collectionView, UIPanGestureRecognizer * _Nonnull panGesture) {
                CGFloat transionX = [panGesture translationInView:panGesture.view].x;
                               if (collectionView.contentOffset.x == 0 && transionX > 0) {
                                   navi.interactivePopGestureRecognizer.enabled = YES;
                               } else {
                                   navi.interactivePopGestureRecognizer.enabled = NO;
                               
                               }
                               
                               if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(pageView:scrollPageController:contentScrollView:shouldBeginPanGesture:)]) {
                                   return [weakSelf.delegate pageView:self scrollPageController:weakSelf.parentViewController contentScrollView:weakSelf.pageCollectionView shouldBeginPanGesture:panGesture];
                               } else {
                                   return YES;
                               }
            }];
            
        }
    }
}

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

-(NSMutableDictionary<NSString *,UIViewController<DNCPPageChildViewControllerDelegate> *> *)pageChildViewControllerDictionary {
    if (!_pageChildViewControllerDictionary) {
        NSMutableDictionary *pageChildViewControllerDictionary = [NSMutableDictionary dictionary];
        _pageChildViewControllerDictionary = pageChildViewControllerDictionary;
    }
    return _pageChildViewControllerDictionary;
}

@end
