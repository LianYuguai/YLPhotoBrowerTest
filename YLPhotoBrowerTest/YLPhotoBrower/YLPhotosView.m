//
//  YLPhotosView.m
//  YLPhotoBrowerTest
//
//  Created by 有 on 16/1/15.
//  Copyright © 2016年 YL. All rights reserved.
//

#import "YLPhotosView.h"
#import "YLPhotoBrowser.h"
#import "YLPhoto.h"
//#import "UIView+Extension.h"
@implementation YLPhotosView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}


- (void)setPic_urls:(NSArray *)pic_urls
{
    _pic_urls = pic_urls;
    
    for (int i = 0; i<pic_urls.count; i++) {
        UIImageView *photoView = [[UIImageView alloc] init];
        photoView.userInteractionEnabled = YES;
        photoView.tag = i;
        photoView.image = [UIImage imageNamed:pic_urls[i]];
        [self addSubview:photoView];
        // 添加手势监听器（一个手势监听器 只能 监听对应的一个view）
        UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] init];
        [recognizer addTarget:self action:@selector(tapPhoto:)];
        [photoView addGestureRecognizer:recognizer];
    }
}

/**
 *  监听图片的点击
 */
- (void)tapPhoto:(UITapGestureRecognizer *)recognizer
{
    // 1.创建图片浏览器
    YLPhotoBrowser *browser = [[YLPhotoBrowser alloc] init];
    
    // 2.设置图片浏览器显示的所有图片
    NSMutableArray *photos = [NSMutableArray array];
    int count = self.pic_urls.count;
    for (int i = 0; i<count; i++) {
        
        YLPhoto *photo = [[YLPhoto alloc] init];
        photo.srcImageView = self.subviews[i];
//        photo.srcImageView.hidden = YES;
        [photos addObject:photo];
    }
    browser.photos = photos;
    
    // 3.设置默认显示的图片索引
    browser.currentPhotoIndex = recognizer.view.tag;
    
    [browser show];
    
//    recognizer.view.hidden = YES;
    
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    int count = self.pic_urls.count;
    int maxCols = 2;
    for (int i = 0; i<count; i++) {
        UIImageView *photoView = self.subviews[i];
        float photoWidth = (self.bounds.size.width - 10)/2;
        float photoHeight = photoWidth * 0.8;
        photoView.width = photoWidth;
        photoView.height = photoHeight;
        photoView.left = (i % maxCols) * (photoWidth + 10);
        photoView.top = (i / maxCols) * (photoHeight + 10);
    }
}
@end
