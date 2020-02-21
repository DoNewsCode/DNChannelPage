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

@interface DNCPChannelPageView : UIView

@property (nonatomic, strong) DNCPChannelView *channelView;
@property (nonatomic, strong) DNCPPageView *pageView;

@property (nonatomic, weak) UIViewController *presentedViewController;

@property (nonatomic, weak) id<DNCPPageViewDataSource> pageDataSource;

- (instancetype)initWithFrame:(CGRect)frame viewController:(UIViewController *)viewController channelView:(DNCPChannelView *)channelView pageDataSource:(id<DNCPPageViewDataSource>)pageDataSource;

- (instancetype)initWithFrame:(CGRect)frame viewController:(UIViewController *)viewController channelView:(DNCPChannelView *)channelView pageView:(DNCPPageView *)pageView;

@end

NS_ASSUME_NONNULL_END
