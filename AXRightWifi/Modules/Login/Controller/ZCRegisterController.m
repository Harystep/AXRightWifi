//
//  ZCRegisterController.m
//  AXRightWifi
//
//  Created by oneStep on 2023/5/3.
//

#import "ZCRegisterController.h"

@interface ZCRegisterController ()

@property (nonatomic,strong) UIScrollView *scView;

@property (nonatomic,strong) UIView *contentView;

@end

@implementation ZCRegisterController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self configureNavi];
    
    [self createSubviews];
}

- (void)createSubviews {
    self.scView = [[UIScrollView alloc] init];
    [self.view addSubview:self.scView];
    [self.scView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(self.naviView.mas_bottom);
    }];
    self.contentView = [[UIView alloc] init];
    [self.scView addSubview:self.contentView];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.scView);
        make.width.mas_equalTo(self.scView.mas_width);
    }];
    UILabel *titleL = [self.view createSimpleLabelWithTitle:@"注册" font:24 bold:YES color:COLOR_CONTENT];
    [self.contentView addSubview:titleL];
    [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
        make.top.mas_equalTo(self.naviView.mas_bottom).offset(5);
    }];
    
}

- (void)configureNavi {
    self.showNavStatus = YES;
    self.title = @"";
}

@end
