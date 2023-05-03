
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define kUserInfo  [ZCUserInfo shareInstance]

@interface ZCUserInfo : NSObject<NSCoding>

@property (nonatomic, copy) NSString *token;

@property (nonatomic, copy) NSString *refresh_token;

@property (nonatomic, copy) NSString *phone;

@property (nonatomic,assign) NSInteger status;

+ (instancetype)getuserInfoWithDic:(NSDictionary *)dic;

+ (instancetype)shareInstance;

+ (instancetype)logout;

+ (void)saveUser:(ZCUserInfo *)userInfo;

@end

NS_ASSUME_NONNULL_END
