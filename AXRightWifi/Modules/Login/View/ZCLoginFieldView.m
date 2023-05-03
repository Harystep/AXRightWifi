//
//  ZCLoginFieldView.m
//  AXRightWifi
//
//  Created by oneStep on 2023/5/3.
//

#import "ZCLoginFieldView.h"

@interface ZCLoginFieldView ()

@property (nonatomic,strong) UILabel *titleL;

@end

@implementation ZCLoginFieldView

- (instancetype)initWithFrame:(CGRect)frame {
    if(self == [super initWithFrame:frame]) {
       
        [self createSubviews];
    }
    return self;
}

- (void)createSubviews {
    
    [self setViewCornerRadiu:5];
    [self setViewBorderWithColor:1 color:rgba(136, 126, 126, 1)];
    
//    self.titleL = [self createSimpleLabelWithTitle:@" " font:16 bold:NO color:COLOR_SUB_CONTENT];
//    [self addSubview:self.titleL];
//    [self.titleL mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.mas_equalTo(self.mas_centerY);
//        make.leading.mas_equalTo(self.mas_leading).offset(26);
//    }];
    
    self.contentF = [[UITextField alloc] init];
    [self addSubview:self.contentF];
    [self.contentF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY);
        make.leading.trailing.mas_equalTo(self).inset(26);
        make.height.mas_equalTo(40);
    }];
    self.contentF.font = FONT_SYSTEM(16);
    
}

- (void)setTitleStr:(NSString *)titleStr {
    _titleStr = titleStr;
    self.titleL.text = titleStr;
}

@end
