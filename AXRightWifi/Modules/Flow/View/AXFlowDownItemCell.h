//
//  AXFlowDownItemCell.h
//  AXRightWifi
//
//  Created by oneStep on 2023/5/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AXFlowDownItemCell : UITableViewCell

@property (nonatomic,strong) NSDictionary *dataDic;

+ (instancetype)flowDownItemCellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;

@property (nonatomic,strong) UIView *bgView;

@end

NS_ASSUME_NONNULL_END
