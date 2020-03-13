//
//  DNCPPageCollectionView.h
//  DNChannelPage
//
//  Created by Ming on 2020/2/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class DNCPPageCollectionView;
typedef BOOL(^DNCPPageCollectionViewShouldBeginPanGestureHandler)(DNCPPageCollectionView *collectionView, UIPanGestureRecognizer *panGesture);

@interface DNCPPageCollectionView : UICollectionView


- (void)returnScrollViewShouldBeginPanGestureHandler:(DNCPPageCollectionViewShouldBeginPanGestureHandler)gestureBeginHandler;


@end

NS_ASSUME_NONNULL_END
