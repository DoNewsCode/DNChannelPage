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


@end

@interface DNCPPageView : UIView

/// pageView的数据源
@property (nonatomic, weak) id<DNCPPageViewDataSource> dataSource;
@property (nonatomic, weak) id<DNCPPageViewDelegate> delegate;

@property (nonatomic, strong) DNCPPageCollectionView *pageCollectionView;
@property (nonatomic, strong) DNCPPageCollectionViewFlowLayout *pageCollectionViewFlowLayout;


- (instancetype)initWithFrame:(CGRect)frame dataSource:(id<DNCPPageViewDataSource>)dataSource;

@end

NS_ASSUME_NONNULL_END
