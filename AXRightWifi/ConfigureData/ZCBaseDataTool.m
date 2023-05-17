//
//  ZCBaseDataTool.m
//  AXRightWifi
//
//  Created by oneStep on 2023/5/3.
//

#import "ZCBaseDataTool.h"

@implementation ZCBaseDataTool

+(void)logout {
    [ZCUserInfo logout];
}

+ (NSArray *)convertSafeArray:(id)array {
    NSArray *temArr = @[];
    if([array isKindOfClass:[NSNull class]]) {
        
    } else if (array == nil) {
        
    } else if ([array isKindOfClass:[NSArray class]]) {
        temArr = array;
    }
    return temArr;
}

+ (NSDictionary *)convertSafeDict:(id)dict {
    NSDictionary *temDic = @{};
    if([dict isKindOfClass:[NSNull class]]) {
        
    } else if (dict == nil) {
        
    } else if ([dict isKindOfClass:[NSDictionary class]]) {
        temDic = dict;
    }
    return temDic;
}

@end
