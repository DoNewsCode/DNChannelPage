//
//  DNCPPageView.h
//  DNChannelPage
//
//  Created by Ming on 2020/2/20.
//

#import <UIKit/UIKit.h>

#import "DNCPChannelPageViewDelegate.h"

#import "DNCPPageCollectionView.h"
#import "DNCPPageCollectionViewFlowLayout.h"

NS_ASSUME_NONNULL_BEGIN

@class DNCPPageView;
@protocol DNCPPageViewDataSource <NSObject>

@required
- (NSInteger)numberOfRowsInPageView:(DNCPPageView *)pageView;

- (UIViewController<DNCPPageChildViewControllerDelegate> *)pageView:(DNCPPageView *)pageView childViewControllerForRowAtIndex:(NSInteger)index;

@optional


@end

@protocol DNCPPageViewDelegate <NSObject>

@required

@optional
- (void)pageView:(DNCPPageView *)pageView willDisplayPageChildViewController:(UIViewController<DNCPPageChildViewControllerDelegate> *)pageChildViewController;
- (void)pageView:(DNCPPageView *)pageView scrollViewDidMoveFormIndex:(NSInteger)formIndex toIndex:(NSInteger)toIndex progress:(CGFloat)progress;
- (void)pageView:(DNCPPageView *)pageView scrollViewDidEndDeceleratingAtIndex:(NSInteger)index;
- (BOOL)pageView:(DNCPPageView *)pageView scrollPageController:(UIViewController *)scrollPageController contentScrollView:(DNCPPageCollectionView *)scrollView shouldBeginPanGesture:(UIPanGestureRecognizer *)panGesture;

@end

@interface DNCPPageView : UIView

/// pageView的数据源
@property (nonatomic, weak) id<DNCPPageViewDataSource> dataSource;
@property (nonatomic, weak) id<DNCPPageViewDelegate> delegate;

@property (nonatomic, strong) DNCPPageCollectionView *pageCollectionView;
@property (nonatomic, strong) DNCPPageCollectionViewFlowLayout *pageCollectionViewFlowLayout;

/// 上一个序号
@property (nonatomic, assign) NSInteger previousIndex;
/// 当前序号
@property (nonatomic, assign) NSInteger currentIndex;
/// 上一个偏移量
@property (nonatomic, assign) CGPoint previousContentOffset;

@property (nonatomic, weak) UIViewController *parentViewController;
@property (nonatomic, strong) UIViewController<DNCPPageChildViewControllerDelegate> *__nullable currentPageChildViewController;

- (instancetype)initWithFrame:(CGRect)frame dataSource:(id<DNCPPageViewDataSource>)dataSource;

- (void)processPageContentOffset:(CGPoint)contentOffset animated:(BOOL)animated;

- (__kindof UIViewController<DNCPPageChildViewControllerDelegate> *)dequeueReusableCellWithReuseIdentifier:(NSString *)identifier forIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
