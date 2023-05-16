//
//  AXTitleLabelView.m
//  AXRightWifi
//
//  Created by oneStep on 2023/5/16.
//

#import "AXTitleLabelView.h"

@interface AXTitleLabelView ()

@property (nonatomic,strong) NSMutableArray *viewArr;

@property (nonatomic,strong) UIView *lineView;

@property (nonatomic,strong) UIButton *selectBtn;

@end

@implementation AXTitleLabelView

- (instancetype)initWithFrame:(CGRect)frame {
    if(self == [super initWithFrame:frame]) {
        
        [self createSubviews];
    }
    return self;
}

- (void)createSubviews {

    self.viewArr = [NSMutableArray array];
    NSArray *dataArr = @[@"卡片流量", @"设备流量"];
    CGFloat marginX = 20;
    CGFloat margin = 25;
    for (int i = 0; i < dataArr.count; i ++) {
        UIButton *btn = [self createSimpleButtonWithTitle:dataArr[i] font:16 color:[ZCConfigColor subTxtColor]];
        [self addSubview:btn];
        [self.viewArr addObject:btn];
        if(i == 0) {
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.leading.mas_equalTo(self.mas_leading).offset(marginX);
                make.height.mas_equalTo(32);
                make.bottom.top.mas_equalTo(self);
            }];
            [self configureViewStatus:YES view:btn];
            self.lineView = [[UIView alloc] init];
            [self addSubview:self.lineView];
            self.lineView.backgroundColor = [ZCConfigColor txtColor];
            [self.lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(btn.mas_centerX);
                make.bottom.mas_equalTo(self.mas_bottom);
                make.height.mas_equalTo(2);
                make.width.mas_equalTo(btn.mas_width);
            }];
            self.selectBtn = btn;
        } else {
            UIButton *preBtn = self.viewArr[i-1];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.leading.mas_equalTo(preBtn.mas_trailing).offset(margin);
                make.height.mas_equalTo(32);
                make.bottom.top.mas_equalTo(self);
            }];
        }
        btn.tag = i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)btnClick:(UIButton *)sender {
    if(self.selectBtn == sender)return;
    [self configureViewStatus:YES view:sender];
    [self configureViewStatus:NO view:self.selectBtn];
    self.selectBtn = sender;
    [self.lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(sender.mas_centerX);
        make.bottom.mas_equalTo(self.mas_bottom);
        make.height.mas_equalTo(2);
        make.width.mas_equalTo(sender.mas_width);
    }];
}

- (void)setTitleArr:(NSArray *)titleArr {
    _titleArr = titleArr;
    for (int i = 0; i < titleArr.count; i ++) {
        UIButton *btn = self.viewArr[i];
        [btn setTitle:titleArr[i] forState:UIControlStateNormal];
    }
}

- (void)configureViewStatus:(BOOL)status view:(UIButton *)sender {
    if(status) {
        sender.titleLabel.font = FONT_BOLD(16);
        [sender setTitleColor:[ZCConfigColor txtColor] forState:UIControlStateNormal];
    } else {
        sender.titleLabel.font = FONT_SYSTEM(16);
        [sender setTitleColor:[ZCConfigColor subTxtColor] forState:UIControlStateNormal];
    }
}

@end
