# GCRefreshExtension  


## GCRefreshExtension是一个快速集成下拉和上拉刷新的UIScrollView的扩展。并且可以自定义上拉和下拉的View。    
  

#### 用法简单，导入_GCRefresh_后，只需要调用_UIScrollView_的以下对应方法。
  
```
@interface UIScrollView (GCRefresh)

/**
 *  the showing header view when refreshing
 */
@property (nonatomic, strong) UIView<GCRefreshProtocol>* headerRefreshView;
/**
 *  The height of header refresh trigger. Default is headerRefreshView's height.
 */
@property (nonatomic, assign) float headerRefreshTriggerHeight;
/**
 *  Set the action when the header refresh is triggered. Or nil if you want to 
 *  remove the header refresh function.
 *
 *  @param headerRefreshAction  The action will be invoke when the header refresh triggered.
 */
- (void)setHeaderRefreshAction:(void (^)())headerRefreshAction;
/**
 *  Trigger the header refresh.
 *
 *  @param animation    The refresh with an animation or not.
 */
- (void)startHeaderRefreshWithAnimation:(BOOL)animation;
/**
 *  End the header refresh. You must invoke this method when the header refresh is end.
 */
- (void)endHeaderRefresh;


/**
 *  the showing footer view when refreshing
 */
@property (nonatomic, strong) UIView<GCRefreshProtocol>* footerRefreshView;
/**
 *  The height of footer refresh trigger. Default is footerRefreshView's height.
 */
@property (nonatomic, assign) float footerRefreshTriggerHeight;
/**
 *  Set the action when the footer refresh is triggered. Or nil if you want to
 *  remove the footer refresh function.
 *
 *  @param footerRefreshAction  The action will be invoke when the footer refresh triggered.
 */
- (void)setFooterRefreshAction:(void (^)())footerRefreshAction;
/**
 *  Trigger the footer refresh.
 *
 *  @param animation    The refresh with an animation or not.
 */
- (void)startFooterRefreshWithAnimation:(BOOL)animation;
/**
 *  End the footer refresh. You must invoke this method when the footer refresh is end.
 */
- (void)endFooterRefresh;

@end
```    
  

#### 自定义View也很简单，只需要_UIView_实现_GCRefreshProtocol_协议即可。
```
@protocol GCRefreshProtocol <NSObject>

@optional
/**
 *  This method is invoked before refresh trigger. It show the progess. You can implement animation with the fromProgress and toProgress.
 *
 *  @param fromProgress The last progress.
 *  @param toProgress   The current progress.
 */
- (void)refreshFromProgress:(float)fromProgress toProgress:(float)toProgress;

/**
 *  The refresh action is triggered.
 */
- (void)refreshTriggered;

/**
 *  The refresh action is end.
 */
- (void)refreshEnd;

/**
 *  The refresh action(Include animation) is completed.
 */
- (void)refreshCompleted;

@end
```    

## 用法Example
```
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
```