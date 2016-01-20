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
    _photosView.pic_urls = @[@"minion_01.png",@"minion_02.png",@"minion_03.png",@"minion_04.png",@"minion_05.png"];
    [self.view addSubview:_photosView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
