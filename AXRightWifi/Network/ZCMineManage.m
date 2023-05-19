//
//  ZCMineManage.m
//  AXRightWifi
//
//  Created by oneStep on 2023/5/17.
//

#import "ZCMineManage.h"

#define kGetUserBaseInfoURL @"api/tiny-shop/v1/member/member/index"//获取用户基本信息
#define kGetUserBindInfoURL @"api/tiny-shop/v1/simcard/simcard/get-bing-sim-list"//获取绑定卡/设备
#define kGetUserDeviceFlowInfoURL @"api/tiny-shop/v1/simcard/member-master-service/official-member-traffic"//获取卡/设备总流量
#define kChangeDeviceOperatorURL @"api/tiny-shop/v1/simcard/member-master-service/change-master-service"//切换运营商
#define kBindUserDeviceOperateURL @"api/tiny-shop/v1/simcard/simcard/bing-sim"// 绑定卡/设备

@implementation ZCMineManage

+ (void)getUserBaseInfoURL:(NSDictionary *)params completeHandler:(void (^)(id responseObj))completerHandler {
    [[ZCNetwork shareInstance] request_getWithApi:kGetUserBaseInfoURL params:@{} isNeedSVP:NO success:^(id  _Nullable responseObj) {
        completerHandler(responseObj);
    } failed:^(id  _Nullable data) {
        if([data isKindOfClass:[NSDictionary class]]) {
            [[CFFAlertView sharedInstance] showTextMsg:checkSafeContent(data[@"message"])];
        } else {
            [[CFFAlertView sharedInstance] showTextMsg:@"网络连接异常"];
        }
    }];
}

+ (void)getUserBindInfoURL:(NSDictionary *)params completeHandler:(void (^)(id responseObj))completerHandler {
    [[ZCNetwork shareInstance] request_getWithApi:kGetUserBindInfoURL params:params isNeedSVP:NO success:^(id  _Nullable responseObj) {
        completerHandler(responseObj);
    } failed:^(id  _Nullable data) {
        if([data isKindOfClass:[NSDictionary class]]) {
            [[CFFAlertView sharedInstance] showTextMsg:checkSafeContent(data[@"message"])];
        } else {
            [[CFFAlertView sharedInstance] showTextMsg:@"网络连接异常"];
        }
    }];
}

//
+ (void)getUserDeviceFlowInfoURL:(NSDictionary *)params completeHandler:(void (^)(id responseObj))completerHandler {
    [[ZCNetwork shareInstance] request_getWithApi:kGetUserDeviceFlowInfoURL params:params isNeedSVP:NO success:^(id  _Nullable responseObj) {
        completerHandler(responseObj);
    } failed:^(id  _Nullable data) {
        if([data isKindOfClass:[NSDictionary class]]) {
            [[CFFAlertView sharedInstance] showTextMsg:checkSafeContent(data[@"message"])];
        } else {
            [[CFFAlertView sharedInstance] showTextMsg:@"网络连接异常"];
        }
    }];
}

//
+ (void)bindUserDeviceOperateURL:(NSDictionary *)params completeHandler:(void (^)(id responseObj))completerHandler {
    [[ZCNetwork shareInstance] request_postWithApi:kBindUserDeviceOperateURL params:params isNeedSVP:YES success:^(id  _Nullable responseObj) {
        completerHandler(responseObj);
    } failed:^(id  _Nullable data) {
        if([data isKindOfClass:[NSDictionary class]]) {
            [[CFFAlertView sharedInstance] showTextMsg:checkSafeContent(data[@"message"])];
        } else {
            [[CFFAlertView sharedInstance] showTextMsg:@"网络连接异常"];
        }
    }];
}

//
+ (void)changeDeviceOperatorURL:(NSDictionary *)params completeHandler:(void (^)(id responseObj))completerHandler {
    [[ZCNetwork shareInstance] request_postWithApi:kChangeDeviceOperatorURL params:params isNeedSVP:NO success:^(id  _Nullable responseObj) {
        completerHandler(responseObj);
    } failed:^(id  _Nullable data) {
        if([data isKindOfClass:[NSDictionary class]]) {
            [[CFFAlertView sharedInstance] showTextMsg:checkSafeContent(data[@"message"])];
        } else {
            [[CFFAlertView sharedInstance] showTextMsg:@"网络连接异常"];
        }
    }];
}


@end
