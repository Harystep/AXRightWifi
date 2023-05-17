//
//  ZCMyController.m
//  AXRightWifi
//
//  Created by oneStep on 2023/5/3.
//

#import "ZCMyController.h"
#import "ZCLoginController.h"
#import "AXMyTopView.h"
#import "AXMyBaseFuncCell.h"
#import "AXBindCardHeadView.h"
#import "AXBindCardFooterView.h"
#import "AXUserBindItemCell.h"

@interface ZCMyController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic,strong) AXMyTopView *topView;

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSArray *deviceArr;

@property (nonatomic,strong) NSArray *cardArr;

@property (nonatomic,assign) int bindType;//1:卡 2 设备

@property (nonatomic,strong) AXBindCardHeadView *cardHeadView;

@end

@implementation ZCMyController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getUserBaseInfo];
    [self getUserBindCardInfo];
    [self getUserBindDeviceInfo];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [ZCConfigColor bgColor];
    UIImageView *bgIv = [[UIImageView alloc] initWithImage:kIMAGE(@"my_top_bg")];
    [self.view addSubview:bgIv];
    [bgIv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.top.mas_equalTo(self.view);
        make.height.mas_equalTo(230);
    }];
    self.bindType = 1;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(self.view);
        make.leading.trailing.mas_equalTo(self.view).inset(15);
    }];
    
    self.topView = [[AXMyTopView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W-30, 315)];
    self.tableView.tableHeaderView = self.topView;        
    
}

- (void)getUserBaseInfo {
    [ZCMineManage getUserBaseInfoURL:@{} completeHandler:^(id  _Nonnull responseObj) {
        NSLog(@"baseinfo:%@", responseObj);
        
    }];
}

- (void)getUserBindCardInfo {
    [ZCMineManage getUserBindInfoURL:@{@"sim_card_type":@"1"} completeHandler:^(id  _Nonnull responseObj) {
        NSLog(@"bindCard:%@", responseObj);
        self.cardArr = [ZCBaseDataTool convertSafeArray:responseObj[@"data"]];
        dispatch_async(dispatch_get_main_queue(), ^{
            NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:0];
            [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
        });
    }];
}

- (void)getUserBindDeviceInfo {
    [ZCMineManage getUserBindInfoURL:@{@"sim_card_type":@"2"} completeHandler:^(id  _Nonnull responseObj) {
        NSLog(@"bindDevice:%@", responseObj);
        self.deviceArr = [ZCBaseDataTool convertSafeArray:responseObj[@"data"]];
    }];
}

- (void)routerWithEventName:(NSString *)eventName userInfo:(NSDictionary *)userInfo {
    if([eventName isEqualToString:@"退出登录"]) {
        AXAlertView *alertView = [[AXAlertView alloc] init];
        [alertView showAlertView];
        alertView.message = @"是否确定退出";
        alertView.confirmTitle = @"确定";
        alertView.cancleTitle = @"取消";
        alertView.confirmBlock = ^{            
            [ZCUserInfo logout];
        };
    } else if ([eventName isEqualToString:@"卡片流量"]) {
        self.topView.dataDic = @{};
    } else if ([eventName isEqualToString:@"设备流量"]) {
        self.topView.dataDic = @{};
    } else if ([eventName isEqualToString:@"我的流量卡"]) {
        self.bindType = 1;
        NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:0];
        [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    } else if ([eventName isEqualToString:@"我的WiFi设备"]) {
        self.bindType = 2;
        NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:0];
        [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == 0) {
        return self.bindType == 1?self.cardArr.count:self.deviceArr.count;
    } else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 1) {
        AXMyBaseFuncCell *cell = [AXMyBaseFuncCell baseFuncCellWithTableView:tableView indexPath:indexPath];
        return cell;
    } else {
        AXUserBindItemCell *cell = [AXUserBindItemCell userBindItemCellWithTableView:tableView indexPath:indexPath];
        return cell;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if(section == 0) {
        AXBindCardFooterView *footer = [[AXBindCardFooterView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W-30, 54)];
        footer.haveDataFlag = self.bindType == 1?self.cardArr.count:self.deviceArr.count;
        return footer;
    } else {
        return [UIView new];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if(section == 0) {
        UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W-30, 42)];
        [headView addSubview:self.cardHeadView];        
        return headView;
    } else {
        return [UIView new];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if(section == 0) {
        return 42;
    } else {
        return .01;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if(section == 0) {
        return 54;
    } else {
        return .01;
    }
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.backgroundColor = UIColor.clearColor;
        [_tableView registerClass:[AXMyBaseFuncCell class] forCellReuseIdentifier:@"AXMyBaseFuncCell"];
        [_tableView registerClass:[AXUserBindItemCell class] forCellReuseIdentifier:@"AXUserBindItemCell"];
        if (@available(iOS 15.0, *)) {
            _tableView.sectionHeaderTopPadding = 0;
        }
        if (@available(iOS 11.0, *)) {
            self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _tableView;
}

- (AXBindCardHeadView *)cardHeadView {
    if(_cardHeadView == nil) {
        _cardHeadView = [[AXBindCardHeadView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W-30, 42)];
    }
    return _cardHeadView;
}

@end
