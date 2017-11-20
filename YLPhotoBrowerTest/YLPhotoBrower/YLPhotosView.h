//
//  YLPhotosView.h
//  YLPhotoBrowerTest
//
//  Created by 有 on 16/1/15.
//  Copyright © 2016年 YL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YLPhotosView : UIView
/**
 *  图片数据（里面都是HMPhoto模型）
 */
@property (nonatomic, strong) NSArray *pic_urls;
@property (nonatomic, assign) NSInteger maxCols;
//根据图片个数计算尺寸
+ (CGSize)sizeWithPhotosCount:(int)photosCount;
+ (CGSize)sizeOtherWithPhotosCount:(int)photosCount;
@end
