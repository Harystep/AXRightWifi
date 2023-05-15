//
//  ZCHomeManage.m
//  AXRightWifi
//
//  Created by oneStep on 2023/5/3.
//

#import "ZCHomeManage.h"

#define kQueryHomeBannerListInfo @"api/tiny-shop/v1/common/config/app-runing-pic"//轮播
#define kQueryQuestionCategoryListInfo @"api/rf-article/article-cate/index"// 咨询分类
//@"api/rf-article/article-cate/index-block"
#define kQueryHomeCategoryListInfo @"api/rf-article/article-cate/index"//首页分类
#define kQueryHomeSubCategoryListInfo @"api/rf-article/article/list"////获取首页子分类
//@"api/rf-article/article-cate/cate-child?pid="

@implementation ZCHomeManage


+ (void)queryHomeBannerListInfo:(NSDictionary *)params completeHandler:(void (^)(id responseObj))completerHandler {
    [[ZCNetwork shareInstance] request_getWithApi:kQueryHomeBannerListInfo params:@{} isNeedSVP:YES success:^(id  _Nullable responseObj) {
      
        completerHandler(responseObj);
    } failed:^(id  _Nullable data) {
        if([data isKindOfClass:[NSDictionary class]]) {
            [CFFHud showErrorWithTitle:checkSafeContent(data[@"message"])];
        } else {
            [CFFHud showErrorWithTitle:@"网络连接异常"];
        }
    }];
}

+ (void)queryHomeCategoryListInfo:(NSDictionary *)params completeHandler:(void (^)(id responseObj))completerHandler {
    [[ZCNetwork shareInstance] request_getWithApi:kQueryHomeCategoryListInfo params:@{} isNeedSVP:YES success:^(id  _Nullable responseObj) {
      
        completerHandler(responseObj);
    } failed:^(id  _Nullable data) {
        if([data isKindOfClass:[NSDictionary class]]) {
            [CFFHud showErrorWithTitle:checkSafeContent(data[@"message"])];
        } else {
            [CFFHud showErrorWithTitle:@"网络连接异常"];
        }
    }];
}

//kQueryHomeSubCategoryListInfo
+ (void)queryHomeSubCategoryListInfo:(NSDictionary *)params completeHandler:(void (^)(id responseObj))completerHandler {
    [[ZCNetwork shareInstance] request_getWithApi:kQueryHomeSubCategoryListInfo params:params isNeedSVP:YES success:^(id  _Nullable responseObj) {
      
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
