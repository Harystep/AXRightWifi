//
//  SYBPictureItemCell.h
//  CashierChoke
//
//  Created by oneStep on 2023/4/20.
//  Copyright © 2023 zjs. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SYBPictureItemCell : UICollectionViewCell

@property (nonatomic,assign) NSInteger index;
/// 是否满九个
@property (nonatomic, assign) NSInteger maxFlag;

@property (nonatomic,strong) id imageData;

@property (nonatomic,strong) UIButton *delBtn;

@end

NS_ASSUME_NONNULL_END
