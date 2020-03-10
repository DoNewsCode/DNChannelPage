//
//  DNCPStyleDemoAPageViewController.h
//  DNChannelPage_Example
//
//  Created by Ming on 2020/2/21.
//  Copyright © 2020 418589912@qq.com. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DNCPChannelPageViewDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface DNCPStyleDemoAPageViewController : UIViewController<DNCPPageChildViewControllerDelegate>

@property (nonatomic, copy) NSString *channelName;

@end

NS_ASSUME_NONNULL_END
