//
//  ZCForgetController.m
//  AXRightWifi
//
//  Created by oneStep on 2023/5/3.
//

#import "ZCForgetController.h"
#import "ZCLoginFieldView.h"
#import "ZCTabBarController.h"

@interface ZCForgetController ()

@property (nonatomic,strong) UIScrollView *scView;

@property (nonatomic,strong) UIView *contentView;

@property (nonatomic,strong) ZCLoginFieldView *pwdView;

@property (nonatomic,strong) ZCLoginFieldView *surePwdView;

@property (nonatomic,strong) ZCLoginFieldView *phoneView;

@property (nonatomic,strong) ZCLoginFieldView *codeView;

@property (nonatomic,strong) UIButton *codeBtn;

@property (nonatomic,strong) NSTimer *timer;

@property (nonatomic,assign) NSInteger mouse;//

@end

@implementation ZCForgetController

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
    UILabel *titleL = [self.view createSimpleLabelWithTitle:@"修改密码" font:24 bold:YES color:COLOR_CONTENT];
    [self.contentView addSubview:titleL];
    [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
        make.top.mas_equalTo(self.naviView.mas_bottom).offset(5);
        make.height.mas_equalTo(34);
    }];
    
    self.phoneView = [[ZCLoginFieldView alloc] init];
    [self.contentView addSubview:self.phoneView];
    [self.phoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(self.contentView).inset(25);
        make.top.mas_equalTo(titleL.mas_bottom).offset(30);
        make.height.mas_equalTo(50);
    }];
    self.phoneView.contentF.keyboardType = UIKeyboardTypeNumberPad;
    self.phoneView.contentF.placeholder = @"手机号";
    
    self.pwdView = [[ZCLoginFieldView alloc] init];
    [self.contentView addSubview:self.pwdView];
    [self.pwdView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(self.contentView).inset(25);
        make.top.mas_equalTo(self.phoneView.mas_bottom).offset(15);
        make.height.mas_equalTo(50);
    }];
    self.pwdView.contentF.placeholder = @"密码";
    self.pwdView.contentF.secureTextEntry = YES;
    
    self.surePwdView = [[ZCLoginFieldView alloc] init];
    [self.contentView addSubview:self.surePwdView];
    [self.surePwdView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(self.contentView).inset(25);
        make.top.mas_equalTo(self.pwdView.mas_bottom).offset(15);
        make.height.mas_equalTo(50);
    }];
    self.surePwdView.contentF.placeholder = @"确认密码";
    self.surePwdView.contentF.secureTextEntry = YES;
    
    self.codeView = [[ZCLoginFieldView alloc] init];
    [self.contentView addSubview:self.codeView];
    [self.codeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(self.contentView).inset(25);
        make.top.mas_equalTo(self.surePwdView.mas_bottom).offset(15);
        make.height.mas_equalTo(50);
    }];
    self.codeView.contentF.keyboardType = UIKeyboardTypeNumberPad;
    self.codeView.contentF.placeholder = @"验证码";
    
    UIButton *registerBtn = [self.view createSimpleButtonWithTitle:@"确定" font:16 color:[ZCConfigColor whiteColor]];
    [self.view addSubview:registerBtn];
    [registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(self.view).inset(25);
        make.top.mas_equalTo(self.codeView.mas_bottom).offset(15);
        make.height.mas_equalTo(60);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).inset(20);
    }];
    [registerBtn setBackgroundImage:kIMAGE(@"login_btn_bg") forState:UIControlStateNormal];
    [registerBtn addTarget:self action:@selector(registerOperate) forControlEvents:UIControlEventTouchUpInside];
    
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
    NSDictionary *parms = @{@"usage":@"up-pwd",
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
    if (self.mouse < 1) {
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

#pragma mark - 注册操作
- (void)registerOperate {    
    NSString *pwd = self.pwdView.contentF.text;
    NSString *surePwd = self.surePwdView.contentF.text;
    NSString *phone = self.phoneView.contentF.text;
    NSString *code = self.codeView.contentF.text;
    NSMutableDictionary *dictM = [NSMutableDictionary dictionaryWithDictionary:@{@"mobile":checkSafeContent(phone),
                                                                                 @"password":checkSafeContent(pwd),
                                                                                 @"password_repetition":checkSafeContent(surePwd),
                                                                                 @"group":@"ios",
                                                                                 @"code":checkSafeContent(code),
                                                                               }];
    
    [ZCLoginManage changeAccountPwdOperateURL:dictM completeHandler:^(id  _Nonnull responseObj) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self fireTimer];
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
}

@end
