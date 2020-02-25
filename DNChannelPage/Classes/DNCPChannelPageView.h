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


@end

@interface DNCPChannelPageView : UIView

@property (nonatomic, weak) id<DNCPChannelPageViewDataSource> dataSource;
@property (nonatomic, weak) id<DNCPChannelViewDelegate> delegate;

@property (nonatomic, strong) DNCPChannelView *channelView;
@property (nonatomic, strong) DNCPPageView *pageView;

@property (nonatomic, weak) UIViewController *parentViewController;

- (instancetype)initWithFrame:(CGRect)frame viewController:(UIViewController *)viewController channelView:(DNCPChannelView *)channelView dataSource:(id<DNCPChannelPageViewDataSource>)dataSource;

- (instancetype)initWithFrame:(CGRect)frame viewController:(UIViewController *)viewController channelView:(DNCPChannelView *)channelView pageView:(DNCPPageView *)pageView dataSource:(id<DNCPChannelPageViewDataSource>)dataSource;

@end

NS_ASSUME_NONNULL_END
