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

#define kQueryArticleDetailInfo @"api/rf-article/article/view?id="//获取资讯详情

#define kQueryArticleCommentListInfo @"api/rf-article/article/evaluate"// 获取资讯评论

#define kCommentArticleOperateInfo @"api/rf-article/article/evaluate-add"//添加评论

#define kUploadPictureOperateInfo @"api/tiny-shop/v1/common/file/images"//上传图片

#define kUploadVideoOperateInfo @"api/tiny-shop/v1/common/file/videos"//上传视频

@implementation ZCHomeManage


+ (void)queryHomeBannerListInfo:(NSDictionary *)params completeHandler:(void (^)(id responseObj))completerHandler {
    [[ZCNetwork shareInstance] request_getWithApi:kQueryHomeBannerListInfo params:@{} isNeedSVP:YES success:^(id  _Nullable responseObj) {
      
        completerHandler(responseObj);
    } failed:^(id  _Nullable data) {
        if([data isKindOfClass:[NSDictionary class]]) {
            [[CFFAlertView sharedInstance] showTextMsg:checkSafeContent(data[@"message"])];
        } else {
            [[CFFAlertView sharedInstance] showTextMsg:@"网络连接异常"];
        }
    }];
}

+ (void)queryHomeCategoryListInfo:(NSDictionary *)params completeHandler:(void (^)(id responseObj))completerHandler {
    [[ZCNetwork shareInstance] request_getWithApi:kQueryHomeCategoryListInfo params:@{} isNeedSVP:YES success:^(id  _Nullable responseObj) {
      
        completerHandler(responseObj);
    } failed:^(id  _Nullable data) {
        if([data isKindOfClass:[NSDictionary class]]) {
            [[CFFAlertView sharedInstance] showTextMsg:checkSafeContent(data[@"message"])];
        } else {
            [[CFFAlertView sharedInstance] showTextMsg:@"网络连接异常"];
        }
    }];
}

//kQueryHomeSubCategoryListInfo
+ (void)queryHomeSubCategoryListInfo:(NSDictionary *)params completeHandler:(void (^)(id responseObj))completerHandler {
    [[ZCNetwork shareInstance] request_getWithApi:kQueryHomeSubCategoryListInfo params:params isNeedSVP:NO success:^(id  _Nullable responseObj) {
      
        completerHandler(responseObj);
    } failed:^(id  _Nullable data) {
        if([data isKindOfClass:[NSDictionary class]]) {
            [[CFFAlertView sharedInstance] showTextMsg:checkSafeContent(data[@"message"])];
        } else {
            [[CFFAlertView sharedInstance] showTextMsg:@"网络连接异常"];
        }
    }];
}

//kQueryArticleDetailInfo
+ (void)queryArticleDetailInfo:(NSDictionary *)params completeHandler:(void (^)(id responseObj))completerHandler {
    NSString *url = [NSString stringWithFormat:@"%@%@", kQueryArticleDetailInfo, params[@"id"]];
    [[ZCNetwork shareInstance] request_getWithApi:url params:@{} isNeedSVP:YES success:^(id  _Nullable responseObj) {
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
+ (void)queryArticleCommentListInfo:(NSDictionary *)params completeHandler:(void (^)(id responseObj))completerHandler {    
    [[ZCNetwork shareInstance] request_getWithApi:kQueryArticleCommentListInfo params:params isNeedSVP:NO success:^(id  _Nullable responseObj) {
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
+ (void)commentArticleOperateInfo:(NSDictionary *)params completeHandler:(void (^)(id responseObj))completerHandler {
    [[ZCNetwork shareInstance] request_postWithApi:kCommentArticleOperateInfo params:params isNeedSVP:YES success:^(id  _Nullable responseObj) {
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
