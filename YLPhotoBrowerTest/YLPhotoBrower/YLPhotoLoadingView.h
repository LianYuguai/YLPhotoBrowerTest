//
//  YLPhotoLoadingView.h
//
//  Created by 有 on 16/1/15.
//  Copyright © 2016年 YL. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kMinProgress 0.0001

@class YLPhotoBrowser;
@class YLPhoto;

@interface YLPhotoLoadingView : UIView
@property (nonatomic) float progress;

- (void)showLoading;
- (void)showFailure;
@end
