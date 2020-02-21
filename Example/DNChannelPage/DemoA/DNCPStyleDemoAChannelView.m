//
//  DNCPStyleDemoAChannelView.m
//  DNChannelPage_Example
//
//  Created by Ming on 2020/2/20.
//  Copyright © 2020 418589912@qq.com. All rights reserved.
//

#import "DNCPStyleDemoAChannelView.h"

@implementation DNCPStyleDemoAChannelView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = (CGRect){0.,0.,[UIApplication sharedApplication].keyWindow.bounds.size.width,180};
    }
    return self;
}

@end
