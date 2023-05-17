

#import "AXAlertView.h"

@interface AXAlertView ()

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIView *verView;

@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, strong) UIButton *confirmBtn;
@property (nonatomic,assign) NSInteger mouse;
@property (nonatomic,strong) NSTimer *timer;

//@property (nonatomic, strong) UILabel  *alertMessage;

@end

@implementation AXAlertView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        if (@available(iOS 13.0, *)) {
            self.overrideUserInterfaceStyle = UIUserInterfaceStyleLight;
        } else {
        
        }
        [self setupSubviews];
        [self setupConstraints];
    }
    return self;
}

- (void)setupSubviews {
    
    self.contentView = [[UIView alloc] init];
    self.contentView.layer.cornerRadius  = 20.f;
    self.contentView.layer.masksToBounds = YES;
    self.contentView.backgroundColor = UIColor.whiteColor;
    
    self.lineView  = [[UIView alloc] init];
    self.lineView.backgroundColor = UIColor.groupTableViewBackgroundColor;
    
    self.verView  = [[UIView alloc] init];
    self.verView.backgroundColor = UIColor.groupTableViewBackgroundColor;
    
    self.cancelBtn = [[UIButton alloc] init];
    self.cancelBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [self.cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [self.cancelBtn setTitleColor:[ZCConfigColor subTxtColor] forState:UIControlStateNormal];
    [self.cancelBtn addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.confirmBtn = [[UIButton alloc] init];
    self.confirmBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [self.confirmBtn setTitle:@"确认" forState:UIControlStateNormal];
    [self.confirmBtn setTitleColor:[ZCConfigColor txtColor] forState:UIControlStateNormal];
    [self.confirmBtn addTarget:self action:@selector(confirmAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.alertTitle = [[UILabel alloc] init];
    self.alertTitle.font = [UIFont boldSystemFontOfSize:AUTO_FONT_SIZE(17)];
    self.alertTitle.text = @" ";
    self.alertTitle.numberOfLines = 0;
    self.alertTitle.lineBreakMode = NSLineBreakByCharWrapping;
    self.alertTitle.textColor = [ZCConfigColor txtColor];
    self.alertTitle.textAlignment = NSTextAlignmentCenter;
    
    self.alertMessage = [[UILabel alloc] init];
    self.alertMessage.font = FONT_SYSTEM(14);
    self.alertMessage.text = @"退款金额";
    self.alertMessage.textColor = [ZCConfigColor txtColor];
    self.alertMessage.textAlignment = NSTextAlignmentCenter;
    self.alertMessage.numberOfLines = 0;
}

- (void)setupConstraints {
    
    [self addSubview:self.contentView];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.centerY.mas_equalTo(self);
        make.width.mas_offset(SCREEN_W * 0.68);
    }];
    
    [self.contentView addSubview:self.alertTitle];
    [self.alertTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.contentView.mas_top).inset(AUTO_MARGIN(16)).priorityHigh();
        make.leading.trailing.mas_equalTo(self.contentView).inset(AUTO_MARGIN(20));
    }];
    
    [self.contentView addSubview:self.alertMessage];
    [self.alertMessage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.alertTitle.mas_bottom).mas_offset(AUTO_MARGIN(8)).priorityHigh();
        make.leading.trailing.mas_equalTo(self.alertTitle);
    }];
    
    [self.contentView addSubview:self.lineView];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.alertMessage.mas_bottom).mas_offset(AUTO_MARGIN(25));
        make.leading.trailing.mas_equalTo(self.contentView);
        make.height.mas_offset(1);
    }];
    
    [self.contentView addSubview:self.cancelBtn];
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.lineView.mas_bottom);
        make.leading.bottom.mas_equalTo(self.contentView);
        make.width.mas_offset(SCREEN_W * 0.34);
        make.height.mas_offset(SCREEN_W * 0.12);
    }];
    
    [self.contentView addSubview:self.confirmBtn];
    [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.bottom.mas_equalTo(self.cancelBtn);
        make.leading.mas_equalTo(self.cancelBtn.mas_trailing);
        make.trailing.mas_equalTo(self.contentView.mas_trailing);
    }];
    
    [self.contentView addSubview:self.verView];
    [self.verView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.lineView.mas_bottom);
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
        make.width.mas_equalTo(1);
        make.bottom.mas_equalTo(self.contentView.mas_bottom);
    }];
}

#pragma mark -- Public Methods
- (void)showAlertView {
    
    self.frame = UIScreen.mainScreen.bounds;
    [UIApplication.sharedApplication.keyWindow addSubview:self];
    self.contentView.transform = CGAffineTransformMakeScale(1.1, 1.1);
    [UIView animateWithDuration:0.35 animations:^{
       
        self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.4];
        self.contentView.transform = CGAffineTransformIdentity;
    }];
}

#pragma mark -- Private Methods
- (void)cancelAction {
    
    [self hideAlertView];
    if (self.cancelBlock) {
        self.cancelBlock();
    }
}

- (void)confirmAction {
 
    [self hideAlertView];
    if (self.confirmBlock) {
        self.confirmBlock();
    }
}

- (void)hideAlertView {
    
    self.contentView.transform = CGAffineTransformIdentity;
    [UIView animateWithDuration:0.35 animations:^{
        
        self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];
        self.contentView.transform = CGAffineTransformMakeScale(0.1, 0.1);
        self.alpha = 0.0;
        
    } completion:^(BOOL finished) {
       
        [self removeFromSuperview];
    }];
}

- (void)setStartTimer:(NSInteger)startTimer {
    _startTimer = startTimer;
    self.mouse = startTimer;
    self.confirmBtn.backgroundColor = [ZCConfigColor bgColor];
    [self.confirmBtn setTitleColor:[ZCConfigColor subTxtColor] forState:UIControlStateNormal];
    self.confirmBtn.userInteractionEnabled = NO;
    [self.confirmBtn setTitle:[NSString stringWithFormat:@"%@(%tus)", self.confirmTitle, startTimer] forState:UIControlStateNormal];
    self.alertMessage.textAlignment = NSTextAlignmentLeft;
    kweakself(self);
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
        [weakself startMouse];
    }];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)startMouse {
    self.mouse --;
    if (self.mouse > 0) {
        NSLog(@"mouse---%tu", self.mouse);
        NSString *content = [NSString stringWithFormat:@"我承诺(%tus)", self.mouse];
        [self.confirmBtn setTitle:content forState:UIControlStateNormal];
    } else {
        [self.timer invalidate];
        self.timer = nil;
        [self.confirmBtn setTitle:self.confirmTitle forState:UIControlStateNormal];
        self.confirmBtn.userInteractionEnabled = YES;
        self.confirmBtn.backgroundColor = [ZCConfigColor redColor];
        [self.confirmBtn setTitleColor:[ZCConfigColor whiteColor] forState:UIControlStateNormal];
    }
}

- (void)setTitle:(NSString *)title {
    
    _title = title;
    self.alertTitle.text = title;
}

- (void)setMessage:(NSString *)message {
    
    _message = message;
    self.alertMessage.text = message;
}

- (void)setCancleTitle:(NSString *)cancleTitle {
    
    _cancleTitle = cancleTitle;
    [self.cancelBtn setTitle:cancleTitle forState:UIControlStateNormal];
}

- (void)setConfirmTitle:(NSString *)confirmTitle {
    
    _confirmTitle = confirmTitle;
    [self.confirmBtn setTitle:confirmTitle forState:UIControlStateNormal];
}

- (void)setTitleColor:(UIColor *)titleColor {
    
    _titleColor = titleColor;
    self.alertTitle.textColor = titleColor;
}

- (void)setMessageColor:(UIColor *)messageColor {
    
    _messageColor = messageColor;
    self.alertMessage.textColor = messageColor;
}

- (void)setCancelTitleColor:(UIColor *)cancelTitleColor {
    
    _cancelTitleColor = cancelTitleColor;
    [self.cancelBtn setTitleColor:cancelTitleColor forState:UIControlStateNormal];
}

- (void)setConfirmTitleColor:(UIColor *)confirmTitleColor {
    
    _confirmTitleColor = confirmTitleColor;
    [self.confirmBtn setTitleColor:confirmTitleColor forState:UIControlStateNormal];
}

- (void)setConfirmBackgroundColor:(UIColor *)confirmBackgroundColor {
    
    _confirmBackgroundColor = confirmBackgroundColor;
    self.confirmBtn.backgroundColor = confirmBackgroundColor;
}


- (void)setHideCancelBtn:(BOOL)hideCancelBtn {
    
    _hideCancelBtn = hideCancelBtn;
    self.cancelBtn.hidden = YES;
    [self.cancelBtn mas_updateConstraints:^(MASConstraintMaker *make) {
       
        make.width.mas_offset(0);
    }];
}

@end
