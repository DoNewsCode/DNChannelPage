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
- (void)channelView:(DNCPChannelView *)channelView didSelectRowAtIndex:(NSInteger)index;

@optional


@end

@interface DNCPChannelView : UIView

/// 数据源，默认为DNCPChannelPageView
@property (nonatomic, weak) id<DNCPChannelViewDataSource> dataSource;
/// 代理，默认为DNCPChannelPageView
@property (nonatomic, weak) id<DNCPChannelViewDelegate> delegate;
/// 上一个序号
@property (nonatomic, assign) NSInteger previousIndex;
/// 当前序号
@property (nonatomic, assign) NSInteger currentIndex;
/// 数据
@property (nonatomic, strong) NSArray *items;


- (instancetype)initWithFrame:(CGRect)frame dataSource:(id<DNCPChannelViewDataSource> __nullable)dataSource;

/// 设置内容（子类通过重写此方法进行内容填充）
- (void)createContent;

/// 设置选中的Index
/// @param selectedIndex 选中的Index
- (void)proceseSelectedIndex:(NSInteger)selectedIndex;


/// 同步item切换的过程
/// @param fromIndex 出发的index
/// @param toIndex 到达的index
/// @param progress 进度
- (void)processChannelSwitchFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex progress:(CGFloat)progress;

@end

NS_ASSUME_NONNULL_END
