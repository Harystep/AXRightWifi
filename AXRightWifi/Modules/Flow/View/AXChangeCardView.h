//
//  AXChangeCardView.h
//  AXRightWifi
//
//  Created by oneStep on 2023/5/17.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AXChangeCardView : UIView

@property (nonatomic, copy) void (^bindDeviceOperate)(void);

@property (nonatomic, copy) void (^knowDeviceInfoOperate)(void);

- (void)showContentView;

@end

NS_ASSUME_NONNULL_END
