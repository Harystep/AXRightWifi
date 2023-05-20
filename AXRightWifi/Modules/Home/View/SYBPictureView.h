//
//  SYBPictureView.h
//  CashierChoke
//
//  Created by oneStep on 2023/4/20.
//  Copyright © 2023 zjs. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SYBPictureView : UIView

@property (nonatomic,assign) BOOL assignVideoType;//标记是否是视频类型

@property (nonatomic,strong) UIColor *bgColor;

@property (nonatomic,strong) NSArray *imageArr;

@end

NS_ASSUME_NONNULL_END
