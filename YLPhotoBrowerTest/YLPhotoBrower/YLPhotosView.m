//
//  YLPhotosView.m
//  YLPhotoBrowerTest
//
//  Created by 有 on 16/1/15.
//  Copyright © 2016年 YL. All rights reserved.
//
#define DSStatusPhotosMaxCount 9
#define DSStatusPhotosMaxCols(photosCount) ((photosCount == 4) ? 3 :3)
#define DSStatusPhotosW SCREEN_WIDTH*0.21
#define DSStatusPhotosH DSStatusPhotosW
#define DSStatusPhotosMargin 5

#import "YLPhotosView.h"
#import "YLPhotoBrowser.h"
#import "YLPhoto.h"
#import "UIViewExt.h"
//#import "UIView+Extension.h"
@implementation YLPhotosView{
    CGFloat _photosW;
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.maxCols = 3;
        _photosW = (SCREEN_WIDTH - 20 - (3 - 1)*DSStatusPhotosMargin)*1.0/3;
    }
    return self;
}

- (void)setMaxCols:(NSInteger)maxCols{
    _maxCols = maxCols;
    _photosW = (SCREEN_WIDTH - 20 - (maxCols - 1)*DSStatusPhotosMargin)*1.0/maxCols;
}

- (void)setPic_urls:(NSArray *)pic_urls
{
    _pic_urls = pic_urls;
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    for (int i = 0; i<pic_urls.count; i++) {
        UIImageView *photoView = [[UIImageView alloc] init];
        photoView.clipsToBounds = YES;
        photoView.contentMode = UIViewContentModeScaleAspectFill;
        [photoView setContentScaleFactor:[[UIScreen mainScreen] scale]];
        photoView.userInteractionEnabled = YES;
        photoView.tag = i;
//        photoView.image = [UIImage imageNamed:pic_urls[i]];
        [photoView sd_setImageWithURL:pic_urls[i] placeholderImage:[UIImage imageNamed:@"dismiss_image"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            ;
        }];
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
//    int maxCols = 3;
    for (int i = 0; i<count; i++) {
        UIImageView *photoView = self.subviews[i];
        float photoWidth = _photosW;
        float photoHeight =_photosW;
        photoView.width = photoWidth;
        photoView.height = photoHeight;
        photoView.left = (i % _maxCols) * (photoWidth + DSStatusPhotosMargin);
        photoView.top = (i / _maxCols) * (photoHeight + DSStatusPhotosMargin);
    }
}

+ (CGSize)sizeWithPhotosCount:(int)photosCount {
    
    int maxCols = DSStatusPhotosMaxCols(photosCount);
    
    // 总列数
    int totalCols = photosCount >= maxCols ? maxCols : photosCount;
    
    // 总行数
    int totalRows = (photosCount + maxCols - 1) / maxCols;
    
    // 计算尺寸
    CGFloat photosW = totalCols * (SCREEN_WIDTH - 20 - (3 - 1)*DSStatusPhotosMargin)*1.0/3 + (totalCols - 1) * DSStatusPhotosMargin;
    CGFloat photosH = totalRows * (SCREEN_WIDTH - 20 - (3 - 1)*DSStatusPhotosMargin)*1.0/3 + (totalRows - 1) * DSStatusPhotosMargin;
    
    return CGSizeMake(photosW, photosH);
    
    
}

+ (CGSize)sizeOtherWithPhotosCount:(int)photosCount {
    
    int maxCols = 4;
    
    // 总列数
    int totalCols = photosCount >= maxCols ? maxCols : photosCount;
    
    // 总行数
    int totalRows = (photosCount + maxCols - 1) / maxCols;
    
    // 计算尺寸
    CGFloat photosW = totalCols * (SCREEN_WIDTH - 20 - (4 - 1)*DSStatusPhotosMargin)*1.0/4 + (totalCols - 1) * DSStatusPhotosMargin;
    CGFloat photosH = totalRows * (SCREEN_WIDTH - 20 - (4 - 1)*DSStatusPhotosMargin)*1.0/4 + (totalRows - 1) * DSStatusPhotosMargin;
    
    return CGSizeMake(photosW, photosH);
    
    
}

@end
