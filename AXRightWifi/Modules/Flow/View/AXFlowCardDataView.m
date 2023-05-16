//
//  AXFlowCardDataView.m
//  AXRightWifi
//
//  Created by oneStep on 2023/5/16.
//

#import "AXFlowCardDataView.h"
#import "AXFlowDateView.h"

@interface AXFlowCardDataView ()

@property (nonatomic,strong) UILabel *titleL;

@property (nonatomic,strong) UIImageView *iconIv;

@property (nonatomic,strong) AXFlowDateView *dataView;

@end

@implementation AXFlowCardDataView

- (instancetype)initWithFrame:(CGRect)frame {
    if(self == [super initWithFrame:frame]) {
        
        [self createSubviews];
    }
    return self;
}

- (void)createSubviews {
    
    UIView *bgView = [[UIView alloc] init];
    [self addSubview:bgView];
    bgView.backgroundColor = [ZCConfigColor whiteColor];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(self).inset(15);
        make.top.mas_equalTo(self.mas_top);
    }];
    [bgView setViewCornerRadiu:10];
    
    self.iconIv = [[UIImageView alloc] initWithImage:kIMAGE(@"flow_opereator_icon")];
    [bgView addSubview:self.iconIv];
    [self.iconIv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.mas_equalTo(bgView).offset(20);
        make.height.width.mas_equalTo(22);
    }];
    
    self.titleL = [self createSimpleLabelWithTitle:@"中国移动" font:14 bold:NO color:[ZCConfigColor subTxtColor]];
    [bgView addSubview:self.titleL];
    [self.titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.iconIv.mas_centerY);
        make.leading.mas_equalTo(self.iconIv.mas_trailing).offset(5);
    }];
    
    UIButton *changeBtn = [self createSimpleButtonWithTitle:@"切换卡片" font:12 color:rgba(245, 70, 58, 1)];
    [bgView addSubview:changeBtn];
    [changeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(bgView.mas_trailing).inset(20);
        make.centerY.mas_equalTo(self.iconIv.mas_centerY);
        make.height.mas_equalTo(24);
        make.width.mas_equalTo(60);
    }];
    [changeBtn setViewCornerRadiu:12];
    [changeBtn setViewBorderWithColor:1 color:rgba(245, 70, 58, 1)];
    [changeBtn addTarget:self action:@selector(changeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.dataView = [[AXFlowDateView alloc] init];
    [bgView addSubview:self.dataView];
    [self.dataView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(bgView);
        make.top.mas_equalTo(self.iconIv.mas_bottom).offset(20);
        make.bottom.mas_equalTo(bgView.mas_bottom).inset(20);
    }];
    self.dataView.descArr = @[@"今日预计获得", @"今日到账流量", @"等待到账流量"];
    
    UILabel *alertL = [self createSimpleLabelWithTitle:@"" font:14 bold:NO color:[ZCConfigColor txtColor]];
    [self addSubview:alertL];
    [alertL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(self);
        make.height.mas_equalTo(50);
        make.top.mas_equalTo(bgView.mas_bottom);
        make.bottom.mas_equalTo(self.mas_bottom);
    }];
    alertL.textAlignment = NSTextAlignmentCenter;
    NSString *content = @"立即前往产品中心购买卡片/设备";
    alertL.attributedText = [content dn_changeColor:rgba(209, 29, 32, 1) andRange:NSMakeRange(4, 4)];
}

- (void)setDataDic:(NSDictionary *)dataDic {
    _dataDic = dataDic;
    self.dataView.dataDic = dataDic;
}

- (void)setOperatorDic:(NSDictionary *)operatorDic {
    _operatorDic = operatorDic;
    [self.iconIv sd_setImageWithURL:[NSURL URLWithString:checkSafeContent(operatorDic[@"logo"])]];
    self.titleL.text = checkSafeContent(operatorDic[@"value"]);
}

- (void)changeBtnClick {
    
}

@end
