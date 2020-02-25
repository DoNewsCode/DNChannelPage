//
//  DNCPStyleDemoAChannelItemView.m
//  DNChannelPage_Example
//
//  Created by Ming on 2020/2/24.
//  Copyright © 2020 418589912@qq.com. All rights reserved.
//

#import "DNCPStyleDemoAChannelItemView.h"

@implementation DNCPStyleDemoAChannelItemView

- (instancetype)init
{
    self = [super init];
    if (self) {
        UILabel *titleLabel = [UILabel new];
//        titleLabel.backgroundColor = [UIColor redColor];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:titleLabel];
        self.titleLabel = titleLabel;
//        self.backgroundColor = [UIColor greenColor];
    }
    return self;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    
}


@end
