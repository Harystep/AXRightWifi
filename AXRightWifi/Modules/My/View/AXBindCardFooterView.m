//
//  AXBindCardFooterView.m
//  AXRightWifi
//
//  Created by oneStep on 2023/5/16.
//

#import "AXBindCardFooterView.h"

@interface AXBindCardFooterView ()

@property (nonatomic,strong) UIButton *opBtn;

@end

@implementation AXBindCardFooterView

- (instancetype)initWithFrame:(CGRect)frame {
    if(self == [super initWithFrame:frame]) {
        
        [self createSubviews];
    }
    return self;
}

- (void)createSubviews {
    self.backgroundColor = [ZCConfigColor whiteColor];
    UIButton *opBtn = [self createSimpleButtonWithTitle:@"请先绑定卡片/设备，方便领取流量" font:14 color:rgba(245, 70, 58, 1)];
    [self addSubview:opBtn];
    [opBtn setImage:kIMAGE(@"my_device_add") forState:UIControlStateNormal];
    [opBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(34);
        make.leading.trailing.mas_equalTo(self).inset(20);
        make.top.mas_equalTo(self.mas_top).offset(10);
    }];
    [opBtn setViewBorderWithColor:1 color:rgba(245, 70, 58, 1)];
    [opBtn addTarget:self action:@selector(opBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [opBtn setViewCornerRadiu:5];
    self.opBtn = opBtn;
    [self setupViewRound:self corners:UIRectCornerBottomLeft|UIRectCornerBottomRight];
}

- (void)opBtnClick {
    [self routerWithEventName:@"add" userInfo:@{}];
}

- (void)setHaveDataFlag:(NSInteger)haveDataFlag {
    NSString *content;
    if(haveDataFlag) {
        content = @"继续添加";
    } else {
        content = @"请先绑定卡片/设备，方便领取流量";
    }
    [self.opBtn setTitle:content forState:UIControlStateNormal];
    [self.opBtn dn_layoutButtonEdgeInset:DNEdgeInsetStyleLeft space:3];
}

@end
