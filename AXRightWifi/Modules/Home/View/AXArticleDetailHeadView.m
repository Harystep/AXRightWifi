//
//  AXArticleDetailHeadView.m
//  AXRightWifi
//
//  Created by oneStep on 2023/5/19.
//

#import "AXArticleDetailHeadView.h"

@interface AXArticleDetailHeadView ()

@end

@implementation AXArticleDetailHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    if(self == [super initWithFrame:frame]) {
        self.backgroundColor = [ZCConfigColor whiteColor];
        [self createSubviews];
    }
    return self;
}

- (void)createSubviews {
    
    self.titleL = [self createSimpleLabelWithTitle:@" " font:20 bold:YES color:[ZCConfigColor txtColor]];
    [self addSubview:self.titleL];
    [self.titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(self).inset(15);
        make.top.mas_equalTo(self.mas_top).offset(5);
    }];
    [self.titleL setContentLineFeedStyle];
    
    self.authorL = [self createSimpleLabelWithTitle:@" " font:13 bold:NO color:[ZCConfigColor txtColor]];
    [self addSubview:self.authorL];
    [self.authorL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.mas_leading).offset(15);
        make.top.mas_equalTo(self.titleL.mas_bottom).offset(10);
        make.bottom.mas_equalTo(self.mas_bottom).inset(20);
    }];
    
    self.timeL = [self createSimpleLabelWithTitle:@" " font:12 bold:NO color:[ZCConfigColor subTxtColor]];
    [self addSubview:self.timeL];
    [self.timeL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.authorL.mas_trailing).offset(8);
        make.centerY.mas_equalTo(self.authorL.mas_centerY);
    }];
}

@end
