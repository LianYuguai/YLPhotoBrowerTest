//
//  YLPhotoToolbar.m
//  YLPhotoBrowerTest
//
//  Created by 有 on 16/1/18.
//  Copyright © 2016年 YL. All rights reserved.
//

#import "YLPhotoToolbar.h"
#import "YLPhoto.h"

@interface YLPhotoToolbar (){
    // 显示页码
    UILabel *_indexLabel;
    UIButton *_saveImageBtn;

}

@end

@implementation YLPhotoToolbar


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setPhotos:(NSArray *)photos
{
    _photos = photos;
    
    if (_photos.count > 1) {
        _indexLabel = [[UILabel alloc] init];
        _indexLabel.font = [UIFont boldSystemFontOfSize:20];
        _indexLabel.frame = self.bounds;
        _indexLabel.backgroundColor = [UIColor clearColor];
        _indexLabel.textColor = [UIColor whiteColor];
        _indexLabel.textAlignment = NSTextAlignmentCenter;
        _indexLabel.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        [self addSubview:_indexLabel];
    }
}

- (void)setCurrentPhotoIndex:(NSUInteger)currentPhotoIndex
{
    _currentPhotoIndex = currentPhotoIndex;
    
    // 更新页码
    _indexLabel.text = [NSString stringWithFormat:@"%ld / %ld", _currentPhotoIndex + 1, _photos.count];
    
}
@end
