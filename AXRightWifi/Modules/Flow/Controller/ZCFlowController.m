//
//  ZCFlowController.m
//  AXRightWifi
//
//  Created by oneStep on 2023/5/3.
//

#import "ZCFlowController.h"
#import "AXFlowCardDataView.h"
#import "AXFlowRewardItemCell.h"
#import "AXFlowDownItemCell.h"
#import "AXFlowDonwHeadView.h"
#import "AXChangeCardView.h"
#import "AXChangeFlowCardAlertView.h"
#import "AXChangeFlowDeviceAlertView.h"

@interface ZCFlowController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic,strong) AXFlowCardDataView *dataView;

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSArray *rewardArr;

@property (nonatomic,strong) NSArray *downArr;

@property (nonatomic,strong) AXFlowDonwHeadView *downHeadView;

@property (nonatomic,strong) NSMutableArray *dataArr;

@property (nonatomic,strong) NSArray *deviceArr;

@end

@implementation ZCFlowController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getUserBindCardYiListInfo];
    [self getUserBindDeviceListInfo];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [ZCConfigColor bgColor];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view.mas_top).offset(56);
    }];
    self.dataView = [[AXFlowCardDataView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, 145)];
    self.tableView.tableHeaderView = self.dataView;
    
    [self getTodayFlowInfo];
    
    [self getRewardListInfo];
    
    [self getDownListInfo];
        
    [self getCurrentOperatorInfo];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    NSInteger count = (self.rewardArr.count>0?1:0)+(self.downArr.count>0?1:0);
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger count;
    if(section == 0) {
        count = self.rewardArr.count;
    } else {
        count = self.downArr.count;
    }
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0) {
        AXFlowRewardItemCell *cell = [AXFlowRewardItemCell flowRewardCellWithTableView:tableView indexPath:indexPath];
        cell.dataDic = self.rewardArr[indexPath.row];
        if(self.rewardArr.count == 1) {
            [cell.bgView setViewCornerRadiu:10];
        } else {
            if(indexPath.row == 0) {
                [cell.bgView setupViewRound:cell.bgView corners:UIRectCornerTopLeft|UIRectCornerTopRight];
            } else if (indexPath.row == self.rewardArr.count-1) {
                [cell.bgView setupViewRound:cell.bgView corners:UIRectCornerBottomLeft|UIRectCornerBottomRight];
            }
        }
        return cell;
    } else {
        AXFlowDownItemCell *cell = [AXFlowDownItemCell flowDownItemCellWithTableView:tableView indexPath:indexPath];
        cell.dataDic = self.downArr[indexPath.row];
        if (indexPath.row == self.downArr.count-1) {
            [cell.bgView setupViewRound:cell.bgView corners:UIRectCornerBottomLeft|UIRectCornerBottomRight];
        }
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if(section == 1) {
        if(self.downArr.count > 0) {
            return 52.+15.;
        } else {
            return .01;
        }
    } else {
        return .01;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if(section == 1) {
        if(self.downArr.count > 0) {
            AXFlowDonwHeadView *view = [[AXFlowDonwHeadView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, 52)];
            [self.view setupViewRound:view.bgView corners:UIRectCornerTopLeft|UIRectCornerTopRight];
            return view;
        } else {
            return [UIView new];
        }
    } else {
        return [UIView new];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return .01;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

- (void)getRewardListInfo {
    [ZCFlowManage getFlowRewardListInfoURL:@{} completeHandler:^(id  _Nonnull responseObj) {
//        NSLog(@"reward:%@", responseObj);
        self.rewardArr = [ZCBaseDataTool convertSafeArray:responseObj[@"data"]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
}

- (void)getDownListInfo {
    [ZCFlowManage getFlowDownListInfoURL:@{} completeHandler:^(id  _Nonnull responseObj) {
//        NSLog(@"down:%@", responseObj);
        self.downArr = [ZCBaseDataTool convertSafeArray:responseObj[@"data"]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
}

- (void)getTodayFlowInfo {
    [ZCFlowManage getTodayFlowInfoURL:@{} completeHandler:^(id  _Nonnull responseObj) {
        NSLog(@"today:%@", responseObj);
        dispatch_async(dispatch_get_main_queue(), ^{
            self.dataView.dataDic = responseObj[@"data"];
        });
    }];
}

/// 获取卡
- (void)getUserBindCardYiListInfo {
    self.dataArr = [NSMutableArray array];
    [ZCMineManage getUserBindInfoURL:@{@"sim_card_type":@"1", @"master_service_type":@"1"} completeHandler:^(id  _Nonnull responseObj) {
//        NSLog(@"yidong:%@", responseObj);
        [self.dataArr addObject:checkSafeArray(responseObj[@"data"])];
        [self getUserBindCardUnionListInfo];
    }];
}
/// 获取联通的卡
- (void)getUserBindCardUnionListInfo {
    [ZCMineManage getUserBindInfoURL:@{@"sim_card_type":@"1", @"master_service_type":@"2"} completeHandler:^(id  _Nonnull responseObj) {
//        NSLog(@"union:%@", responseObj);
        [self.dataArr addObject:checkSafeArray(responseObj[@"data"])];
        [self getUserBindCardDianListInfo];
    }];
}
/// 获取电信的卡
- (void)getUserBindCardDianListInfo {
    [ZCMineManage getUserBindInfoURL:@{@"sim_card_type":@"1", @"master_service_type":@"3"} completeHandler:^(id  _Nonnull responseObj) {
//        NSLog(@"dianxin:%@", responseObj);
        [self.dataArr addObject:checkSafeArray(responseObj[@"data"])];
    }];
}

/// 获取设备
- (void)getUserBindDeviceListInfo {
    [ZCMineManage getUserBindInfoURL:@{@"sim_card_type":@"2"} completeHandler:^(id  _Nonnull responseObj) {
//        NSLog(@"device:%@", responseObj);
        self.deviceArr = checkSafeArray(responseObj[@"data"]);
    }];
}

- (void)getCurrentOperatorInfo {
    [ZCFlowManage getCurrentOperatorFlowInfoURL:@{} completeHandler:^(id  _Nonnull responseObj) {
        NSArray *dataArr = checkSafeArray(responseObj[@"data"]);
//        NSLog(@"%@", dataArr);
        for (NSDictionary *itemDic in dataArr) {
            if([itemDic[@"is_default"] integerValue] == 1) {
                NSDictionary *fisrtDic = itemDic;
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.dataView.operatorDic = checkSafeDict(fisrtDic);
                });
                break;
            }
        }
    }];
}

- (void)routerWithEventName:(NSString *)eventName userInfo:(NSDictionary *)userInfo {
    if([eventName isEqualToString:@"change"]) {//切换卡片
        AXChangeCardView *alertView = [[AXChangeCardView alloc] init];        
        [alertView showContentView];
        kweakself(self);
        alertView.bindDeviceOperate = ^{//切换卡片
            [weakself changeCardView];
        };
        alertView.knowDeviceInfoOperate = ^{//切换设备
            [weakself changeDeviceView];
        };
    }
}

- (void)changeDeviceView {
    AXChangeFlowDeviceAlertView *alertView = [[AXChangeFlowDeviceAlertView alloc] init];
    [alertView showContentView];
    alertView.dataArr = self.deviceArr;
    kweakself(self);
    alertView.knowDeviceInfoOperate = ^(NSDictionary * _Nonnull dic) {
        [weakself changeDeviceOperator:dic];
    };
    alertView.bindDeviceOperate = ^{//添加设备
        [weakself jumpAddCardOp];
    };
}

- (void)changeCardView {
    AXChangeFlowCardAlertView *alertView = [[AXChangeFlowCardAlertView alloc] init];
    [alertView showContentView];    
    alertView.dataArr = self.dataArr;
    kweakself(self);
    alertView.knowDeviceInfoOperate = ^(NSDictionary * _Nonnull dic) {
        [weakself changeDeviceOperator:dic];
    };
    alertView.bindDeviceOperate = ^{//添加流量卡
        [weakself jumpAddCardOp];
    };
}

- (void)jumpAddCardOp {
    [HCRouter router:@"AddCardDevice" params:@{} viewController:self animated:YES block:^(id  _Nonnull value) {
        [self getUserBindCardYiListInfo];
        [self getUserBindDeviceListInfo];
    }];
}

- (void)changeDeviceOperator:(NSDictionary *)dataDic {
    NSString *master_service_type = checkSafeContent(dataDic[@"master_service_type"]);
    NSString *sim_card_type = checkSafeContent(dataDic[@"sim_card_type"]);
    NSString *iccid = checkSafeContent(dataDic[@"iccid"]);
    [ZCMineManage changeDeviceOperatorURL:@{@"master_service_type":master_service_type, @"sim_card_type":sim_card_type, @"iccid":iccid} completeHandler:^(id  _Nonnull responseObj) {
        [[CFFAlertView sharedInstance] showTextMsg:checkSafeContent(responseObj[@"message"])];
        [self getCurrentOperatorInfo];
        [self getTodayFlowInfo];
    }];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.backgroundColor = UIColor.clearColor;
        [_tableView registerClass:[AXFlowRewardItemCell class] forCellReuseIdentifier:@"AXFlowRewardItemCell"];
        [_tableView registerClass:[AXFlowDownItemCell class] forCellReuseIdentifier:@"AXFlowDownItemCell"];
        if (@available(iOS 15.0, *)) {
            _tableView.sectionHeaderTopPadding = 0;
        }
    }
    return _tableView;
}

@end
