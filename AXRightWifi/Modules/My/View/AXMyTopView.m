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

@end

@implementation AXMyTopView

- (instancetype)initWithFrame:(CGRect)frame {
    if(self == [super initWithFrame:frame]) {
        
        [self createSubviews];
    }
    return self;
}

- (void)createSubviews {
    UIImageView *bgIv = [[UIImageView alloc] initWithImage:kIMAGE(@"my_top_bg")];
    [self addSubview:bgIv];
    [bgIv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.top.mas_equalTo(self);
        make.height.mas_equalTo(230);
    }];
    
    self.iconIv = [[UIImageView alloc] initWithImage:kIMAGE(@"my_user_def_icon")];
    [self addSubview:self.iconIv];
    [self.iconIv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.mas_leading).offset(15);
        make.top.mas_equalTo(self.mas_top).offset(65);
        make.height.width.mas_equalTo(60);
    }];
    [self.iconIv setViewCornerRadiu:30];
    
    self.nameL = [self createSimpleLabelWithTitle:@" " font:18 bold:YES color:[ZCConfigColor whiteColor]];
    [self addSubview:self.nameL];
    [self.nameL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.iconIv.mas_centerY);
        make.leading.mas_equalTo(self.iconIv.mas_trailing).offset(15);
    }];
    
    UIView *dataView = [[UIView alloc] init];
    [self addSubview:dataView];
    [dataView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(self).inset(15);
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

- (void)flowDetailOperate:(UIButton *)sender {
    
}

@end
