//
//  YLPhoto.m
//  YLPhotoBrowerTest
//
//  Created by 有 on 16/1/15.
//  Copyright © 2016年 YL. All rights reserved.
//

#import "YLPhoto.h"

@implementation YLPhoto
- (UIImage *)capture:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, YES, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

- (void)setSrcImageView:(UIImageView *)srcImageView
{
    _srcImageView = srcImageView;
    _placeholder = srcImageView.image;
//    if (srcImageView.clipsToBounds) {
//        _capture = [self capture:srcImageView];
//    }
}
@end
