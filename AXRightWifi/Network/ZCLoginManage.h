//
//  ZCLoginManage.h
//  AXRightWifi
//
//  Created by oneStep on 2023/5/3.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZCLoginManage : NSObject

+ (void)sendPhoneCodeOperate:(NSDictionary *)params completeHandler:(void (^)(id responseObj))completerHandler;

+ (void)registerAccountOperateURL:(NSDictionary *)params completeHandler:(void (^)(id responseObj))completerHandler;

+ (void)loginAccountOperateURL:(NSDictionary *)params completeHandler:(void (^)(id responseObj))completerHandler;

@end

NS_ASSUME_NONNULL_END
