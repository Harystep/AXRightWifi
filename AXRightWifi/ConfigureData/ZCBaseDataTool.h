//
//  ZCBaseDataTool.h
//  AXRightWifi
//
//  Created by oneStep on 2023/5/3.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZCBaseDataTool : NSObject

+ (void)logout;

+ (NSArray *)convertSafeArray:(id)array;

+ (NSDictionary *)convertSafeDict:(id)dict;

@end

NS_ASSUME_NONNULL_END
