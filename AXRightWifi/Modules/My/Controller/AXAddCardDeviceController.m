//
//  AXAddCardDeviceController.m
//  AXRightWifi
//
//  Created by oneStep on 2023/5/17.
//

#import "AXAddCardDeviceController.h"
#import "MMScanViewController.h"

@interface AXAddCardDeviceController ()

@property (nonatomic,strong) UITextField *numF;

@end

@implementation AXAddCardDeviceController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureNavi];
    
    [self setupSubViews];
}

- (void)setupSubViews {
    UIView *bgView = [[UIView alloc] init];
    [self.view addSubview:bgView];
    bgView.backgroundColor = [ZCConfigColor whiteColor];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(self.view).inset(15);
        make.top.mas_equalTo(self.naviView.mas_bottom).offset(15);
        make.height.mas_equalTo(146);
    }];
    [bgView setViewCornerRadiu:10];
    
    UILabel *titleL = [self.view createSimpleLabelWithTitle:@"卡板编号：" font:16 bold:NO color:[ZCConfigColor txtColor]];
    [bgView addSubview:titleL];
    [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(bgView.mas_leading).offset(20);
        make.top.mas_equalTo(bgView.mas_top).offset(31);
        make.height.mas_equalTo(22);
        make.width.mas_equalTo(90);
    }];
    
    UIView *numView = [[UIView alloc] init];
    [bgView addSubview:numView];
    [numView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(titleL.mas_centerY);
        make.leading.mas_equalTo(titleL.mas_trailing);
        make.height.mas_equalTo(44);
        make.trailing.mas_equalTo(bgView.mas_trailing).inset(20);
    }];
    [numView setViewBorderWithColor:1 color:rgba(138, 138, 142, 1)];
    [numView setViewCornerRadiu:4];
    
    UIButton *codeBtn = [[UIButton alloc] init];
    [bgView addSubview:codeBtn];
    [codeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(numView.mas_centerY);
        make.width.height.mas_equalTo(44);
        make.trailing.mas_equalTo(numView.mas_trailing);
    }];
    [codeBtn setImage:kIMAGE(@"my_barcode_icon") forState:UIControlStateNormal];
    [codeBtn addTarget:self action:@selector(codeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.numF = [[UITextField alloc] init];
    [numView addSubview:self.numF];
    self.numF.placeholder = @"点击输入卡板编号";
    self.numF.font = FONT_SYSTEM(15);
    [self.numF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(numView.mas_centerY);
        make.height.mas_equalTo(30);
        make.leading.mas_equalTo(numView.mas_leading).offset(12);
        make.trailing.mas_equalTo(codeBtn.mas_leading).inset(4);
    }];
    
    UIButton *addBtn = [self.view createSimpleButtonWithTitle:@"添加" font:14 color:[ZCConfigColor whiteColor]];
    [bgView addSubview:addBtn];
    [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(numView.mas_bottom).offset(20);
        make.leading.trailing.bottom.mas_equalTo(bgView).inset(20);
    }];
    addBtn.backgroundColor = rgba(209, 29, 32, 1);
    [addBtn setViewCornerRadiu:4];
    [addBtn addTarget:self action:@selector(addBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)addBtnClick {
    if(self.numF.text.length > 0) {
        AXAlertView *alertView = [[AXAlertView alloc] init];
        [alertView showAlertView];
        alertView.title = @"添加提示";
        NSString *message = @"此卡号将会用于提取和充值流量，卡号一旦出错，概不负责，请先确认卡号无误后再点击添加。";
        NSString *colorStr = @"概不负责";
        NSRange range = [message rangeOfString:colorStr];
        alertView.alertMessage.attributedText = [message dn_changeColor:[ZCConfigColor redColor] andRange:range];
        alertView.confirmTitle = @"确定";
        alertView.cancleTitle = @"取消";
        kweakself(self);
        alertView.confirmBlock = ^{
            [weakself bindDeviceOperate];
        };
        
    }
}

- (void)bindDeviceOperate {
    [ZCMineManage bindUserDeviceOperateURL:@{@"iccid":checkSafeContent(self.numF.text)} completeHandler:^(id  _Nonnull responseObj) {
        [CFFHud showErrorWithTitle:checkSafeContent(responseObj[@"message"])];
        if(self.callBackBlock) {
            self.callBackBlock(@"");
        }
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

- (void)codeBtnClick {
    [self jumpScanCodeOperate];
}

- (void)configureNavi {
    self.showNavStatus = YES;
    self.titleStr = @"添加卡片";
    self.view.backgroundColor = [ZCConfigColor bgColor];
    self.naviView.backgroundColor = [ZCConfigColor whiteColor];
}

- (void)jumpScanCodeOperate {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        MMScanViewController *scanVC = [[MMScanViewController alloc]
                                        initWithQrType:MMScanTypeAll onFinish:^(NSString *result,
                                                                                NSError *error) {
            if (error) {
                NSLog(@"error: %@",error);
            } else {
                NSLog(@"扫描结果：%@",result);
                self.numF.text = result;
            }
        }];
        [self.navigationController pushViewController:scanVC animated:YES];
    });
    
}

@end
