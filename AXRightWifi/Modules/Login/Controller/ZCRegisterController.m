//
//  ZCRegisterController.m
//  AXRightWifi
//
//  Created by oneStep on 2023/5/3.
//

#import "ZCRegisterController.h"
#import "ZCLoginFieldView.h"
#import "ZCTabBarController.h"

@interface ZCRegisterController ()<UITextViewDelegate>

@property (nonatomic,strong) UIScrollView *scView;

@property (nonatomic,strong) UIView *contentView;

@property (nonatomic,strong) ZCLoginFieldView *accountView;

@property (nonatomic,strong) ZCLoginFieldView *pwdView;

@property (nonatomic,strong) ZCLoginFieldView *surePwdView;

@property (nonatomic,strong) ZCLoginFieldView *phoneView;

@property (nonatomic,strong) ZCLoginFieldView *codeView;

@property (nonatomic,strong) ZCLoginFieldView *inviteView;

@property (nonatomic,strong) UIButton *selBtn;

@property (nonatomic,strong) UIButton *codeBtn;

@property (nonatomic,strong) NSTimer *timer;

@property (nonatomic,assign) NSInteger mouse;//


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
        make.height.mas_equalTo(34);
    }];
    
    self.accountView = [[ZCLoginFieldView alloc] init];
    [self.contentView addSubview:self.accountView];
    [self.accountView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(self.contentView).inset(25);
        make.top.mas_equalTo(titleL.mas_bottom).offset(30);
        make.height.mas_equalTo(50);
    }];
    self.accountView.contentF.placeholder = @"账号";
    
    UILabel *alertL = [self.view createSimpleLabelWithTitle:@"*账号限3-6位英文或数字，不能包括空格" font:12 bold:NO color:rgba(245, 72, 60, 1)];
    [self.contentView addSubview:alertL];
    [alertL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.accountView.mas_leading);
        make.height.mas_equalTo(17);
        make.top.mas_equalTo(self.accountView.mas_bottom).offset(5);
    }];
    
    self.pwdView = [[ZCLoginFieldView alloc] init];
    [self.contentView addSubview:self.pwdView];
    [self.pwdView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(self.contentView).inset(25);
        make.top.mas_equalTo(alertL.mas_bottom).offset(15);
        make.height.mas_equalTo(50);
    }];
    self.pwdView.contentF.placeholder = @"密码";
    self.pwdView.contentF.secureTextEntry = YES;
    
    UILabel *pwdAlertL = [self.view createSimpleLabelWithTitle:@"*密码不低于6位数，不能包括空格" font:12 bold:NO color:rgba(245, 72, 60, 1)];
    [self.contentView addSubview:pwdAlertL];
    [pwdAlertL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.pwdView.mas_leading);
        make.height.mas_equalTo(17);
        make.top.mas_equalTo(self.pwdView.mas_bottom).offset(5);
    }];
 
    self.surePwdView = [[ZCLoginFieldView alloc] init];
    [self.contentView addSubview:self.surePwdView];
    [self.surePwdView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(self.contentView).inset(25);
        make.top.mas_equalTo(pwdAlertL.mas_bottom).offset(15);
        make.height.mas_equalTo(50);
    }];
    self.surePwdView.contentF.placeholder = @"确认密码";
    self.surePwdView.contentF.secureTextEntry = YES;
    
    self.phoneView = [[ZCLoginFieldView alloc] init];
    [self.contentView addSubview:self.phoneView];
    [self.phoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(self.contentView).inset(25);
        make.top.mas_equalTo(self.surePwdView.mas_bottom).offset(15);
        make.height.mas_equalTo(50);
    }];
    self.phoneView.contentF.keyboardType = UIKeyboardTypeNumberPad;
    self.phoneView.contentF.placeholder = @"手机号";
    
    self.codeView = [[ZCLoginFieldView alloc] init];
    [self.contentView addSubview:self.codeView];
    [self.codeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(self.contentView).inset(25);
        make.top.mas_equalTo(self.phoneView.mas_bottom).offset(15);
        make.height.mas_equalTo(50);
    }];
    self.codeView.contentF.keyboardType = UIKeyboardTypeNumberPad;
    self.codeView.contentF.placeholder = @"验证码";
    
    self.inviteView = [[ZCLoginFieldView alloc] init];
    [self.contentView addSubview:self.inviteView];
    [self.inviteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(self.contentView).inset(25);
        make.top.mas_equalTo(self.codeView.mas_bottom).offset(15);
        make.height.mas_equalTo(50);
    }];
    self.inviteView.contentF.placeholder = @"邀请码(选填)";
    
    UIButton *registerBtn = [self.view createSimpleButtonWithTitle:@"注册" font:16 color:[ZCConfigColor whiteColor]];
    [self.view addSubview:registerBtn];
    [registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(self.view).inset(25);
        make.top.mas_equalTo(self.inviteView.mas_bottom).offset(15);
        make.height.mas_equalTo(60);
    }];
    [registerBtn setBackgroundImage:kIMAGE(@"login_btn_bg") forState:UIControlStateNormal];
    [registerBtn addTarget:self action:@selector(registerOperate) forControlEvents:UIControlEventTouchUpInside];
       
    UIButton *selBtn = [[UIButton alloc] init];
    [selBtn setImage:[UIImage imageNamed:@"protocol_agree_nor"] forState:UIControlStateNormal];
    [selBtn setImage:[UIImage imageNamed:@"protocol_agree_sel"] forState:UIControlStateSelected];
    [selBtn addTarget:self action:@selector(agreeProtocol:) forControlEvents:UIControlEventTouchUpInside];
    self.selBtn = selBtn;
    [self.contentView addSubview:selBtn];
    [selBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.mas_equalTo(20);
        make.leading.mas_equalTo(registerBtn.mas_leading);
        make.top.mas_equalTo(registerBtn.mas_bottom).offset(5);
    }];
    [selBtn addTarget:self action:@selector(agreeProtocol:) forControlEvents:UIControlEventTouchUpInside];
    
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
    protocolView.delegate = self;
    [self.contentView addSubview:protocolView];
    [protocolView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(selBtn.mas_trailing);
        make.top.mas_equalTo(registerBtn.mas_bottom);
        make.trailing.mas_equalTo(registerBtn.mas_trailing);
        make.height.mas_equalTo(35);
    }];
    UIImageView *bottomIv = [[UIImageView alloc] initWithImage:kIMAGE(@"register_bottom_bg")];
//    bottomIv.contentMode = UIViewContentModeScaleAspectFill;
    if(iPhone_X) {
        [protocolView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.contentView.mas_bottom);
        }];
        [self.view addSubview:bottomIv];
        [bottomIv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.mas_equalTo(self.view);
            make.bottom.mas_equalTo(self.view.mas_bottom);
        }];
    } else {
        [self.contentView addSubview:bottomIv];
        [bottomIv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.mas_equalTo(self.contentView);
            make.top.mas_equalTo(protocolView.mas_bottom).offset(12);
        }];
    }
    
    [self configureSendCodeViewSubviews];
}
#pragma mark - 配置发送验证码视图
- (void)configureSendCodeViewSubviews {
    UIImageView *lineIv = [[UIImageView alloc] initWithImage:kIMAGE(@"register_sep_line")];
    [self.codeView addSubview:lineIv];
    [lineIv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.codeView.mas_centerY);
        make.trailing.mas_equalTo(self.codeView.mas_trailing).inset(110);
    }];
    
    self.codeBtn = [self.view createSimpleButtonWithTitle:@"获取验证码" font:16 color:[ZCConfigColor redColor]];
    [self.codeView addSubview:self.codeBtn];
    [self.codeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.codeView.mas_centerY);
        make.height.mas_equalTo(30);
        make.trailing.mas_equalTo(self.codeView.mas_trailing).inset(12);
    }];
    [self.codeBtn addTarget:self action:@selector(sendCodeOperate) forControlEvents:UIControlEventTouchUpInside];
    
}
#pragma mark - 发送验证码
- (void)sendCodeOperate {
    NSDictionary *parms = @{@"usage":@"register",
                            @"mobile":checkSafeContent(self.phoneView.contentF.text)
    };
    [ZCLoginManage sendPhoneCodeOperate:parms completeHandler:^(id  _Nonnull responseObj) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self startTimer];
            self.codeView.contentF.text = checkSafeContent(responseObj[@"data"]);
        });
    }];
}

#pragma -- mark 60s倒计时时间
- (void)mouseOperate {
            
    self.mouse --;
    if (self.mouse == 0) {
        self.mouse = 60;
        [self configureCodeBtnStatus:YES];
        [self.codeBtn setTitle:NSLocalizedString(@"获取验证码", nil) forState:UIControlStateNormal];
        [self fireTimer];
    } else {
        self.codeBtn.userInteractionEnabled = NO;
        [self configureCodeBtnStatus:NO];
        [self.codeBtn setTitle:[NSString stringWithFormat:@"%zds%@", self.mouse, NSLocalizedString(@"后获取", nil)] forState:UIControlStateNormal];
    }
}

- (void)configureCodeBtnStatus:(BOOL)status {
    if (status) {
        [self.codeBtn setTitleColor:[ZCConfigColor redColor] forState:UIControlStateNormal];
    } else {
        [self.codeBtn setTitleColor:COLOR_SUB_CONTENT forState:UIControlStateNormal];
    }
    self.codeBtn.userInteractionEnabled = status;
}

- (void)startTimer {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(mouseOperate) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)fireTimer {
    [self.timer invalidate];
    self.timer = nil;
}

- (void)agreeProtocol:(UIButton *)sender {
    sender.selected = !sender.selected;
}

#pragma mark - 注册操作
- (void)registerOperate {
    NSString *account = self.accountView.contentF.text;
    NSString *pwd = self.pwdView.contentF.text;
    NSString *surePwd = self.surePwdView.contentF.text;
    NSString *phone = self.phoneView.contentF.text;
    NSString *code = self.codeView.contentF.text;
    NSString *invite = self.inviteView.contentF.text;
    NSMutableDictionary *dictM = [NSMutableDictionary dictionaryWithDictionary:@{@"mobile":checkSafeContent(phone),
                                                                                 @"username":checkSafeContent(account),
                                                                                 @"password":checkSafeContent(pwd),
                                                                                 @"password_repetition":checkSafeContent(surePwd),
                                                                                 @"group":@"ios",
                                                                                 @"code":checkSafeContent(code),                                            
                                                                               }];
    if(invite.length > 0) {
        [dictM setValue:invite forKey:@"promo_code"];
    }
    
    [ZCLoginManage registerAccountOperateURL:dictM completeHandler:^(id  _Nonnull responseObj) {
        
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

- (void)configureNavi {
    self.showNavStatus = YES;
    self.title = @"";
    self.mouse = 60;
}

@end
