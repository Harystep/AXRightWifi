//
//  ZCLoginManage.m
//  AXRightWifi
//
//  Created by oneStep on 2023/5/3.
//

#import "ZCLoginManage.h"

#define kLoginSendCodeURL @"api/v1/site/sms-code"
#define kRegisterAccountOperateURL @"api/v1/site/register"
#define kLoginAccountOperateURL @"api/v1/site/login"

@implementation ZCLoginManage

+ (void)sendPhoneCodeOperate:(NSDictionary *)params completeHandler:(void (^)(id responseObj))completerHandler {
    NSMutableDictionary *dictM = [NSMutableDictionary dictionaryWithDictionary:params];
    [dictM setValue:@"1rcJb8AaXNfpayNVZCVRgOWxFLXFMikr_1682310512" forKey:@"x-api-key"];
    [[ZCNetwork shareInstance] request_postWithApi:kLoginSendCodeURL params:dictM isNeedSVP:YES success:^(id  _Nullable responseObj) {
        completerHandler(responseObj);
    } failed:^(id  _Nullable data) {
        [CFFHud showErrorWithTitle:@"网络连接异常"];
    }];
}

+ (void)registerAccountOperateURL:(NSDictionary *)params completeHandler:(void (^)(id responseObj))completerHandler {
    [[ZCNetwork shareInstance] request_postWithApi:kRegisterAccountOperateURL params:params isNeedSVP:YES success:^(id  _Nullable responseObj) {
        NSDictionary *dataDic = responseObj[@"data"];
        [ZCUserInfo shareInstance].token = checkSafeContent(dataDic[@"access_token"]);
        [ZCUserInfo shareInstance].refresh_token = checkSafeContent(dataDic[@"refresh_token"]);
        [ZCUserInfo shareInstance].phone = checkSafeContent(params[@"mobile"]);
        [ZCUserInfo saveUser:[ZCUserInfo shareInstance]];
        completerHandler(responseObj);        
    } failed:^(id  _Nullable data) {
        [CFFHud showErrorWithTitle:@"网络连接异常"];
    }];
}

+ (void)loginAccountOperateURL:(NSDictionary *)params completeHandler:(void (^)(id responseObj))completerHandler {
    [[ZCNetwork shareInstance] request_postWithApi:kLoginAccountOperateURL params:params isNeedSVP:YES success:^(id  _Nullable responseObj) {
        NSDictionary *dataDic = responseObj[@"data"];
        [ZCUserInfo shareInstance].token = checkSafeContent(dataDic[@"access_token"]);
        [ZCUserInfo shareInstance].refresh_token = checkSafeContent(dataDic[@"refresh_token"]);
        [ZCUserInfo shareInstance].phone = checkSafeContent(params[@"mobile"]);
        [ZCUserInfo saveUser:[ZCUserInfo shareInstance]];
        completerHandler(responseObj);
    } failed:^(id  _Nullable data) {
        [CFFHud showErrorWithTitle:@"网络连接异常"];
    }];
}

@end
