//
//  ZCArticleWebCell.h
//  AXRightWifi
//
//  Created by oneStep on 2023/5/19.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZCArticleWebCell : UITableViewCell

@property (nonatomic,strong) NSString *htmlStr;

+ (instancetype)articleWebCellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
