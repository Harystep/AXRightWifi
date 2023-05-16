//
//  AXMyBaseFuncCell.h
//  AXRightWifi
//
//  Created by oneStep on 2023/5/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AXMyBaseFuncCell : UITableViewCell

@property (nonatomic,strong) NSDictionary *dataDic;

+ (instancetype)baseFuncCellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
