//
//  AXChangeCardView.m
//  AXRightWifi
//
//  Created by oneStep on 2023/5/17.
//

#import "AXChangeCardView.h"

#define kViewHeight 145

@interface AXChangeCardView ()

@property (nonatomic,strong) UIView *contentView;

@property (nonatomic,strong) UIScrollView *scView;

@property (nonatomic,strong) UIView *detailView;

@property (nonatomic,strong) UILabel *nameL;
@property (nonatomic,strong) UILabel *subL;
@property (nonatomic,strong) UILabel *descL;
@property (nonatomic,strong) UIImageView *iconIv;

@end

@implementation AXChangeCardView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createSubviews];
    }
    return self;
}

- (void)createSubviews {
    [self setViewColorAlpha:0.4 color:[ZCConfigColor txtColor]];
        
    self.contentView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_H, SCREEN_W, kViewHeight)];
    self.contentView.backgroundColor = [ZCConfigColor whiteColor];
    [self addSubview:self.contentView];
    [self setupViewRound:self.contentView corners:UIRectCornerTopRight | UIRectCornerTopLeft];
    
    UILabel *titleL = [self createSimpleLabelWithTitle:@"请选择要切换的对象" font:16 bold:YES color:[ZCConfigColor txtColor]];
    [self.contentView addSubview:titleL];
    [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
        make.top.mas_equalTo(self.contentView.mas_top).offset(20);
        make.height.mas_equalTo(22);
    }];
    
    UIButton *bindBtn = [self createSimpleButtonWithTitle:@"切换卡片" font:14 color:[ZCConfigColor whiteColor]];
    [self.contentView addSubview:bindBtn];
    [bindBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(80);
        make.centerX.mas_equalTo(self.contentView.mas_centerX).offset(-70);
        make.top.mas_equalTo(titleL.mas_bottom).offset(30);
    }];
    [bindBtn addTarget:self action:@selector(bindBtnOperate) forControlEvents:UIControlEventTouchUpInside];
    bindBtn.backgroundColor = [ZCConfigColor txtColor];
    [bindBtn setBackgroundImage:kIMAGE(@"my_list_blue_bg") forState:UIControlStateNormal];
    [bindBtn setViewCornerRadiu:5];
    
    UIButton *knowBtn = [self createSimpleButtonWithTitle:@"切换设备" font:14 color:[ZCConfigColor whiteColor]];
    [self.contentView addSubview:knowBtn];
    [knowBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView.mas_centerX).offset(70);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(80);
        make.centerY.mas_equalTo(bindBtn.mas_centerY);
    }];
    [knowBtn addTarget:self action:@selector(knowBtnOperate) forControlEvents:UIControlEventTouchUpInside];
    [knowBtn setBackgroundImage:kIMAGE(@"my_list_red_bg") forState:UIControlStateNormal];
    [knowBtn setViewCornerRadiu:5];
}

#pragma -- mark 切换卡片
- (void)bindBtnOperate {

    [self maskBtnClick];
    if (self.bindDeviceOperate) {
        self.bindDeviceOperate();
    }
}
#pragma -- mark 切换设备
- (void)knowBtnOperate {
    [self maskBtnClick];
//    NSString *code = checkSafeContent(self.dataDic[@"code"]);
//    [ZCDataTool signKnowSmartDeviceStatus:YES code:code];
    if (self.knowDeviceInfoOperate) {
        self.knowDeviceInfoOperate();
    }
}

- (void)showContentView {
    self.frame = CGRectMake(0, 0, SCREEN_W, SCREEN_H);
    [UIApplication.sharedApplication.keyWindow addSubview:self];
    self.contentView.frame = CGRectMake(0, SCREEN_H - kViewHeight, SCREEN_W, kViewHeight);
//    [UIView animateWithDuration:0.25 animations:^{
//    }];
}

- (void)maskBtnClick {
    
    self.contentView.frame = CGRectMake(0, SCREEN_H, SCREEN_W, kViewHeight);
    self.contentView.hidden = YES;
    [self.contentView removeFromSuperview];
    [self removeFromSuperview];
//    [UIView animateWithDuration:0.25 animations:^{
//    } completion:^(BOOL finished) {
//    }];
}

@end
