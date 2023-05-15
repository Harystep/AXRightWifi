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
#define kChangeAccountPwdOperateURL @"api/v1/site/up-pwd"//

@implementation ZCLoginManage

+ (void)sendPhoneCodeOperate:(NSDictionary *)params completeHandler:(void (^)(id responseObj))completerHandler {
    NSMutableDictionary *dictM = [NSMutableDictionary dictionaryWithDictionary:params];
    [dictM setValue:@"1rcJb8AaXNfpayNVZCVRgOWxFLXFMikr_1682310512" forKey:@"x-api-key"];
    [[ZCNetwork shareInstance] request_postWithApi:kLoginSendCodeURL params:dictM isNeedSVP:YES success:^(id  _Nullable responseObj) {
        completerHandler(responseObj);
    } failed:^(id  _Nullable data) {
        if([data isKindOfClass:[NSDictionary class]]) {
            [CFFHud showErrorWithTitle:checkSafeContent(data[@"message"])];
        } else {
            [CFFHud showErrorWithTitle:@"网络连接异常"];
        }
    }];
}

+ (void)registerAccountOperateURL:(NSDictionary *)params completeHandler:(void (^)(id responseObj))completerHandler {
    [[ZCNetwork shareInstance] request_postWithApi:kRegisterAccountOperateURL params:params isNeedSVP:YES success:^(id  _Nullable responseObj) {
        NSDictionary *dataDic = responseObj[@"data"];
        NSDictionary *info = @{@"token":checkSafeContent(dataDic[@"access_token"]),
                               @"refresh_token":checkSafeContent(dataDic[@"refresh_token"])
        };
        [ZCUserInfo getuserInfoWithDic:info];
        [ZCUserInfo saveUser:[ZCUserInfo shareInstance]];
        completerHandler(responseObj);        
    } failed:^(id  _Nullable data) {
        if([data isKindOfClass:[NSDictionary class]]) {
            [CFFHud showErrorWithTitle:checkSafeContent(data[@"message"])];
        } else {
            [CFFHud showErrorWithTitle:@"网络连接异常"];
        }
    }];
}

+ (void)loginAccountOperateURL:(NSDictionary *)params completeHandler:(void (^)(id responseObj))completerHandler {
    [[ZCNetwork shareInstance] request_postWithApi:kLoginAccountOperateURL params:params isNeedSVP:YES success:^(id  _Nullable responseObj) {
        NSDictionary *dataDic = responseObj[@"data"];
        NSDictionary *info = @{@"token":checkSafeContent(dataDic[@"access_token"]),
                               @"refresh_token":checkSafeContent(dataDic[@"refresh_token"])
        };
        [ZCUserInfo getuserInfoWithDic:info];
        [ZCUserInfo saveUser:[ZCUserInfo shareInstance]];
        NSLog(@"token:%@", kUserInfo.token);
        completerHandler(responseObj);
    } failed:^(id  _Nullable data) {
        if([data isKindOfClass:[NSDictionary class]]) {
            [CFFHud showErrorWithTitle:checkSafeContent(data[@"message"])];
        } else {
            [CFFHud showErrorWithTitle:@"网络连接异常"];
        }
    }];
}

//kChangeAccountPwdOperateURL
+ (void)changeAccountPwdOperateURL:(NSDictionary *)params completeHandler:(void (^)(id responseObj))completerHandler {
    NSMutableDictionary *dictM = [NSMutableDictionary dictionaryWithDictionary:params];
    [[ZCNetwork shareInstance] request_postWithApi:kChangeAccountPwdOperateURL params:dictM isNeedSVP:YES success:^(id  _Nullable responseObj) {
        NSDictionary *dataDic = responseObj[@"data"];
        NSDictionary *info = @{@"token":checkSafeContent(dataDic[@"access_token"]),
                               @"refresh_token":checkSafeContent(dataDic[@"refresh_token"])
        };
        [ZCUserInfo getuserInfoWithDic:info];
        [ZCUserInfo saveUser:[ZCUserInfo shareInstance]];
        completerHandler(responseObj);
    } failed:^(id  _Nullable data) {
        if([data isKindOfClass:[NSDictionary class]]) {
            [CFFHud showErrorWithTitle:checkSafeContent(data[@"message"])];
        } else {
            [CFFHud showErrorWithTitle:@"网络连接异常"];
        }
    }];
}

@end
