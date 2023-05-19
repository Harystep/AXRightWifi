//
//  AXChangeFlowDeviceAlertView.h
//  AXRightWifi
//
//  Created by oneStep on 2023/5/19.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AXChangeFlowDeviceAlertView : UIView

@property (nonatomic, copy) void (^bindDeviceOperate)(void);

@property (nonatomic, copy) void (^knowDeviceInfoOperate)(NSDictionary *dic);

@property (nonatomic,strong) NSDictionary *selectDeviceDic;//选中设备信息

@property (nonatomic,strong) NSArray *dataArr;

- (void)showContentView;

@end

NS_ASSUME_NONNULL_END
