//
//  AXHomeItemVideoCell.h
//  AXRightWifi
//
//  Created by oneStep on 2023/5/15.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AXHomeItemVideoCell : UITableViewCell

@property (nonatomic,strong) NSDictionary *dataDic;

+ (instancetype)homeItemCellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
