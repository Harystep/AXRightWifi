//
//  ZCBaseFlowChangeController.h
//  AXRightWifi
//
//  Created by oneStep on 2023/5/21.
//

#import "ZCBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZCBaseFlowChangeController : ZCBaseViewController

@property (nonatomic,strong) NSMutableArray *dataArr;

@property (nonatomic,strong) NSArray *deviceArr;

- (void)getUserBindCardYiListInfo;

/// 获取联通的卡
- (void)getUserBindCardUnionListInfo;

/// 获取电信的卡
- (void)getUserBindCardDianListInfo;

- (void)getUserBindDeviceListInfo;

@end

NS_ASSUME_NONNULL_END
