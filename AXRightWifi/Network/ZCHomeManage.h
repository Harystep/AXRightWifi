//
//  ZCHomeManage.h
//  AXRightWifi
//
//  Created by oneStep on 2023/5/3.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZCHomeManage : NSObject

+ (void)queryHomeBannerListInfo:(NSDictionary *)params completeHandler:(void (^)(id responseObj))completerHandler;

/// 首页分类
/// - Parameters:
///   - params: params description
///   - completerHandler: <#completerHandler description#>
+ (void)queryHomeCategoryListInfo:(NSDictionary *)params completeHandler:(void (^)(id responseObj))completerHandler;

/// 获取首页子分类
/// - Parameters:
///   - params: <#params description#>
///   - completerHandler: <#completerHandler description#>
+ (void)queryHomeSubCategoryListInfo:(NSDictionary *)params completeHandler:(void (^)(id responseObj))completerHandler;


/// 获取咨询详情
/// - Parameters:
///   - params: <#params description#>
///   - completerHandler: <#completerHandler description#>
+ (void)queryArticleDetailInfo:(NSDictionary *)params completeHandler:(void (^)(id responseObj))completerHandler;

/// 获取咨询评论
/// - Parameters:
///   - params: <#params description#>
///   - completerHandler: <#completerHandler description#>
+ (void)queryArticleCommentListInfo:(NSDictionary *)params completeHandler:(void (^)(id responseObj))completerHandler;

+ (void)commentArticleOperateInfo:(NSDictionary *)params completeHandler:(void (^)(id responseObj))completerHandler;

@end

NS_ASSUME_NONNULL_END
