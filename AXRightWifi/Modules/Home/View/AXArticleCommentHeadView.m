//
//  AXArticleCommentHeadView.m
//  AXRightWifi
//
//  Created by oneStep on 2023/5/19.
//

#import "AXArticleCommentHeadView.h"

@implementation AXArticleCommentHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    if(self == [super initWithFrame:frame]) {
        
        [self createSubviews];
    }
    return self;
}

- (void)createSubviews {

    UILabel *titleL = [self createSimpleLabelWithTitle:@"评论" font:15 bold:YES color:[ZCConfigColor txtColor]];
    [self addSubview:titleL];
    [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self).inset(15);
        make.height.mas_equalTo(40);
        make.top.bottom.mas_equalTo(self);
    }];
    
    self.numL = [self createSimpleLabelWithTitle:@"" font:15 bold:YES color:[ZCConfigColor txtColor]];
    [self addSubview:self.numL];
    [self.numL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(titleL.mas_trailing);
        make.centerY.mas_equalTo(titleL.mas_centerY);
    }];
}

@end
