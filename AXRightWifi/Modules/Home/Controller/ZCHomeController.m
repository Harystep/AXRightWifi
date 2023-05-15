//
//  ZCHomeController.m
//  AXRightWifi
//
//  Created by oneStep on 2023/5/3.
//

#import "ZCHomeController.h"
#import "AXHomeItemView.h"
#import "AXHomeSearchView.h"

#define kTopHeight (129-44)

@interface ZCHomeController ()<JXCategoryViewDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) JXCategoryTitleView *categoryView;
@property (nonatomic, strong) UIScrollView        *scrollView;
@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic,strong) NSArray *dataArr;
@property (nonatomic,strong) UIButton *filterBtn;
@property (nonatomic,strong) AXHomeSearchView *searchView;

@end

@implementation ZCHomeController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageIndex = 0;
    self.naviView.hidden = YES;
    [self configureNavi];
    
    [self queryHomeTitleListInfo];
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
#pragma mark - 发布文章
- (void)postOperate {
    NSLog(@"hear");
}

- (void)queryHomeTitleListInfo {
    [ZCHomeManage queryHomeCategoryListInfo:@{} completeHandler:^(id  _Nonnull responseObj) {
        NSLog(@"%@", responseObj);
        self.dataArr = responseObj[@"data"][@"cates"];
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
            NSDictionary *dic = self.dataArr[idx];
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
    CGFloat width = self.dataArr.count*widthItem > widthMax?widthMax:self.dataArr.count*widthItem;
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
    for (int i = 0; i < self.dataArr.count; i ++) {
        NSDictionary *dic = self.dataArr[i];
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

- (void)showFilterContentView {
   
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
    NSDictionary *dic = self.dataArr[index];
    [[NSNotificationCenter defaultCenter] postNotificationName:[NSString stringWithFormat:@"kProductCategoryIndex%tu", index] object:@{@"id":checkSafeContent(dic[@"id"])}];
}

- (void)configureSubviews {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self setupCategoryView];
        [self setupScrollView];
        [self setupSubviews];
    });
}



@end
