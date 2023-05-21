//
//  ZCHomeController.m
//  AXRightWifi
//
//  Created by oneStep on 2023/5/3.
//

#import "ZCHomeController.h"
#import "AXHomeItemView.h"
#import "AXHomeSearchView.h"
#import "AXFlowFloatView.h"
#import "AXChangeCardView.h"
#import "AXChangeFlowCardAlertView.h"
#import "AXChangeFlowDeviceAlertView.h"

#define kTopHeight (129-44)

@interface ZCHomeController ()<JXCategoryViewDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) JXCategoryTitleView *categoryView;
@property (nonatomic, strong) UIScrollView        *scrollView;
@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic,strong) NSArray *configureArr;
@property (nonatomic,strong) UIButton *filterBtn;
@property (nonatomic,strong) AXHomeSearchView *searchView;
@property (nonatomic,strong) NSMutableArray *keyArr;

@property (nonatomic,strong) AXFlowFloatView *floatView;
@property (nonatomic,assign) int signHasCardFlag;

@end

@implementation ZCHomeController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getUserBindCardYiListInfo];    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageIndex = 0;
    self.naviView.hidden = YES;
    self.keyArr = [NSMutableArray arrayWithArray:@[@"", @"", @"", @""]];
    [self configureNavi];
    
    [self queryHomeTitleListInfo];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeFlowStatus:) name:@"kFlowCardShowKey" object:nil];
}

- (void)configureNavi {
    UIImageView *topBg = [[UIImageView alloc] initWithImage:kIMAGE(@"home_top_bg")];
    [self.view insertSubview:topBg belowSubview:self.naviView];
    [topBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.mas_equalTo(self.view);
    }];
    topBg.userInteractionEnabled = YES;
    self.searchView = [[AXHomeSearchView alloc] init];
    [topBg addSubview:self.searchView];
    [self.searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(topBg.mas_leading).offset(15);
        make.top.mas_equalTo(topBg.mas_top).offset(52);
        make.trailing.mas_equalTo(topBg.mas_trailing).inset(50);
        make.height.mas_equalTo(30);
    }];
    kweakself(self);
    self.searchView.sureSearchBlock = ^(NSString *content) {
        [weakself searchOperate:content];
    };
    
    UIButton *postBtn = [self.view createSimpleButtonWithTitle:@"发布" font:10 color:[ZCConfigColor whiteColor]];
    [topBg addSubview:postBtn];
    [postBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(30);
        make.centerY.mas_equalTo(self.searchView.mas_centerY);
        make.leading.mas_equalTo(self.searchView.mas_trailing);
    }];
    [postBtn setImage:kIMAGE(@"home_search_add") forState:UIControlStateNormal];
    [postBtn dn_layoutButtonEdgeInset:DNEdgeInsetStyleTop space:0];
    [postBtn addTarget:self action:@selector(postOperate) forControlEvents:UIControlEventTouchUpInside];
}

- (void)searchOperate:(NSString *)content {
    [self.view endEditing:YES];
    [self.keyArr replaceObjectAtIndex:self.pageIndex withObject:checkSafeContent(content)];
    NSDictionary *dic = self.configureArr[self.pageIndex];
    [[NSNotificationCenter defaultCenter] postNotificationName:[NSString stringWithFormat:@"kProductCategoryIndex%tu", self.pageIndex] object:@{@"id":checkSafeContent(dic[@"id"]), @"content":checkSafeContent(content)}];
}

#pragma mark - 发布文章
- (void)postOperate {
    kweakself(self);
    [HCRouter router:@"PostAcrticle" params:@{@"data":checkSafeArray(self.configureArr)} viewController:self animated:YES block:^(id  _Nonnull value) {
        NSDictionary *dic = weakself.configureArr[weakself.pageIndex];
        weakself.searchView.contentF.text = weakself.keyArr[weakself.pageIndex];
        [[NSNotificationCenter defaultCenter] postNotificationName:[NSString stringWithFormat:@"kProductCategoryIndex%tu", self.pageIndex] object:@{@"id":checkSafeContent(dic[@"id"]), @"content":checkSafeContent(weakself.keyArr[self.pageIndex])}];
    }];
}

- (void)showFilterContentView {
    kweakself(self);
    [HCRouter router:@"ArticleCategoryFilter" params:@{@"data":checkSafeArray(self.configureArr)} viewController:self block:^(id  _Nonnull value) {
        [weakself.categoryView selectItemAtIndex:[value integerValue]];
    }];
}

- (void)queryHomeTitleListInfo {
    [ZCHomeManage queryHomeCategoryListInfo:@{} completeHandler:^(id  _Nonnull responseObj) {
        NSLog(@"%@", responseObj);
        self.configureArr = responseObj[@"data"][@"cates"];
        [self configureSubviews];
    }];
}

- (void)queryHomeBannerInfo {
    
    [ZCHomeManage queryHomeBannerListInfo:@{} completeHandler:^(id  _Nonnull responseObj) {
        
    }];
}

- (void)setupSubviews {
        
    NSMutableArray *array = [NSMutableArray arrayWithArray:self.categoryView.titles];
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        AXHomeItemView *classView = [[AXHomeItemView alloc] init];
        if (@available(iOS 11.0, *)) {
            classView.frame = CGRectMake(SCREEN_W * idx, 44, SCREEN_W, CGRectGetHeight(self.scrollView.frame)-STATUS_BAR_HEIGHT);
        } else {
            classView.frame = CGRectMake(SCREEN_W * idx, 44, SCREEN_W, CGRectGetHeight(self.scrollView.frame)-STATUS_BAR_HEIGHT);
        }
        classView.index = idx;
        [self.scrollView addSubview:classView];
        if (idx == 0) {
            NSDictionary *dic = self.configureArr[idx];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"kProductCategoryIndex0" object:@{@"id":checkSafeContent(dic[@"id"])}];
        }
    }];
    self.pageIndex = 0;
    self.categoryView.defaultSelectedIndex = 0;
}

- (void)setupCategoryView {
    if (self.categoryView) {
        [self.categoryView removeFromSuperview];
        [self.filterBtn removeFromSuperview];
    }
    CGFloat widthMax = SCREEN_W - 50;
    CGFloat widthItem = 60;
    CGFloat width = self.configureArr.count*widthItem > widthMax?widthMax:self.configureArr.count*widthItem;
    self.categoryView = [[JXCategoryTitleView alloc]
                         initWithFrame:CGRectMake(0, kTopHeight, width, 44)];
    
    self.categoryView.titleColor = [ZCConfigColor whiteColor];
    self.categoryView.titleSelectedColor = rgba(235, 255, 0, 1);
    self.categoryView.titleSelectedFont = FONT_BOLD(16);
    self.categoryView.titleFont = FONT_SYSTEM(16);
    self.categoryView.titleLabelZoomEnabled = YES;
    self.categoryView.delegate = self;
    self.categoryView.defaultSelectedIndex = 0;
    self.categoryView.titleLabelAnchorPointStyle = JXCategoryTitleLabelAnchorPointStyleBottom;
    NSMutableArray *itemArr = [NSMutableArray array];
    for (int i = 0; i < self.configureArr.count; i ++) {
        NSDictionary *dic = self.configureArr[i];
        [itemArr addObject:dic[@"title"]];
    }
    self.categoryView.titles = itemArr;
//    JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
//    self.categoryView.indicators = @[lineView];
    [self.view addSubview:self.categoryView];
    
    UIButton *filterBtn = [[UIButton alloc] init];
    self.filterBtn = filterBtn;
    [self.view addSubview:filterBtn];
    [filterBtn setImage:kIMAGE(@"home_shop_filter") forState:UIControlStateNormal];
    [filterBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.categoryView.mas_centerY);
        make.trailing.mas_equalTo(self.view.mas_trailing).inset(10);
        make.width.height.mas_equalTo(30);
    }];
    kweakself(self);
    [[filterBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [weakself showFilterContentView];
    }];
}

- (void)setupScrollView {
    
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.contentSize = CGSizeMake(SCREEN_W * self.categoryView.titles.count, 0);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.delegate = self;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    if (@available(iOS 11.0, *)) {
        self.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    [self.view insertSubview:self.scrollView belowSubview:self.categoryView];
    self.categoryView.contentScrollView = self.scrollView;
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kTopHeight);
        make.leading.trailing.mas_equalTo(0);
        if (@available(iOS 11.0, *)) {
            make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        } else {
            make.bottom.mas_equalTo(self.view.mas_bottom);
        }
    }];
    [self.scrollView layoutIfNeeded];
}

- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
    NSLog(@"index:%tu", index);
    self.pageIndex = index;
    NSDictionary *dic = self.configureArr[index];
    self.searchView.contentF.text = self.keyArr[index];
    [[NSNotificationCenter defaultCenter] postNotificationName:[NSString stringWithFormat:@"kProductCategoryIndex%tu", index] object:@{@"id":checkSafeContent(dic[@"id"]), @"content":checkSafeContent(self.keyArr[index])}];
}

- (void)routerWithEventName:(NSString *)eventName userInfo:(NSDictionary *)userInfo {
    if([eventName isEqualToString:@"change"]) {//切换卡片
        if(self.signHasCardFlag) {
            AXChangeCardView *alertView = [[AXChangeCardView alloc] init];
            [alertView showContentView];
            kweakself(self);
            alertView.bindDeviceOperate = ^{//切换卡片
                [weakself changeCardView];
            };
            alertView.knowDeviceInfoOperate = ^{//切换设备
                [weakself changeDeviceView];
            };
        } else {
            [HCRouter router:@"AddCardDevice" params:@{} viewController:self animated:YES block:^(id  _Nonnull value) {
                [self getUserBindCardYiListInfo];
            }];
        }
    }
}

- (void)changeFlowStatus:(NSNotification *)noti {
    NSInteger status = [noti.object integerValue];
    if(status) {
        self.signHasCardFlag = YES;
    } else {
        self.signHasCardFlag = NO;
    }
    self.floatView = [[AXFlowFloatView alloc] init];
    [self.view addSubview:self.floatView];
    [self.floatView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(self.view);
        make.width.mas_equalTo(107);
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(self.view.mas_top).offset(162);
    }];
    self.floatView.type = status;
}

- (void)changeDeviceView {
    AXChangeFlowDeviceAlertView *alertView = [[AXChangeFlowDeviceAlertView alloc] init];
    [alertView showContentView];
    alertView.dataArr = self.deviceArr;
    kweakself(self);
    alertView.knowDeviceInfoOperate = ^(NSDictionary * _Nonnull dic) {
        [weakself changeDeviceOperator:dic];
    };
    alertView.bindDeviceOperate = ^{//添加设备
        [weakself jumpAddCardOp];
    };
}

- (void)changeCardView {
    AXChangeFlowCardAlertView *alertView = [[AXChangeFlowCardAlertView alloc] init];
    [alertView showContentView];
    alertView.dataArr = self.dataArr;
    kweakself(self);
    alertView.knowDeviceInfoOperate = ^(NSDictionary * _Nonnull dic) {
        [weakself changeDeviceOperator:dic];
    };
    alertView.bindDeviceOperate = ^{//添加流量卡
        [weakself jumpAddCardOp];
    };
}

- (void)jumpAddCardOp {
    [HCRouter router:@"AddCardDevice" params:@{} viewController:self animated:YES block:^(id  _Nonnull value) {
        [self getUserBindCardYiListInfo];
        [self getUserBindDeviceListInfo];
    }];
}

- (void)changeDeviceOperator:(NSDictionary *)dataDic {
    NSString *master_service_type = checkSafeContent(dataDic[@"master_service_type"]);
    NSString *sim_card_type = checkSafeContent(dataDic[@"sim_card_type"]);
    NSString *iccid = checkSafeContent(dataDic[@"iccid"]);
    [ZCMineManage changeDeviceOperatorURL:@{@"master_service_type":master_service_type, @"sim_card_type":sim_card_type, @"iccid":iccid} completeHandler:^(id  _Nonnull responseObj) {
        [[CFFAlertView sharedInstance] showTextMsg:checkSafeContent(responseObj[@"message"])];       
    }];
}


- (void)configureSubviews {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self setupCategoryView];
        [self setupScrollView];
        [self setupSubviews];
    });
}

@end
