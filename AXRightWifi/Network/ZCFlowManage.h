//
//  ZCFlowManage.h
//  AXRightWifi
//
//  Created by oneStep on 2023/5/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZCFlowManage : NSObject

/// 获取今日可领取流量
/// - Parameters:
///   - params: <#params description#>
///   - completerHandler: <#completerHandler description#>
+ (void)getTodayFlowInfoURL:(NSDictionary *)params completeHandler:(void (^)(id responseObj))completerHandler;

/// 获取当前主运营商
/// - Parameters:
///   - params: <#params description#>
///   - completerHandler: <#completerHandler description#>
+ (void)getCurrentOperatorFlowInfoURL:(NSDictionary *)params completeHandler:(void (^)(id responseObj))completerHandler;

/// 获取领奖记录
/// - Parameters:
///   - params: <#params description#>
///   - completerHandler: <#completerHandler description#>
+ (void)getFlowRewardListInfoURL:(NSDictionary *)params completeHandler:(void (^)(id responseObj))completerHandler;

/// 获取下载列表
/// - Parameters:
///   - params: <#params description#>
///   - completerHandler: <#completerHandler description#>
+ (void)getFlowDownListInfoURL:(NSDictionary *)params completeHandler:(void (^)(id responseObj))completerHandler;

@end

NS_ASSUME_NONNULL_END
