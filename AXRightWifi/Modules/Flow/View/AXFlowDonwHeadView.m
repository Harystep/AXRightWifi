//
//  AXFlowDonwHeadView.m
//  AXRightWifi
//
//  Created by oneStep on 2023/5/16.
//

#import "AXFlowDonwHeadView.h"

@implementation AXFlowDonwHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    if(self == [super initWithFrame:frame]) {
        
        [self createSubviews];
    }
    return self;
}

- (void)createSubviews {
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(15, 0, SCREEN_W-30, 52)];
    [self addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.leading.mas_equalTo(self).inset(15);
        make.bottom.mas_equalTo(self.mas_bottom);
        make.top.mas_equalTo(self.mas_top).offset(15);
    }];
    self.bgView = bgView;
    bgView.backgroundColor = [ZCConfigColor whiteColor];
    
    UILabel *titleL = [self createSimpleLabelWithTitle:@"下载APP得流量" font:16 bold:YES color:[ZCConfigColor txtColor]];
    [bgView addSubview:titleL];
    [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.mas_equalTo(bgView).offset(20);
        make.height.mas_equalTo(22);
        make.bottom.mas_equalTo(bgView.mas_bottom).inset(10);
    }];
    
    UIButton *recordBtn = [self createSimpleButtonWithTitle:@"任务记录" font:12 color:rgba(245, 70, 58, 1)];
    [self.bgView addSubview:recordBtn];
    [recordBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(titleL.mas_centerY);
        make.trailing.mas_equalTo(self.bgView.mas_trailing).inset(15);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(24);
    }];
    [recordBtn setViewCornerRadiu:12];
    [recordBtn addTarget:self action:@selector(recordOperate) forControlEvents:UIControlEventTouchUpInside];
    [recordBtn setViewBorderWithColor:1 color:rgba(245, 70, 58, 1)];
    
}

- (void)recordOperate {
    
}

@end
