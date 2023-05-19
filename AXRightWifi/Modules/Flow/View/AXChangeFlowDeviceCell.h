//
//  AXChangeFlowDeviceCell.h
//  AXRightWifi
//
//  Created by oneStep on 2023/5/19.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AXChangeFlowDeviceCell : UITableViewCell

@property (nonatomic,strong) NSDictionary *dataDic;

@property (nonatomic,strong) UIButton *selectBtn;

+ (instancetype)changeFlowCardCellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
