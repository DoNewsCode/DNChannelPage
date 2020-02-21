//
//  DNCPChannelPageView.m
//  DNChannelPage
//
//  Created by Ming on 2020/2/20.
//

#import "DNCPChannelPageView.h"
#import "UIView+CTLayout.h"

@implementation DNCPChannelPageView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame viewController:(UIViewController *)viewController channelView:(DNCPChannelView *)channelView pageDataSource:(id<DNCPPageViewDataSource>)pageDataSource {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor yellowColor];
        self.channelView = channelView;
        self.pageDataSource = pageDataSource;
        CGRect pageViewFrame = (CGRect){0.,channelView.ct_height,frame.size.width,frame.size.height - channelView.ct_height};
        DNCPPageView *pageView = [[DNCPPageView alloc] initWithFrame:pageViewFrame dataSource:pageDataSource];
        self.pageView = pageView;
        [self addSubview:self.channelView];
        [self addSubview:self.pageView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame viewController:(UIViewController *)viewController channelView:(DNCPChannelView *)channelView pageView:(DNCPPageView *)pageView {
    self = [super init];
    if (self) {
        
    }
    return self;
}

@end
