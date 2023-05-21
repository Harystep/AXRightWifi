//
//  ZCBaseFlowChangeController.m
//  AXRightWifi
//
//  Created by oneStep on 2023/5/21.
//

#import "ZCBaseFlowChangeController.h"

@interface ZCBaseFlowChangeController ()

@end

@implementation ZCBaseFlowChangeController


- (void)viewDidLoad {
    [super viewDidLoad];
    
}

/// 获取卡
- (void)getUserBindCardYiListInfo {
    self.dataArr = [NSMutableArray array];
    [ZCMineManage getUserBindInfoURL:@{@"sim_card_type":@"1", @"master_service_type":@"1"} completeHandler:^(id  _Nonnull responseObj) {
        [self.dataArr addObject:checkSafeArray(responseObj[@"data"])];
        [self getUserBindCardUnionListInfo];
    }];
}
/// 获取联通的卡
- (void)getUserBindCardUnionListInfo {
    [ZCMineManage getUserBindInfoURL:@{@"sim_card_type":@"1", @"master_service_type":@"2"} completeHandler:^(id  _Nonnull responseObj) {
        [self.dataArr addObject:checkSafeArray(responseObj[@"data"])];
        [self getUserBindCardDianListInfo];
    }];
}
/// 获取电信的卡
- (void)getUserBindCardDianListInfo {
    [ZCMineManage getUserBindInfoURL:@{@"sim_card_type":@"1", @"master_service_type":@"3"} completeHandler:^(id  _Nonnull responseObj) {
        [self.dataArr addObject:checkSafeArray(responseObj[@"data"])];
        [self getUserBindDeviceListInfo];
    }];
}

/// 获取设备
- (void)getUserBindDeviceListInfo {
    [ZCMineManage getUserBindInfoURL:@{@"sim_card_type":@"2"} completeHandler:^(id  _Nonnull responseObj) {
        self.deviceArr = checkSafeArray(responseObj[@"data"]);
        NSInteger count = self.deviceArr.count;
        for (NSArray *item in self.dataArr) {
            count += item.count;
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:@"kFlowCardShowKey" object:[NSString stringWithFormat:@"%tu", count]];
    }];
}


@end
