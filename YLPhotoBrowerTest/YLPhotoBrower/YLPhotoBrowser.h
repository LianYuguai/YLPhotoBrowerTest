//
//  YLPhotoBrowser.h
//  YLPhotoBrowerTest
//
//  Created by 有 on 16/1/15.
//  Copyright © 2016年 YL. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol YLPhotoBrowserDelegate;

@interface YLPhotoBrowser : UIViewController <UIScrollViewDelegate>
// 代理
@property (nonatomic, weak) id<YLPhotoBrowserDelegate> delegate;
// 所有的图片对象
@property (nonatomic, strong) NSArray *photos;
// 当前展示的图片索引
@property (nonatomic, assign) NSUInteger currentPhotoIndex;
// 显示
- (void)show;
@end
@protocol YLPhotoBrowserDelegate <NSObject>
// 切换到某一页图片
- (void)photoBrowser:(YLPhotoBrowser *)photoBrowser didChangedToPageAtIndex:(NSUInteger)index;;

@end
