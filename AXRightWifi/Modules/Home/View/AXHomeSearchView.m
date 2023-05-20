//
//  AXHomeSearchView.m
//  AXRightWifi
//
//  Created by oneStep on 2023/5/15.
//

#import "AXHomeSearchView.h"

@interface AXHomeSearchView ()<UITextFieldDelegate>


@end

@implementation AXHomeSearchView

- (instancetype)initWithFrame:(CGRect)frame {
    if(self == [super initWithFrame:frame]) {
        
        [self createSubviews];
    }
    return self;
}

- (void)createSubviews {
    self.backgroundColor = [ZCConfigColor whiteColor];
    [self setViewCornerRadiu:15];
    
    UIImageView *iconIv = [[UIImageView alloc] initWithImage:kIMAGE(@"home_search_icon")];
    [self addSubview:iconIv];
    [iconIv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY);
        make.leading.mas_equalTo(self.mas_leading).offset(12);
    }];
    
    self.contentF = [[UITextField alloc] init];
    [self addSubview:self.contentF];
    [self.contentF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY);
        make.trailing.mas_equalTo(self.mas_trailing).inset(12);
        make.leading.mas_equalTo(iconIv.mas_trailing).offset(12);
        make.height.mas_equalTo(30);
    }];
    self.contentF.returnKeyType = UIReturnKeySearch;
    self.contentF.delegate = self;
    self.contentF.font = FONT_SYSTEM(14);
    self.contentF.placeholder = @"看文章，领取通用流量";
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if(self.sureSearchBlock) {
        self.sureSearchBlock(textField.text);
    }
    return YES;
}

@end
