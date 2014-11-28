//
//  ViewController.m
//  GCRefreshExtension
//
//  Created by zhoujinqiang on 14/11/27.
//  Copyright (c) 2014年 zhoujinqiang. All rights reserved.
//

#import "ViewController.h"

#import "UIScrollView+GCRefresh.h"

@interface ViewController ()

@property (nonatomic, strong) UIScrollView* scroll;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __weak typeof(self) weakSelf = self;
    self.scroll = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.scroll.contentSize = CGSizeMake(CGRectGetWidth(self.scroll.bounds), CGRectGetHeight(self.scroll.bounds) * 5);
    [self.scroll usingRefresh];
    [self.scroll setHeaderRefreshAction:^{
        [NSTimer scheduledTimerWithTimeInterval:2.0f target:weakSelf selector:@selector(stopLoading) userInfo:nil repeats:NO];
    }];
    [self.view addSubview:self.scroll];
    
    UIImageView* image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg"]];
    image.frame = self.scroll.frame;
    [self.scroll addSubview:image];
}

- (void)stopLoading {
    [self.scroll endHeaderRefresh];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
