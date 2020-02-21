//
//  DNCPChannelPageViewDelegate.h
//  DNChannelPage
//
//  Created by Ming on 2020/2/20.
//

#ifndef DNCPChannelPageViewDelegate_h
#define DNCPChannelPageViewDelegate_h


@protocol DNCPPageChildViewControllerDelegate <NSObject>
///生命周期方法
@optional;
/**
 * 请注意: 如果你希望所有的子控制器的view的系统生命周期方法被正确的调用
 * 请重写父控制器的'shouldAutomaticallyForwardAppearanceMethods'方法 并且返回NO
 * 当然如果你不做这个操作, 子控制器的生命周期方法将不会被正确的调用
 * 如果你仍然想利用子控制器的生命周期方法, 请使用'DNPageScrollPageViewChildVcDelegate'提供的代理方法
 * 或者'DNScrollPageViewDelegate'提供的代理方法
 */
- (void)mm_viewWillAppearForIndex:(NSInteger)index;
- (void)mm_viewDidAppearForIndex:(NSInteger)index;
- (void)mm_viewWillDisappearForIndex:(NSInteger)index;
- (void)mm_viewDidDisappearForIndex:(NSInteger)index;
- (void)mm_viewDidLoadForIndex:(NSInteger)index;

@end

//@protocol DNCPChannelPageViewDelegate <NSObject>
//
//@optional;
//
//
//@end



#endif /* DNCPChannelPageViewDelegate_h */


