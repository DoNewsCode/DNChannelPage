//
//  DNCPChannelPageView.h
//  DNChannelPage
//
//  Created by Ming on 2020/2/20.
//

#import <UIKit/UIKit.h>

#import "DNCPChannelView.h"
#import "DNCPPageView.h"

NS_ASSUME_NONNULL_BEGIN

@class DNCPChannelPageView;
@protocol DNCPChannelPageViewDataSource <NSObject>

@required
- (NSArray *)itemsInChannelPageView:(DNCPChannelPageView *)channelPageView;

- (UIViewController<DNCPPageChildViewControllerDelegate> *)channelPageView:(DNCPChannelPageView *)channelPageView childViewControllerForRowAtIndex:(NSInteger)index;

@optional


@end

@protocol DNCPChannelPageViewDelegate <NSObject>

@required

@optional
- (void)channelPageView:(DNCPChannelPageView *)channelPageView didSelectRowAtIndex:(NSInteger)index;

- (void)channelPageView:(DNCPChannelPageView *)channelPageView willDisplayPageChildViewController:(UIViewController<DNCPPageChildViewControllerDelegate> *)pageChildViewController;

- (void)channelPageView:(DNCPChannelPageView *)channelPageView didEndDeceleratingBecomeDisplayAtIndex:(NSInteger)index viewController:(UIViewController<DNCPPageChildViewControllerDelegate> *)viewController;
- (BOOL)channelPageView:(DNCPChannelPageView *)channelPageView scrollPageController:(UIViewController *)scrollPageController contentScrollView:(DNCPPageCollectionView *)scrollView shouldBeginPanGesture:(UIPanGestureRecognizer *)panGesture;

@end

@interface DNCPChannelPageView : UIView

@property (nonatomic, weak) id<DNCPChannelPageViewDataSource> dataSource;
@property (nonatomic, weak) id<DNCPChannelPageViewDelegate> delegate;

@property (nonatomic, strong) DNCPChannelView *channelView;
@property (nonatomic, strong) DNCPPageView *pageView;

@property (nonatomic, weak) UIViewController *parentViewController;

- (instancetype)initWithFrame:(CGRect)frame viewController:(UIViewController *)viewController channelView:(DNCPChannelView *)channelView dataSource:(id<DNCPChannelPageViewDataSource>)dataSource;

- (instancetype)initWithFrame:(CGRect)frame viewController:(UIViewController *)viewController channelView:(DNCPChannelView *)channelView pageView:(DNCPPageView *)pageView dataSource:(id<DNCPChannelPageViewDataSource>)dataSource;

- (void)proceseSelectedIndex:(NSInteger)selectedIndex;

- (__kindof UIViewController<DNCPPageChildViewControllerDelegate> *)dequeueReusableCellWithReuseIdentifier:(NSString *)identifier forIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
