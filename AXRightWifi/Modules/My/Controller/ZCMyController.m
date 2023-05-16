//
//  ZCMyController.m
//  AXRightWifi
//
//  Created by oneStep on 2023/5/3.
//

#import "ZCMyController.h"
#import "ZCLoginController.h"

@interface ZCMyController ()

@end

@implementation ZCMyController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *logout = [[UIButton alloc] init];
    [self.view addSubview:logout];
    [logout mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view.mas_bottom).inset(TAB_BAR_HEIGHT+20);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(40);
    }];
    logout.backgroundColor = UIColor.redColor;
    [logout addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)logout {
    // 已登录，跳转主界面
    ZCLoginController *login = [[ZCLoginController alloc] init];
    ZCBaseNavController *nav = [[ZCBaseNavController alloc] initWithRootViewController:login];
    [UIApplication sharedApplication].keyWindow.rootViewController  = nav;
    [[UIApplication sharedApplication].keyWindow makeKeyAndVisible];
}

@end
