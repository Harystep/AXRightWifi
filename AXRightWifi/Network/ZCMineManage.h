//
//  ZCMineManage.h
//  AXRightWifi
//
//  Created by oneStep on 2023/5/17.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZCMineManage : NSObject

/// 获取用户信息
/// - Parameters:
///   - params: <#params description#>
///   - completerHandler: <#completerHandler description#>
+ (void)getUserBaseInfoURL:(NSDictionary *)params completeHandler:(void (^)(id responseObj))completerHandler;

/// 获取绑定信息
/// - Parameters:
///   - params: <#params description#>
///   - completerHandler: <#completerHandler description#>
+ (void)getUserBindInfoURL:(NSDictionary *)params completeHandler:(void (^)(id responseObj))completerHandler;

@end

NS_ASSUME_NONNULL_END
