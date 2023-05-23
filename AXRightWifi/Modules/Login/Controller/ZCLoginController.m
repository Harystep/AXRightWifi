//
//  ZCLoginController.m
//  AXRightWifi
//
//  Created by oneStep on 2023/5/3.
//

#import "ZCLoginController.h"
#import "ZCLoginFieldView.h"
#import "ZCTabBarController.h"

@interface ZCLoginController ()

@property (nonatomic,strong) ZCLoginFieldView *phoneView;
@property (nonatomic,strong) ZCLoginFieldView *passwordView;
@property (nonatomic,strong) UIButton *selBtn;

@end

@implementation ZCLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *topBg = [[UIImageView alloc] initWithImage:kIMAGE(@"logo_top_bg")];
    [self.view addSubview:topBg];
    [topBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.top.mas_equalTo(self.view);
    }];
    
    UILabel *titleL = [self.view createSimpleLabelWithTitle:@"欢迎使用右量" font:24 bold:YES color:[ZCConfigColor txtColor]];
    [self.view addSubview:titleL];
    [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(topBg.mas_bottom).offset(28);
        make.height.mas_equalTo(34);
    }];
    
    self.phoneView = [[ZCLoginFieldView alloc] init];
    [self.view addSubview:self.phoneView];
    [self.phoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(self.view).inset(25);
        make.top.mas_equalTo(titleL.mas_bottom).offset(30);
        make.height.mas_equalTo(50);
    }];
    self.phoneView.contentF.placeholder = @"账号";
    
    self.passwordView = [[ZCLoginFieldView alloc] init];
    [self.view addSubview:self.passwordView];
    [self.passwordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(self.view).inset(25);
        make.top.mas_equalTo(self.phoneView.mas_bottom).offset(15);
        make.height.mas_equalTo(50);
    }];
    self.passwordView.contentF.placeholder = @"密码";
    self.passwordView.contentF.secureTextEntry = YES;
    
    UIButton *loginBtn = [self.view createSimpleButtonWithTitle:@"登录" font:16 color:[ZCConfigColor whiteColor]];
    [self.view addSubview:loginBtn];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(self.view).inset(25);
        make.top.mas_equalTo(self.passwordView.mas_bottom).offset(38);
        make.height.mas_equalTo(60);
    }];
    [loginBtn setBackgroundImage:kIMAGE(@"login_btn_bg") forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(loginOperate) forControlEvents:UIControlEventTouchUpInside];
       
    UIView *alertView = [[UIView alloc] init];
    [self.view addSubview:alertView];
    [alertView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(self.view).inset(25);
        make.top.mas_equalTo(self.passwordView.mas_bottom);
        make.height.mas_equalTo(38);
    }];
    [self setupRegisterAlertView:alertView];
    
    UIButton *selBtn = [[UIButton alloc] init];
    [selBtn setImage:[UIImage imageNamed:@"protocol_agree_nor"] forState:UIControlStateNormal];
    [selBtn setImage:[UIImage imageNamed:@"protocol_agree_sel"] forState:UIControlStateSelected];
    [selBtn addTarget:self action:@selector(agreeProtocol:) forControlEvents:UIControlEventTouchUpInside];
    self.selBtn = selBtn;
    [self.view addSubview:selBtn];
    [selBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.mas_equalTo(15);
        make.leading.mas_equalTo(loginBtn.mas_leading);
        make.top.mas_equalTo(loginBtn.mas_bottom).offset(10);
    }];
    self.selBtn.selected = YES;
    
    UITextView *protocolView = [[UITextView alloc] init];
    protocolView.textColor = UIColor.darkGrayColor;
    NSString *protocolStr   = @"注册即表示您已详细阅读并同意《服务协议》与《隐私政策》";
    NSString *linkString1 = @"《服务协议》";
    NSRange linkRange1 = [protocolStr rangeOfString:linkString1];
    NSString *linkString2 = @"《隐私政策》";
    NSRange linkRange2 = [protocolStr rangeOfString:linkString2];
    protocolView.textColor = COLOR_SUB_CONTENT;
    protocolView.linkTextAttributes = @{};
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:protocolStr];
    [attributeString addAttributes:@{NSLinkAttributeName:k_User_PRIVACY_URL} range:linkRange1];
    [attributeString addAttributes:@{NSFontAttributeName:FONT_SYSTEM(12), NSForegroundColorAttributeName:[ZCConfigColor redColor]} range:linkRange1];
    
    [attributeString addAttributes:@{NSLinkAttributeName:k_User_Agreement_URL} range:linkRange2];
    [attributeString addAttributes:@{NSFontAttributeName:FONT_SYSTEM(12), NSForegroundColorAttributeName:[ZCConfigColor redColor]} range:linkRange2];
    protocolView.attributedText = attributeString;    
    [self.view addSubview:protocolView];
    [protocolView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(selBtn.mas_trailing);
        make.top.mas_equalTo(loginBtn.mas_bottom);
        make.trailing.mas_equalTo(loginBtn.mas_trailing);
        make.height.mas_equalTo(35);
    }];
}

- (void)agreeProtocol:(UIButton *)sender {
    sender.selected = !sender.selected;
}

- (void)setupRegisterAlertView:(UIView *)alertView {
    UILabel *subL = [self.view createSimpleLabelWithTitle:@"还没账号？" font:12 bold:NO color:COLOR_SUB_CONTENT];
    [alertView addSubview:subL];
    [subL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(17);
        make.leading.mas_equalTo(alertView.mas_leading);
        make.top.mas_equalTo(alertView.mas_top).offset(10);
    }];
    
    UIButton *registerBtn = [self.view createSimpleButtonWithTitle:@"立即注册" font:12 color:rgba(245, 72, 60, 1)];
    [alertView addSubview:registerBtn];
    [registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(subL.mas_centerY);
        make.height.mas_equalTo(18);
        make.leading.mas_equalTo(subL.mas_trailing);
    }];
    [registerBtn addTarget:self action:@selector(registerOperate) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *forgetBtn = [self.view createSimpleButtonWithTitle:@"忘记密码" font:12 color:COLOR_SUB_CONTENT];
    [alertView addSubview:forgetBtn];
    [forgetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(subL.mas_centerY);
        make.height.mas_equalTo(18);
        make.trailing.mas_equalTo(alertView.mas_trailing);
    }];
    [forgetBtn addTarget:self action:@selector(forgetOperate) forControlEvents:UIControlEventTouchUpInside];
    
    
    
}
#pragma mark - 忘记密码
- (void)forgetOperate {
    [HCRouter router:@"Forget" params:@{} viewController:self animated:YES];
}
#pragma mark - 注册
- (void)registerOperate {
    [HCRouter router:@"Register" params:@{} viewController:self animated:YES];
}

#pragma mark - Comparing Dates
- (void)loginOperate {
    NSString *phone = self.phoneView.contentF.text;
    NSString *pwd = self.passwordView.contentF.text;
    if(phone.length == 0) {
        [[CFFAlertView sharedInstance] showTextMsg:@"请输入账号"];
        return;
    }
    if(pwd.length < 6) {
        [[CFFAlertView sharedInstance] showTextMsg:@"密码输入有误"];
        return;
    }
    NSDictionary *parms = @{@"username":checkSafeContent(phone),
                            @"password":pwd,
                            @"group":@"ios"
    };
    [ZCLoginManage loginAccountOperateURL:parms completeHandler:^(id  _Nonnull responseObj) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self jumpMainUI];
        });
    }];
}

- (void)jumpMainUI {
    // 已登录，跳转主界面
    ZCTabBarController *tabBar = [[ZCTabBarController alloc] init];
    [UIApplication sharedApplication].keyWindow.rootViewController  = tabBar;
    [[UIApplication sharedApplication].keyWindow makeKeyAndVisible];
}
@end
