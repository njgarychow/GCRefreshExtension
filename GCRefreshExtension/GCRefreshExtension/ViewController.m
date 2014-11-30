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
    self.scroll.contentSize = CGSizeMake(CGRectGetWidth(self.scroll.bounds), CGRectGetHeight(self.scroll.bounds) * 2);
    [self.scroll usingRefresh];
    [self.scroll setHeaderRefreshAction:^{
        [NSTimer scheduledTimerWithTimeInterval:2.0f target:weakSelf selector:@selector(stopHeaderLoading) userInfo:nil repeats:NO];
    }];
    [self.scroll setFooterRefreshAction:^{
        [NSTimer scheduledTimerWithTimeInterval:2.0f target:weakSelf selector:@selector(stopFooterLoading) userInfo:nil repeats:NO];
    }];
    [self.view addSubview:self.scroll];
    
    UIImageView* image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg"]];
    CGRect frame = self.scroll.frame;
    frame.size.height *= 2;
    image.frame = frame;
    [self.scroll addSubview:image];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.scroll startFooterRefreshWithAnimation:YES];
}

- (void)stopHeaderLoading {
    self.scroll.contentSize = CGSizeMake(CGRectGetWidth(self.scroll.bounds), CGRectGetHeight(self.scroll.bounds) * 2.2);
    [self.scroll endHeaderRefresh];
}
- (void)stopFooterLoading {
    [self.scroll endFooterRefresh];
    self.scroll.contentSize = CGSizeMake(CGRectGetWidth(self.scroll.bounds), CGRectGetHeight(self.scroll.bounds) * 2.2);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    static int i = 0;
    [self.scroll startHeaderRefreshWithAnimation:((++i) % 2 == 0)];
}

@end
