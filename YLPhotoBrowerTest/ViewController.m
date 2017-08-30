//
//  ViewController.m
//  YLPhotoBrowerTest
//
//  Created by 有 on 16/1/14.
//  Copyright © 2016年 YL. All rights reserved.
//

#import "ViewController.h"
#import "YLPhotosView.h"
@interface ViewController (){
    YLPhotosView *_photosView;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view, typically from a nib.
//    _photoView = [[YLPhotosView alloc] initWithFrame:CGRectMake((SCREENWIDTH - 300)/2, (SCREENHEIGHT - 300)/2, 300, 300)];
//    [self.view addSubview:_photoView];
    _photosView = [[YLPhotosView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
//    self.photosView.pic_urls = status.pic_urls;
    _photosView.pic_urls = @[@"http://139.224.25.66:80/attachments/appfile/ZCZ150243940619213.jpg",
                                                 @"http://139.224.25.66:80/attachments/appfile/LBY150243940698916.jpg",
                                                 @"http://139.224.25.66:80/attachments/appfile/YGL150243940674315.jpg",
                                                 @"http://139.224.25.66:80/attachments/appfile/YEC150243940645014.jpg",
                                                @"http://139.224.25.66:80/attachments/appfile/AVF150243940591112.jpg",
                                                 @"http://139.224.25.66:80/attachments/appfile/GXC150243940563011.jpg",
                                                 @"http://139.224.25.66:80/attachments/appfile/LFD150243940529810.jpg",
                                                 @"http://139.224.25.66:80/attachments/appfile/XFV15024394050209.jpg",
                                                 @"http://139.224.25.66:80/attachments/appfile/YZG15024394045818.jpg"
];
    [self.view addSubview:_photosView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
