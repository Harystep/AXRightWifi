//
//  AXMyTopView.m
//  AXRightWifi
//
//  Created by oneStep on 2023/5/16.
//

#import "AXMyTopView.h"
#import "AXTitleLabelView.h"
#import "AXFlowDateView.h"

@interface AXMyTopView ()

@property (nonatomic,strong) UIImageView *iconIv;

@property (nonatomic,strong) UILabel *nameL;

@property (nonatomic,strong) AXFlowDateView *dataView;

@property (nonatomic,strong) UILabel *moneyL;

@property (nonatomic,strong) UIImageView *levelIv;

@property (nonatomic,strong) UIView *baseView;

@property (nonatomic,strong) UIButton *alertBtn;

@end

@implementation AXMyTopView

- (instancetype)initWithFrame:(CGRect)frame {
    if(self == [super initWithFrame:frame]) {
        
        [self createSubviews];
    }
    return self;
}

- (void)createSubviews {
    
    self.iconIv = [[UIImageView alloc] initWithImage:kIMAGE(@"my_user_def_icon")];
    [self addSubview:self.iconIv];
    [self.iconIv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.mas_leading);
        make.top.mas_equalTo(self.mas_top).offset(65);
        make.height.width.mas_equalTo(60);
    }];
    [self.iconIv setViewCornerRadiu:30];
    
    [self createUserBaseInfo];
    
    UIView *dataView = [[UIView alloc] init];
    [self addSubview:dataView];
    [dataView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(self);
        make.top.mas_equalTo(self.iconIv.mas_bottom).offset(15);
        make.height.mas_equalTo(160);        
    }];
    dataView.backgroundColor = [ZCConfigColor whiteColor];
    [dataView setViewCornerRadiu:10];
    
    AXTitleLabelView *titleView = [[AXTitleLabelView alloc] init];
    [dataView addSubview:titleView];
    [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.leading.mas_equalTo(dataView);
        make.top.mas_equalTo(dataView.mas_top).offset(10);
        make.height.mas_equalTo(32);
    }];
    
    self.dataView = [[AXFlowDateView alloc] init];
    [dataView addSubview:self.dataView];
    [self.dataView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(dataView);
        make.top.mas_equalTo(titleView.mas_bottom).offset(10);
    }];
    self.dataView.descArr = @[@"累计获得流量", @"等待到账流量", @"当前可用流量"];
    
    UIButton *flowDetail = [[UIButton alloc] init];
    [dataView addSubview:flowDetail];
    [flowDetail setBackgroundImage:kIMAGE(@"my_flow_search_bg") forState:UIControlStateNormal];
    
    UIButton *flow = [[UIButton alloc] init];
    [dataView addSubview:flow];
    [flow setBackgroundImage:kIMAGE(@"my_flow_detail_bg") forState:UIControlStateNormal];
    
    [flowDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(34);
        make.top.mas_equalTo(self.dataView.mas_bottom).offset(10);
        make.leading.mas_equalTo(dataView.mas_leading).offset(20);
        make.trailing.mas_equalTo(flow.mas_leading).inset(25);
    }];
    [flow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(34);
        make.top.mas_equalTo(self.dataView.mas_bottom).offset(10);
        make.trailing.mas_equalTo(dataView.mas_trailing).inset(20);
//        make.leading.mas_equalTo(flowDetail.mas_trailing).inset(25);
    }];
    flow.hidden = YES;
    flowDetail.tag = 0;
    flow.tag = 1;
    [flowDetail addTarget:self action:@selector(flowDetailOperate:) forControlEvents:UIControlEventTouchUpInside];
    [flow addTarget:self action:@selector(flowDetailOperate:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)createUserBaseInfo {
    self.baseView = [[UIView alloc] init];
    [self addSubview:self.baseView];
    [self.baseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.top.mas_equalTo(self.iconIv);
        make.leading.mas_equalTo(self.iconIv.mas_trailing);
        make.trailing.mas_equalTo(self.mas_trailing).inset(60);
    }];
    self.nameL = [self createSimpleLabelWithTitle:@" " font:18 bold:YES color:[ZCConfigColor whiteColor]];
    [self.baseView addSubview:self.nameL];
    [self.nameL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.baseView.mas_top);
        make.leading.mas_equalTo(self.baseView.mas_leading).offset(15);
        make.height.mas_equalTo(22);
    }];
    
    self.moneyL = [self createSimpleLabelWithTitle:@" " font:10 bold:YES color:[ZCConfigColor whiteColor]];
    [self.baseView addSubview:self.moneyL];
    [self.moneyL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.baseView.mas_leading).offset(15);
        make.height.mas_equalTo(22);
        make.top.mas_equalTo(self.nameL.mas_bottom).offset(7);
    }];
    [self.moneyL setViewCornerRadiu:11];
    [self.moneyL setViewBorderWithColor:1 color:[ZCConfigColor whiteColor]];
    
    self.levelIv = [[UIImageView alloc] init];
    [self.baseView addSubview:self.levelIv];
    [self.levelIv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.moneyL.mas_centerY);
        make.leading.mas_equalTo(self.moneyL.mas_trailing).offset(10);
        make.width.mas_equalTo(62);
        make.height.mas_equalTo(19);
    }];
    
    self.alertBtn = [self createSimpleButtonWithTitle:@"请先登录" font:18 color:[ZCConfigColor whiteColor]];
    self.alertBtn.titleLabel.font = FONT_BOLD(18);
    [self addSubview:self.alertBtn];
    [self.alertBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.iconIv.mas_centerY);
        make.leading.mas_equalTo(self.iconIv.mas_trailing).offset(15);
    }];
    [self configureUserBaseInfo];
}

- (void)flowDetailOperate:(UIButton *)sender {
    [self routerWithEventName:sender.titleLabel.text userInfo:@{}];
}

- (void)setDataDic:(NSDictionary *)dataDic {
    _dataDic = dataDic;
    [self configureUserBaseInfo];
    NSDictionary *account = checkSafeDict(dataDic[@"account"]);
    NSDictionary *memberLevel = checkSafeDict(dataDic[@"memberLevel"]);
    self.nameL.text = checkSafeContent(dataDic[@"nickname"]);
    [self.iconIv sd_setImageWithURL:checkSafeURL(dataDic[@"head_portrait"])];
    self.moneyL.text = [NSString stringWithFormat:@"  余额：¥%.2f  ", [checkSafeContent(account[@"user_money"]) doubleValue]];
    NSString *imgStr = [NSString stringWithFormat:@"user_level_%@", checkSafeContent(memberLevel[@"level"])];
    self.levelIv.image = kIMAGE(imgStr);
}

- (void)setFlowDic:(NSDictionary *)flowDic {
    _flowDic = flowDic;
    self.dataView.flowDic = flowDic;
}

- (void)configureUserBaseInfo {
    if(kUserInfo.token.length > 0) {
        self.baseView.hidden = NO;
        self.alertBtn.hidden = YES;
    } else {
        self.baseView.hidden = YES;
        self.alertBtn.hidden = NO;
    }
}

@end
