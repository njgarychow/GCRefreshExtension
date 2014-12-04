//
//  ViewController.m
//  GCRefreshExtension
//
//  Created by zhoujinqiang on 14/11/27.
//  Copyright (c) 2014年 zhoujinqiang. All rights reserved.
//

#import "ViewController.h"

#import "GCRefresh.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, assign) int tbNumber;

@property (nonatomic, strong) UITableView* tb;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __weak typeof(self) weakSelf = self;
    self.tb = [[UITableView alloc] initWithFrame:self.view.bounds];
    [self.tb setHeaderRefreshAction:^{
        [NSTimer scheduledTimerWithTimeInterval:2.0f target:weakSelf selector:@selector(stopHeaderLoading) userInfo:nil repeats:NO];
    }];
    [self.tb setFooterRefreshAction:^{
        [NSTimer scheduledTimerWithTimeInterval:2.0f target:weakSelf selector:@selector(stopFooterLoading) userInfo:nil repeats:NO];
    }];
    [self.tb registerClass:[UITableViewCell class] forCellReuseIdentifier:@"reuse"];
    self.tb.tableFooterView = [[UIView alloc] init];
    self.tb.delegate = self;
    self.tb.dataSource = self;
    [self.view addSubview:self.tb];
}
- (void)stopHeaderLoading {
    self.tbNumber = 10;
    [self.tb reloadData];
    [self.tb endHeaderRefresh];
}
- (void)stopFooterLoading {
    self.tbNumber += 10;
    [self.tb reloadData];
    [self.tb endFooterRefresh];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.tb startFooterRefreshWithAnimation:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    static int i = 0;
    [self.tb startHeaderRefreshWithAnimation:((++i) % 2 == 0)];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"reuse" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row];
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tbNumber;
}

@end
