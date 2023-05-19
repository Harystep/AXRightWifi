//
//  AXArticleCommentFooterView.m
//  AXRightWifi
//
//  Created by oneStep on 2023/5/19.
//

#import "AXArticleCommentFooterView.h"

@interface AXArticleCommentFooterView ()

@property (nonatomic,strong) UITextField *contengF;

@end

@implementation AXArticleCommentFooterView

- (instancetype)initWithFrame:(CGRect)frame {
    if(self == [super initWithFrame:frame]) {
        self.backgroundColor = [ZCConfigColor whiteColor];
        [self createSubviews];
    }
    return self;
}

- (void)createSubviews {
    
    UIView *bgView = [[UIView alloc] init];
    [self addSubview:bgView];
    bgView.backgroundColor = rgba(217, 217, 217, 0.40);
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(self).inset(15);
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(self.mas_top).offset(20);
    }];
    [bgView setViewCornerRadiu:20];
    
    UIButton *sendBtn = [self createSimpleButtonWithTitle:@"发送" font:13 color:rgba(209, 29, 32, 1)];
    [bgView addSubview:sendBtn];
    [sendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(60);
        make.bottom.top.trailing.mas_equalTo(bgView);
    }];
    [sendBtn addTarget:self action:@selector(sendOperate) forControlEvents:UIControlEventTouchUpInside];
    
    UITextField *contengF = [[UITextField alloc] init];
    [bgView addSubview:contengF];
    [contengF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(bgView.mas_leading).offset(15);
        make.trailing.mas_equalTo(sendBtn.mas_leading).inset(5);
        make.top.bottom.mas_equalTo(bgView);
    }];
    self.contengF = contengF;
    contengF.font = FONT_SYSTEM(14);
    contengF.placeholder = @"发表您的看法，记得友善评论哦~";
}

- (void)sendOperate {
    if(self.contengF.text.length > 0) {
        if(self.sendCommentBlock) {
            self.sendCommentBlock(self.contengF.text);
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.contengF.text = @"";
            });
        }
    }
}

@end
