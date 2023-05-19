//
//  AXArticleCommentFooterView.h
//  AXRightWifi
//
//  Created by oneStep on 2023/5/19.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AXArticleCommentFooterView : UIView

@property (nonatomic,strong) void (^sendCommentBlock)(NSString *content);

@end

NS_ASSUME_NONNULL_END
