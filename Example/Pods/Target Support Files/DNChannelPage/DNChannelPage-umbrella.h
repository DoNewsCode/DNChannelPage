#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "DNCPChannelPageView.h"
#import "DNCPChannelPageViewDelegate.h"
#import "DNCPChannelView.h"
#import "DNCPPageCollectionView.h"
#import "DNCPPageCollectionViewCell.h"
#import "DNCPPageCollectionViewFlowLayout.h"
#import "DNCPPageView.h"

FOUNDATION_EXPORT double DNChannelPageVersionNumber;
FOUNDATION_EXPORT const unsigned char DNChannelPageVersionString[];

