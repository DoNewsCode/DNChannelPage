//
//  DNCPChannelView.h
//  DNChannelPage
//
//  Created by Ming on 2020/2/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class DNCPChannelView;
@protocol DNCPChannelViewDataSource <NSObject>

@required
- (NSArray *)itemsInChannelView:(DNCPChannelView *)channelView;

@optional


@end

@protocol DNCPChannelViewDelegate <NSObject>

@required

@optional


@end

@interface DNCPChannelView : UIView

@property (nonatomic, weak) id<DNCPChannelViewDataSource> dataSource;
@property (nonatomic, weak) id<DNCPChannelViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
