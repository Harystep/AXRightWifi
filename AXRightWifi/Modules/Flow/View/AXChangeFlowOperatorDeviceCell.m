//
//  AXChangeFlowOperatorDeviceCell.m
//  AXRightWifi
//
//  Created by oneStep on 2023/5/19.
//

#import "AXChangeFlowOperatorDeviceCell.h"

@interface AXChangeFlowOperatorDeviceCell ()

@property (nonatomic,strong) UIButton *titleBtn;

@property (nonatomic,assign) NSInteger index;

@end

@implementation AXChangeFlowOperatorDeviceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+ (instancetype)changeFlowCardCellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    AXChangeFlowOperatorDeviceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AXChangeFlowOperatorDeviceCell" forIndexPath:indexPath];
    cell.index = indexPath.row;
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        [self createSubViews];
    }
    return self;
}

- (void)createSubViews {
    self.titleBtn = [self createSimpleButtonWithTitle:@" " font:14 color:[ZCConfigColor txtColor]];
    [self.contentView addSubview:self.titleBtn];
    [self.titleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
        make.height.mas_equalTo(42);
        make.top.bottom.mas_equalTo(self.contentView);
    }];
    
    self.selectBtn = [[UIButton alloc] init];
    [self.contentView addSubview:self.selectBtn];
    [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.trailing.mas_equalTo(self.contentView.mas_trailing).inset(10);
        make.width.height.mas_equalTo(30);
    }];
    [self.selectBtn setImage:kIMAGE(@"protocol_agree_nor") forState:UIControlStateNormal];
    [self.selectBtn setImage:kIMAGE(@"protocol_agree_sel") forState:UIControlStateSelected];
    
}

- (void)setDataDic:(NSDictionary *)dataDic {
    _dataDic = dataDic;
    [self.titleBtn setTitle:checkSafeContent(dataDic[@"title"]) forState:UIControlStateNormal];
    [self.titleBtn setImage:kIMAGE(dataDic[@"dataDic"]) forState:UIControlStateNormal];
    [self.titleBtn dn_layoutButtonEdgeInset:DNEdgeInsetStyleLeft space:3];
}

@end
