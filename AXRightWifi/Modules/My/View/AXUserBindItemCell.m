//
//  AXUserBindItemCell.m
//  AXRightWifi
//
//  Created by oneStep on 2023/5/17.
//

#import "AXUserBindItemCell.h"

@interface AXUserBindItemCell ()


@end

@implementation AXUserBindItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+ (instancetype)userBindItemCellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    AXUserBindItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AXUserBindItemCell" forIndexPath:indexPath];
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        [self createSubViews];
    }
    return self;
}

- (void)createSubViews {
    UIView *bgView = [[UIView alloc] init];
    [self.contentView addSubview:bgView];
    bgView.backgroundColor = rgba(238, 238, 238, 1);
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(self.contentView).inset(15);
        make.top.mas_equalTo(self.contentView.mas_top).offset(10);
        make.bottom.mas_equalTo(self.contentView.mas_bottom);
        make.height.mas_equalTo(108);
    }];
    [bgView setViewCornerRadiu:10];
}

@end
