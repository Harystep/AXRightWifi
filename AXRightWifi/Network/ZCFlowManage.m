//
//  ZCFlowManage.m
//  AXRightWifi
//
//  Created by oneStep on 2023/5/16.
//

#import "ZCFlowManage.h"

#define kGetTodayFlowInfoURL @"api/tiny-shop/v1/simcard/member-master-service/get-member-activity-traffic"//获取今日可领取流量
#define kGetCurrentOperatorFlowInfoURL @"api/tiny-shop/v1/simcard/member-master-service/index"//获取当前主运营商
#define kGetFlowRewardListInfoURL @"api/tiny-shop/v1/simcard/official-activity/official-activity-log"//领奖记录
#define kGetFlowDownListInfoURL @"api/tiny-shop/v1/simcard/official-activity/index"// 下载列表

@implementation ZCFlowManage

+ (void)getTodayFlowInfoURL:(NSDictionary *)params completeHandler:(void (^)(id responseObj))completerHandler {
    [[ZCNetwork shareInstance] request_getWithApi:kGetTodayFlowInfoURL params:@{} isNeedSVP:YES success:^(id  _Nullable responseObj) {
        completerHandler(responseObj);
    } failed:^(id  _Nullable data) {
        if([data isKindOfClass:[NSDictionary class]]) {
            [[CFFAlertView sharedInstance] showTextMsg:checkSafeContent(data[@"message"])];
        } else {
            [[CFFAlertView sharedInstance] showTextMsg:@"网络连接异常"];
        }
    }];
}

+ (void)getCurrentOperatorFlowInfoURL:(NSDictionary *)params completeHandler:(void (^)(id responseObj))completerHandler {
    [[ZCNetwork shareInstance] request_getWithApi:kGetCurrentOperatorFlowInfoURL params:@{} isNeedSVP:YES success:^(id  _Nullable responseObj) {
        completerHandler(responseObj);
    } failed:^(id  _Nullable data) {
        if([data isKindOfClass:[NSDictionary class]]) {
            [[CFFAlertView sharedInstance] showTextMsg:checkSafeContent(data[@"message"])];
        } else {
            [[CFFAlertView sharedInstance] showTextMsg:@"网络连接异常"];
        }
    }];
}

+ (void)getFlowRewardListInfoURL:(NSDictionary *)params completeHandler:(void (^)(id responseObj))completerHandler {
    [[ZCNetwork shareInstance] request_getWithApi:kGetFlowRewardListInfoURL params:@{} isNeedSVP:YES success:^(id  _Nullable responseObj) {
        completerHandler(responseObj);
    } failed:^(id  _Nullable data) {
        if([data isKindOfClass:[NSDictionary class]]) {
            [[CFFAlertView sharedInstance] showTextMsg:checkSafeContent(data[@"message"])];
        } else {
            [[CFFAlertView sharedInstance] showTextMsg:@"网络连接异常"];
        }
    }];
}

+ (void)getFlowDownListInfoURL:(NSDictionary *)params completeHandler:(void (^)(id responseObj))completerHandler {
    [[ZCNetwork shareInstance] request_getWithApi:kGetFlowDownListInfoURL params:@{} isNeedSVP:YES success:^(id  _Nullable responseObj) {
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
