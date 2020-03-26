//
//  DNCPStyleDemoAChannelView.m
//  DNChannelPage_Example
//
//  Created by Ming on 2020/2/20.
//  Copyright © 2020 418589912@qq.com. All rights reserved.
//

#import "DNCPStyleDemoAChannelView.h"

#import "DNCPStyleDemoAChannelItemView.h"

@interface DNCPStyleDemoAChannelView ()<UIScrollViewDelegate>

/** 缓存所有标题label */
@property (nonatomic, strong) NSMutableArray<DNCPStyleDemoAChannelItemView *> *channelViews;

@property(nonatomic, strong) UITapGestureRecognizer *backgroundTapGestureRecognizer;
// 滚动scrollView
@property (strong, nonatomic) UIScrollView *scrollView;

@property(nonatomic, strong) UIView *selectedTip;

// 用于懒加载计算文字的rgb差值, 用于颜色渐变的时候设置
@property (strong, nonatomic) NSArray *deltaRGB;
@property (strong, nonatomic) NSArray *selectedColorRGB;
@property (strong, nonatomic) NSArray *normalColorRGB;

@end

@implementation DNCPStyleDemoAChannelView



#pragma mark - Override Methods
- (instancetype)initWithFrame:(CGRect)frame dataSource:(id<DNCPChannelViewDataSource> __nullable)dataSource
{
    frame = (CGRect){0.,0.,[UIApplication sharedApplication].keyWindow.bounds.size.width,50};
    self = [super initWithFrame:frame dataSource:dataSource];
    if (self) {
    }
    return self;
}

- (void)createContent {
    [super createContent];
    self.clipsToBounds = YES;
    CGFloat lastChannelLabelMaxX = 12;
    
    for (NSInteger i = 0; i < self.items.count; i++) {
        NSString *name = self.items[i];
        
        DNCPStyleDemoAChannelItemView *titleView = [DNCPStyleDemoAChannelItemView new];
        titleView.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:17];
        if (i == 0) {
            titleView.titleLabel.textColor = [UIColor colorWithRed:50/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
            titleView.layer.anchorPoint = CGPointMake(0, 1);
        }  else if (i == self.items.count - 1) {
            
            titleView.titleLabel.textColor = [UIColor colorWithRed:50/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
            titleView.layer.anchorPoint = CGPointMake(1, 1);
        } else {
            titleView.layer.anchorPoint = CGPointMake(0.5, 1);
            titleView.titleLabel.textColor = [UIColor colorWithRed:50/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        }
        titleView.titleLabel.text = name;
        CGSize titleSize =  [titleView.titleLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : titleView.titleLabel.font} context:nil].size;
        titleSize.height -= (titleSize.height * 0.225);
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(eventChannelViewClick:)];
        [titleView addGestureRecognizer:tapGesture];
        CGFloat titleViewX = lastChannelLabelMaxX;
        titleView.frame = (CGRect){titleViewX,16,titleSize.width,titleSize.height};
        titleView.titleLabel.frame = titleView.bounds;
        lastChannelLabelMaxX += (titleView.ct_width + 37);
        
        if (i == 0) {
            titleView.transform = CGAffineTransformMakeScale(1.411765, 1.411765);
        }
        
        [self addSubview:titleView];
        [self.channelViews addObject:titleView];
        
    }
    self.selectedTip.backgroundColor = [UIColor blackColor];
    NSInteger currentIndex = self.currentIndex;
    DNCPStyleDemoAChannelItemView *itemView = self.channelViews[currentIndex];
    self.selectedTip.ct_y = CGRectGetMaxY(self.channelViews.firstObject.frame) + 4;
    self.selectedTip.ct_size = CGSizeMake(5, 5);
    self.selectedTip.layer.cornerRadius = 2.5;
    CGFloat centerX = itemView.ct_centerX;
    if (itemView.layer.anchorPoint.x == 0) {
        centerX += (itemView.ct_width * 0.5);
    } else if (itemView.layer.anchorPoint.x == 1) {
        centerX -= (itemView.ct_width * 0.5);
        
    }
    self.selectedTip.ct_centerX = centerX;
    [self addSubview:self.selectedTip];
    self.channelViews.firstObject.titleLabel.textColor = [UIColor colorWithRed:50/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    [self addGestureRecognizer:self.backgroundTapGestureRecognizer];
}

- (void)processChannelSwitchFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex progress:(CGFloat)progress {
    if (fromIndex < 0 ||
        fromIndex >= self.items.count ||
        toIndex < 0 ||
        toIndex >= self.items.count) return;
    
    self.previousIndex = toIndex;
    
    DNCPStyleDemoAChannelItemView *oldChannelView = self.channelViews[fromIndex];
    DNCPStyleDemoAChannelItemView *currentChannelView = self.channelViews[toIndex];
    
    //颜色渐变
    oldChannelView.titleLabel.textColor = [UIColor colorWithRed:[self.selectedColorRGB[0] floatValue] + [self.deltaRGB[0] floatValue] * progress
                                                          green:[self.selectedColorRGB[1] floatValue] + [self.deltaRGB[1] floatValue] * progress
                                                           blue:[self.selectedColorRGB[2] floatValue] + [self.deltaRGB[2] floatValue] * progress
                                                          alpha:1.0];
    currentChannelView.titleLabel.textColor = [UIColor colorWithRed:[self.normalColorRGB[0] floatValue] - [self.deltaRGB[0] floatValue] * progress
                                                              green:[self.normalColorRGB[1] floatValue] - [self.deltaRGB[1] floatValue] * progress
                                                               blue:[self.normalColorRGB[2] floatValue] - [self.deltaRGB[2] floatValue] * progress
                                                              alpha:1.0];
    
    CGFloat oldScale = 1.411765 - (1.411765 - 1.0) * progress;
    CGFloat currentScale = 1.0 + (1.411765 - 1.0) * progress;
    oldChannelView.transform = CGAffineTransformMakeScale(oldScale, oldScale);
    currentChannelView.transform = CGAffineTransformMakeScale(currentScale, currentScale);
    CGFloat currentChannelViewCenterX = currentChannelView.ct_centerX;
    CGFloat oldChannelViewCenterX = oldChannelView.ct_centerX;
    
    if (currentChannelView.layer.anchorPoint.x == 0) {
        currentChannelViewCenterX += (currentChannelView.ct_width * 0.5);
    } else if (currentChannelView.layer.anchorPoint.x == 1) {
        currentChannelViewCenterX -= (currentChannelView.ct_width * 0.5);
        
    }
    
    if (oldChannelView.layer.anchorPoint.x == 0) {
        oldChannelViewCenterX += (oldChannelView.ct_width * 0.5);
    } else if (oldChannelView.layer.anchorPoint.x == 1) {
        oldChannelViewCenterX -= (oldChannelView.ct_width * 0.5);
        
    }
    
    CGFloat xDistance = currentChannelViewCenterX - oldChannelViewCenterX;
    CGFloat wDistance = currentChannelView.ct_width - oldChannelView.ct_width;
    //下标
    self.selectedTip.ct_centerX = oldChannelViewCenterX + xDistance * progress;
    self.selectedTip.ct_width = 5 > 0 ? 5. : (oldChannelView.ct_width + wDistance * progress);
}

- (void)proceseSelectedIndex:(NSInteger)selectedIndex {
    [self setSelectedIndex:selectedIndex animated:YES];
    if (self.delegate && [self.delegate respondsToSelector:@selector(channelView:didSelectRowAtIndex:)]) {
        [self.delegate channelView:self didSelectRowAtIndex:selectedIndex];
       }
}

#pragma mark - Intial Methods

#pragma mark - Process Methods
- (void)adjustUIWhenBtttonClickWithAnimate:(BOOL)animated taped:(BOOL)taped
{
//    if (self.currentIndex == self.previousIndex && taped) return;
    NSInteger oldIndex = self.previousIndex;
    NSInteger currentIndex = self.currentIndex;
    DNCPStyleDemoAChannelItemView *oldChannelView = self.channelViews[oldIndex];
    DNCPStyleDemoAChannelItemView *currentChannelView = self.channelViews[currentIndex];
    
    CGFloat animatedTime = animated ? 0.25 : 0;
    
    __weak typeof(self) weakSelf = self;
    [UIView animateKeyframesWithDuration:animatedTime delay:0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
        oldChannelView.titleLabel.textColor = [UIColor colorWithRed:50/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        currentChannelView.titleLabel.textColor = [UIColor colorWithRed:50/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        
        oldChannelView.transform = CGAffineTransformIdentity;
        currentChannelView.transform = CGAffineTransformMakeScale(1.411765, 1.411765);
        
    } completion:^(BOOL finished) {
        [weakSelf adjustChannelOffSetToCurrentIndex:self.currentIndex];
    }];
    
    self.previousIndex = self.currentIndex;
}

/** 设置选中的下标*/
- (void)setSelectedIndex:(NSInteger)index animated:(BOOL)animated {
    [self processChannelSwitchFromIndex:self.currentIndex toIndex:index progress:1];
    self.currentIndex = index;
    
}

/** 让选中的标题居中*/
- (void)adjustChannelOffSetToCurrentIndex:(NSInteger)currentIndex {
    DNCPStyleDemoAChannelItemView *titleView = self.channelViews[currentIndex];
    CGFloat oldChannelViewCenterX = titleView.ct_centerX;
    //        self.selectedTip.cen
    if (titleView.layer.anchorPoint.x == 0) {
        oldChannelViewCenterX += (titleView.ct_width * 0.5);
    } else if (titleView.layer.anchorPoint.x == 1) {
        oldChannelViewCenterX -= (titleView.ct_width * 0.5);
    }
    self.selectedTip.ct_centerX = oldChannelViewCenterX;
    if (self.delegate && [self.delegate respondsToSelector:@selector(channelView:didSelectRowAtIndex:)]) {
        [self.delegate channelView:self didSelectRowAtIndex:self.currentIndex];
    }
}

#pragma mark - Event Methods
- (void)eventChannelViewClick:(UITapGestureRecognizer *)tapGesture {
    DNCPStyleDemoAChannelItemView *titleView = (DNCPStyleDemoAChannelItemView *)tapGesture.view;
    NSInteger index = [self.channelViews indexOfObject:titleView];
    self.currentIndex = index;
    [self adjustUIWhenBtttonClickWithAnimate:YES taped:YES];
}

- (void)eventBackgroundClick:(UIGestureRecognizer *)gestureRecognizer {
    CGPoint point = [gestureRecognizer locationInView:self];
    UIView *lastView = self.channelViews.lastObject;
    CGFloat width = CGRectGetMaxX(lastView.frame);
    NSInteger index = point.x / (width / self.channelViews.count);
    if (index < self.channelViews.count) {
        self.currentIndex = index;
    }
    [self adjustUIWhenBtttonClickWithAnimate:YES taped:YES];
}

#pragma mark - Public Methods

#pragma mark - LazyLoad Methods
-(UIScrollView *)scrollView {
    if (!_scrollView) {
        UIScrollView * scrollView = [UIScrollView new];
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.scrollsToTop = NO;
        scrollView.bounces = YES;
        scrollView.pagingEnabled = NO;
        scrollView.clipsToBounds = NO;
        scrollView.delegate = self;
        scrollView.scrollEnabled = YES;
        _scrollView = scrollView;
    }
    return _scrollView;
}

- (UIView *)selectedTip {
    if (!_selectedTip) {
        UIView *selectedTip = [UIView new];
        selectedTip.clipsToBounds = YES;
        _selectedTip = selectedTip;
    }
    return _selectedTip;
}

- (NSMutableArray<DNCPStyleDemoAChannelItemView *> *)channelViews {
    if (_channelViews == nil) {
        _channelViews = [NSMutableArray<DNCPStyleDemoAChannelItemView *> array];
    }
    return _channelViews;
}

- (UITapGestureRecognizer *)backgroundTapGestureRecognizer {
    if (!_backgroundTapGestureRecognizer) {
        UITapGestureRecognizer *backgroundTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(eventBackgroundClick:)];
        _backgroundTapGestureRecognizer = backgroundTapGestureRecognizer;
    }
    return _backgroundTapGestureRecognizer;
}

- (NSArray *)getColorRgb:(UIColor *)color {
    CGFloat numOfcomponents = CGColorGetNumberOfComponents(color.CGColor);
    NSArray *rgbComponents;
    if (numOfcomponents == 4) {
        const CGFloat *components = CGColorGetComponents(color.CGColor);
        rgbComponents = [NSArray arrayWithObjects:@(components[0]), @(components[1]), @(components[2]), nil];
    }
    return rgbComponents;
    
}

- (NSArray *)selectedColorRGB {
    if (!_selectedColorRGB) {
        NSArray *selectedColorRgb = [self getColorRgb:[UIColor colorWithRed:50/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]];
        NSAssert(selectedColorRgb, @"设置选中状态的文字颜色时 请使用RGB空间的颜色值");
        _selectedColorRGB = selectedColorRgb;
        
    }
    return  _selectedColorRGB;
}

- (NSArray *)normalColorRGB {
    if (!_normalColorRGB) {
        NSArray *normalColorRgb = [self getColorRgb:[UIColor colorWithRed:50/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]];
        NSAssert(normalColorRgb, @"设置普通状态的文字颜色时 请使用RGB空间的颜色值");
        _normalColorRGB = normalColorRgb;
        
    }
    return  _normalColorRGB;
}

@end
