//
//  DNCPPageCollectionView.m
//  DNChannelPage
//
//  Created by Ming on 2020/2/20.
//

#import "DNCPPageCollectionView.h"

@interface DNCPPageCollectionView ()

@property (copy, nonatomic) DNCPPageCollectionViewShouldBeginPanGestureHandler gestureBeginHandler;

@end

@implementation DNCPPageCollectionView

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    
    if ([touch.view isKindOfClass:[UISlider class]]) {
        return NO;
    }
    return YES;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (_gestureBeginHandler && gestureRecognizer == self.panGestureRecognizer) {
        return _gestureBeginHandler(self, (UIPanGestureRecognizer *)gestureRecognizer);
    }
    else {
        return [super gestureRecognizerShouldBegin:gestureRecognizer];
    }
}
-(void)returnScrollViewShouldBeginPanGestureHandler:(DNCPPageCollectionViewShouldBeginPanGestureHandler)gestureBeginHandler
{
    _gestureBeginHandler = [gestureBeginHandler copy];
}

/// 12.23 新增，解决与右滑返回手势的冲突
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    // 首先判断otherGestureRecognizer是不是系统pop手势
    if ([otherGestureRecognizer.view isKindOfClass:NSClassFromString(@"UILayoutContainerView")]) {
        // 再判断系统手势的state是began还是fail，同时判断scrollView的位置是不是正好在最左边
        if (otherGestureRecognizer.state == UIGestureRecognizerStateBegan && self.contentOffset.x == 0) {
            return YES;
        }
    }
    return NO;
}

@end
