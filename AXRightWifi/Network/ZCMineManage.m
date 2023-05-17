//
//  ZCMineManage.m
//  AXRightWifi
//
//  Created by oneStep on 2023/5/17.
//

#import "ZCMineManage.h"

#define kGetUserBaseInfoURL @"api/tiny-shop/v1/member/member/index"//获取用户基本信息
#define kGetUserBindInfoURL @"api/tiny-shop/v1/simcard/simcard/get-bing-sim-list"//获取绑定卡/设备

@implementation ZCMineManage

+ (void)getUserBaseInfoURL:(NSDictionary *)params completeHandler:(void (^)(id responseObj))completerHandler {
    [[ZCNetwork shareInstance] request_getWithApi:kGetUserBaseInfoURL params:@{} isNeedSVP:NO success:^(id  _Nullable responseObj) {
        completerHandler(responseObj);
    } failed:^(id  _Nullable data) {
        if([data isKindOfClass:[NSDictionary class]]) {
            [CFFHud showErrorWithTitle:checkSafeContent(data[@"message"])];
        } else {
            [CFFHud showErrorWithTitle:@"网络连接异常"];
        }
    }];
}

+ (void)getUserBindInfoURL:(NSDictionary *)params completeHandler:(void (^)(id responseObj))completerHandler {
    [[ZCNetwork shareInstance] request_getWithApi:kGetUserBindInfoURL params:params isNeedSVP:NO success:^(id  _Nullable responseObj) {
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
