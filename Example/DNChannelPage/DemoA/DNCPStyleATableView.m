//
//  DNCPStyleATableView.m
//  DNChannelPage_Example
//
//  Created by Ming on 2020/3/16.
//  Copyright © 2020 418589912@qq.com. All rights reserved.
//

#import "DNCPStyleATableView.h"

@implementation DNCPStyleATableView

///// 12.23 新增，解决与右滑返回手势的冲突
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
//    if (self.contentOffset.y > 0) {
//        return NO;
//    }
    return YES;
}

@end
