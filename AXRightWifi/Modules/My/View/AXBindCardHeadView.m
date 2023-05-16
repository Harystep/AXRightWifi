//
//  AXBindCardHeadView.m
//  AXRightWifi
//
//  Created by oneStep on 2023/5/16.
//

#import "AXBindCardHeadView.h"
#import "AXTitleLabelView.h"

@interface AXBindCardHeadView ()

@end

@implementation AXBindCardHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    if(self == [super initWithFrame:frame]) {
        
        [self createSubviews];
    }
    return self;
}

- (void)createSubviews {
    self.backgroundColor = [ZCConfigColor whiteColor];
    AXTitleLabelView *titleView = [[AXTitleLabelView alloc] init];
    [self addSubview:titleView];
    [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.leading.mas_equalTo(self);
        make.top.mas_equalTo(self.mas_top).offset(10);
        make.height.mas_equalTo(32);
    }];
    titleView.titleArr = @[@"我的流量卡", @"我的WiFi设备"];
    
    [self setupViewRound:self corners:UIRectCornerTopLeft|UIRectCornerTopRight];
}

@end
