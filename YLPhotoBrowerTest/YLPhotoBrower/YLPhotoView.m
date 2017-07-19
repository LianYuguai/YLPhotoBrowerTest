//
//  YLPhotoView.m
//  YLPhotoBrowerTest
//
//  Created by 有 on 16/1/15.
//  Copyright © 2016年 YL. All rights reserved.
//
#import "YLPhotoView.h"
#import "YLPhoto.h"
#import "YLPhotoBrowser.h"
@interface YLPhotoView (){
    BOOL _doubleTap;
    UIImageView *_imageView;
    NSInteger orginalHeight;
    NSInteger orginalY;
}

@end

@implementation YLPhotoView

- (id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame])) {
        self.clipsToBounds = YES;
        // 图片
        _imageView = [[UIImageView alloc] init];
        _imageView.userInteractionEnabled = YES;
        [self addSubview:_imageView];
        
        // 属性
        self.backgroundColor = [UIColor clearColor];
        self.delegate = self;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.decelerationRate = UIScrollViewDecelerationRateFast;
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        // 监听点击
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
        singleTap.delaysTouchesBegan = YES;
        singleTap.numberOfTapsRequired = 1;
        [self addGestureRecognizer:singleTap];
        
        UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
        doubleTap.numberOfTapsRequired = 2;
        [self addGestureRecognizer:doubleTap];
    }
    return self;
}

#pragma mark - photoSetter
- (void)setPhoto:(YLPhoto *)photo {
    _photo = photo;
    
    [self showImage:_photo];
}

#pragma mark 显示图片
- (void)showImage:(YLPhoto *)photo
{
    UIImage *image = photo.srcImageView.image;
    _imageView.image = image;
    [self adjustFrame];
}

#pragma mark 调整frame
- (void)adjustFrame
{
    if (_imageView.image == nil) return;
    
    // 基本尺寸参数
    CGSize boundsSize = self.bounds.size;
    CGFloat boundsWidth = boundsSize.width;
    CGFloat boundsHeight = boundsSize.height;
    
    CGSize imageSize = _imageView.image.size;
    CGFloat imageWidth = imageSize.width;
    CGFloat imageHeight = imageSize.height;
    
    // 设置伸缩比例
    CGFloat minScale = boundsWidth / imageWidth;
    CGFloat maxScale = 3.0;

    self.maximumZoomScale = maxScale;
    self.minimumZoomScale = 1.0;
//    self.zoomScale = minScale;
    
    CGRect imageFrame = CGRectMake(0, 0, boundsWidth, imageHeight * boundsWidth / imageWidth);
    // 内容尺寸
    orginalHeight = imageHeight * boundsWidth / imageWidth;
    self.contentSize = CGSizeMake(0, imageFrame.size.height);
    
    // y值
    if (imageFrame.size.height < boundsHeight) {
        imageFrame.origin.y = floorf((boundsHeight - imageFrame.size.height) / 2.0);
    } else {
        imageFrame.origin.y = 0;
    }
    if (_photo.firstShow) { // 第一次显示的图片
        _photo.firstShow = NO; // 已经显示过了
        _imageView.frame = [_photo.srcImageView convertRect:_photo.srcImageView.bounds toView:nil];
        
        [UIView animateWithDuration:.3 animations:^{
            _imageView.frame = imageFrame;
            
        }];

    }else{
        _imageView.frame = imageFrame;

    }
       orginalY = _imageView.origin.y;

}

#pragma mark - 手势处理
- (void)handleSingleTap:(UITapGestureRecognizer *)tap {
    _doubleTap = NO;
    [self performSelector:@selector(hide) withObject:nil afterDelay:0.2];
}
- (void)hide
{
    if (_doubleTap) return;
    
    // 移除进度条
//    [_photoLoadingView removeFromSuperview];
    self.contentOffset = CGPointZero;
    
    // 清空底部的小图
    _photo.srcImageView.image = nil;
    
    CGFloat duration = 0.15;
    if (_photo.srcImageView.clipsToBounds) {
        [self performSelector:@selector(reset) withObject:nil afterDelay:duration];
    }
    
    [UIView animateWithDuration:duration + 0.1 animations:^{
        NSLog(@"%@",NSStringFromCGRect(_photo.srcImageView.frame));
        _imageView.frame = [_photo.srcImageView convertRect:_photo.srcImageView.bounds toView:self];
        NSLog(@"%@",NSStringFromCGRect(_imageView.frame));
        
        // 通知代理
        if ([self.photoViewDelegate respondsToSelector:@selector(photoViewSingleTap:)]) {
            [self.photoViewDelegate photoViewSingleTap:self];
        }
    } completion:^(BOOL finished) {

        // 设置底部的小图片
        _photo.srcImageView.image = _imageView.image;

        // 通知代理
        if ([self.photoViewDelegate respondsToSelector:@selector(photoViewDidEndZoom:)]) {
            [self.photoViewDelegate photoViewDidEndZoom:self];
        }
       

    }];
}

- (void)reset
{
    _imageView.image = _photo.capture;
//    _imageView.image = [UIImage imageNamed:@"minion_01.png"];
    _imageView.contentMode = UIViewContentModeScaleToFill;
}

- (void)handleDoubleTap:(UITapGestureRecognizer *)tap {
    _doubleTap = YES;
    

    [self setZoomScale:1.0 animated:YES];
    [UIView animateWithDuration:.3 animations:^{
        _imageView.top = orginalY;
        
    }];
}

- (nullable UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return _imageView;
}
//- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view atScale:(CGFloat)scale{
//    if (scale > 1) {
//        [UIView animateWithDuration:.3 animations:^{
//            _imageView.top = orginalY - (orginalHeight * (scale - 1)/2);
//
//        }];
//    }
//    NSLog(@"%f",scale);
//}
-(void)scrollViewDidZoom:(UIScrollView *)scrollView{
    
    CGRect imageViewFrame = _imageView.frame;
    
    CGRect screenBounds = [UIScreen mainScreen].bounds;
    
    if (imageViewFrame.size.height > screenBounds.size.height)
        
    { imageViewFrame.origin.y = 0.0f; }
    
    else { imageViewFrame.origin.y = (screenBounds.size.height - imageViewFrame.size.height) / 2.0; }
    
    _imageView.frame = imageViewFrame;
}

@end
