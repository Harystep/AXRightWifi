//
//  AXChangeFlowCardAlertView.h
//  AXRightWifi
//
//  Created by oneStep on 2023/5/19.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AXChangeFlowCardAlertView : UIView

@property (nonatomic, copy) void (^bindDeviceOperate)(void);

@property (nonatomic, copy) void (^knowDeviceInfoOperate)(NSDictionary *dic);

@property (nonatomic,strong) NSDictionary *selectDeviceDic;

@property (nonatomic,strong) NSArray *dataArr;

- (void)showContentView;

@end

NS_ASSUME_NONNULL_END
