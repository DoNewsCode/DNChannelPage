//
//  DNCPChannelPageView.m
//  DNChannelPage
//
//  Created by Ming on 2020/2/20.
//

#import "DNCPChannelPageView.h"
#import "UIView+CTLayout.h"

@interface DNCPChannelPageView ()<DNCPChannelViewDataSource,DNCPChannelViewDelegate,DNCPPageViewDataSource,DNCPPageViewDelegate>

@end

@implementation DNCPChannelPageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

#pragma mark - Init
- (instancetype)initWithFrame:(CGRect)frame viewController:(UIViewController *)viewController channelView:(DNCPChannelView *)channelView dataSource:(id<DNCPChannelPageViewDataSource>)dataSource {
    self = [super initWithFrame:frame];
    if (self) {
        self.channelView = channelView;
        self.dataSource = dataSource;
        CGRect pageViewFrame = (CGRect){0.,channelView.ct_height,frame.size.width,frame.size.height - channelView.ct_height};
        DNCPPageView *pageView = [[DNCPPageView alloc] initWithFrame:pageViewFrame dataSource:self];
        self.pageView = pageView;
        [self initialization];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame viewController:(UIViewController *)viewController channelView:(DNCPChannelView *)channelView pageView:(DNCPPageView *)pageView dataSource:(id<DNCPChannelPageViewDataSource>)dataSource {
    self = [super initWithFrame:frame];
    if (self) {
        self.channelView = channelView;
        self.dataSource = dataSource;
        self.pageView = pageView;
        
    }
    return self;
}


/// 初始化
- (void)initialization {
    self.backgroundColor = [UIColor yellowColor];
    if (self.pageView == nil) {//若无PageView则地洞添加一个PageView
        CGRect pageViewFrame = (CGRect){0.,self.channelView.ct_height,self.frame.size.width,self.frame.size.height - self.channelView.ct_height};
        DNCPPageView *pageView = [[DNCPPageView alloc] initWithFrame:pageViewFrame dataSource:self];
        self.pageView = pageView;
    }
    [self addSubview:self.channelView];
    [self addSubview:self.pageView];
    self.channelView.dataSource = self;
    self.channelView.delegate = self;
    self.pageView.dataSource = self;
    self.pageView.delegate = self;
}

#pragma mark - Public Methods
- (void)proceseSelectedIndex:(NSInteger)selectedIndex {
    [self.channelView proceseSelectedIndex:selectedIndex];
}

- (__kindof UIViewController<DNCPPageChildViewControllerDelegate> *)dequeueReusableCellWithReuseIdentifier:(NSString *)identifier forIndex:(NSInteger)index {
    if (self.pageView) {
        return [self.pageView dequeueReusableCellWithReuseIdentifier:identifier forIndex:index];
    }
    return nil;
}

#pragma mark - DNCPChannelViewDataSource
- (NSArray *)itemsInChannelView:(DNCPChannelView *)channelView {
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(itemsInChannelPageView:)]) {
        return [self.dataSource itemsInChannelPageView:self];
    }
    return nil;
}

#pragma mark - DNCPChannelViewDelegate
- (void)channelView:(DNCPChannelView *)channelView didSelectRowAtIndex:(NSInteger)index {
    [self.pageView processPageContentOffset:CGPointMake(self.pageView.bounds.size.width * index, 0.0) animated:YES];
    if (self.delegate && [self.delegate respondsToSelector:@selector(channelPageView:didSelectRowAtIndex:)]) {
        [self.delegate channelPageView:self didSelectRowAtIndex:index];
    }
}

#pragma mark - DNCPPageViewDataSource
- (NSInteger)numberOfRowsInPageView:(DNCPPageView *)pageView {
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(itemsInChannelPageView:)]) {
        return [self.dataSource itemsInChannelPageView:self].count;
    }
    return 0;
}

- (UIViewController<DNCPPageChildViewControllerDelegate> *)pageView:(DNCPPageView *)pageView childViewControllerForRowAtIndex:(NSInteger)index {
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(channelPageView:childViewControllerForRowAtIndex:)]) {
        return [self.dataSource channelPageView:self childViewControllerForRowAtIndex:index];
    }
    return nil;
}

#pragma mark - DNCPPageViewDelegate
- (void)pageView:(DNCPPageView *)pageView scrollViewDidMoveFormIndex:(NSInteger)formIndex toIndex:(NSInteger)toIndex progress:(CGFloat)progress {
    [self.channelView processChannelSwitchFromIndex:formIndex toIndex:toIndex progress:progress];
//    NSLog(@"scrollViewDidMoveFormIndex:%ld toIndex:%ld progress:%f",(long)formIndex,(long)toIndex,progress);
}

- (void)pageView:(DNCPPageView *)pageView scrollViewDidEndDeceleratingAtIndex:(NSInteger)index {
    self.channelView.currentIndex = index;
    if (self.delegate && [self.delegate respondsToSelector:@selector(channelPageView:didEndDeceleratingBecomeDisplayAtIndex:viewController:)]) {
        [self.delegate channelPageView:self didEndDeceleratingBecomeDisplayAtIndex:index viewController:self.pageView.currentPageChildViewController];
    }
}

- (void)pageView:(DNCPPageView *)pageView willDisplayPageChildViewController:(UIViewController<DNCPPageChildViewControllerDelegate> *)pageChildViewController {
    if (self.delegate && [self.delegate respondsToSelector:@selector(channelPageView:willDisplayPageChildViewController:)]) {
           [self.delegate channelPageView:self willDisplayPageChildViewController:pageChildViewController];
       }
}

- (BOOL)pageView:(DNCPPageView *)pageView scrollPageController:(UIViewController *)scrollPageController contentScrollView:(DNCPPageCollectionView *)scrollView shouldBeginPanGesture:(UIPanGestureRecognizer *)panGesture {
    if (self.delegate && [self.delegate respondsToSelector:@selector(channelPageView:scrollPageController:contentScrollView:shouldBeginPanGesture:)]) {
        return [self.delegate channelPageView:self scrollPageController:scrollPageController contentScrollView:scrollView shouldBeginPanGesture:panGesture];
    }
    return YES;
}

- (void)setParentViewController:(UIViewController *)parentViewController {
    _parentViewController = parentViewController;
    if (self.pageView) {
        self.pageView.parentViewController = parentViewController;
    }
}

@end
