//
//  AXHomeSearchView.h
//  AXRightWifi
//
//  Created by oneStep on 2023/5/15.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AXHomeSearchView : UIView

@property (nonatomic,strong) UITextField *contentF;

@property (nonatomic,strong) void (^sureSearchBlock)(NSString *content);

@end

NS_ASSUME_NONNULL_END
