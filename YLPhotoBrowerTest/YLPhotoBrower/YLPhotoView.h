//
//  YLPhotoView.h
//  YLPhotoBrowerTest
//
//  Created by 有 on 16/1/15.
//  Copyright © 2016年 YL. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YLPhotoBrowser,YLPhoto,YLPhotoView;

@protocol YLPhotoViewDelegate <NSObject>

//- (void)photoViewImageFinishLoad:(YLPhotosView *)photoView;
- (void)photoViewSingleTap:(YLPhotoView *)photoView;
- (void)photoViewDidEndZoom:(YLPhotoView *)photoView;

@end

@interface YLPhotoView : UIScrollView <UIScrollViewDelegate>
@property (nonatomic, strong) YLPhoto *photo;
@property (nonatomic, weak) id<YLPhotoViewDelegate> photoViewDelegate;
@end
