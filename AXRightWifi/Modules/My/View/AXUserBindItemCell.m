//
//  AXUserBindItemCell.m
//  AXRightWifi
//
//  Created by oneStep on 2023/5/17.
//

#import "AXUserBindItemCell.h"

@interface AXUserBindItemCell ()

@property (nonatomic,strong) UIImageView *iconIv;

@property (nonatomic,strong) UILabel *titleL;

@property (nonatomic,strong) UILabel *statusL;

@property (nonatomic,strong) UILabel *usedL;

@property (nonatomic,strong) UILabel *remainL;

@property (nonatomic,strong) UIButton *leftOpBtn;

@property (nonatomic,strong) UIButton *rightOpBtn;

@property (nonatomic,strong) UIView *lineView;

@property (nonatomic,strong) UIView *processView;

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
    
    self.iconIv = [[UIImageView alloc] init];
    [bgView addSubview:self.iconIv];
    [self.iconIv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.mas_equalTo(bgView).offset(10);
        make.width.height.mas_equalTo(22);
    }];
    
    self.titleL = [self createSimpleLabelWithTitle:@"设备号：uf000011111" font:12 bold:NO color:rgba(138, 138, 142, 1)];
    [bgView addSubview:self.titleL];
    [self.titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.iconIv.mas_centerY);
        make.leading.mas_equalTo(self.iconIv.mas_trailing).offset(10);
    }];
    
    self.statusL = [self createSimpleLabelWithTitle:@" " font:10 bold:NO color:rgba(138, 138, 142, 1)];
    [bgView addSubview:self.statusL];
    [self.statusL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.iconIv.mas_centerY);
        make.trailing.mas_equalTo(bgView.mas_trailing).inset(10);
    }];
    
    self.lineView = [[UIView alloc] init];
    [bgView addSubview:self.lineView];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(bgView).inset(10);
        make.top.mas_equalTo(self.iconIv.mas_bottom).offset(10);
        make.height.mas_equalTo(8);
    }];
    [self.lineView setViewCornerRadiu:4];
    self.lineView.backgroundColor = rgba(217, 217, 217, 1);
    
    self.processView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 8)];
    [self.lineView addSubview:self.processView];
    [self.processView setViewCornerRadiu:4];
//    self.processView.backgroundColor = rgba(110, 177, 255, 1);
    
    self.usedL = [self createSimpleLabelWithTitle:@"已用" font:10 bold:NO color:rgba(138, 138, 142, 1)];
    [bgView addSubview:self.usedL];
    [self.usedL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.lineView.mas_bottom).offset(5);
        make.leading.mas_equalTo(bgView.mas_leading).inset(10);
    }];
    
    self.remainL = [self createSimpleLabelWithTitle:@"剩余" font:10 bold:NO color:rgba(138, 138, 142, 1)];
    [bgView addSubview:self.remainL];
    [self.remainL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.usedL.mas_centerY);
        make.trailing.mas_equalTo(bgView.mas_trailing).inset(10);
    }];
    
    self.rightOpBtn = [self createSimpleButtonWithTitle:@"流量充值" font:14 color:[ZCConfigColor whiteColor]];
    [bgView addSubview:self.rightOpBtn];
    [self.rightOpBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(67);
        make.height.mas_equalTo(23);
        make.trailing.mas_equalTo(bgView.mas_trailing).inset(10);
        make.bottom.mas_equalTo(bgView.mas_bottom).inset(10);
    }];
    [self.rightOpBtn setBackgroundImage:kIMAGE(@"my_list_red_bg") forState:UIControlStateNormal];
    [self.rightOpBtn addTarget:self action:@selector(itemOpClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.leftOpBtn = [self createSimpleButtonWithTitle:@"设备管理后台" font:14 color:[ZCConfigColor whiteColor]];
    [bgView addSubview:self.leftOpBtn];
    [self.leftOpBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(94);
        make.height.mas_equalTo(23);
        make.trailing.mas_equalTo(self.rightOpBtn.mas_leading).inset(10);
        make.centerY.mas_equalTo(self.rightOpBtn.mas_centerY);
    }];
    [self.leftOpBtn setBackgroundImage:kIMAGE(@"my_list_blue_bg") forState:UIControlStateNormal];
    [self.leftOpBtn addTarget:self action:@selector(itemOpClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.leftOpBtn.hidden = YES;
}

- (void)setCardDic:(NSDictionary *)cardDic {
    _cardDic = cardDic;
    [self configureDataInfo:cardDic];
}

- (void)setDeviceDic:(NSDictionary *)deviceDic {
    _deviceDic = deviceDic;
    [self.iconIv sd_setImageWithURL:checkSafeURL(deviceDic[@"master_service_logo"])];
    self.titleL.text = [NSString stringWithFormat:@"卡号：%@", checkSafeContent(deviceDic[@"iccid_short"])];
    NSInteger is_realname = [checkSafeContent(deviceDic[@"is_realname"]) integerValue];
    NSString *realStr;
    NSString *activeStr;
    if(is_realname) {
        realStr = @"已实名";
    } else {
        realStr = @"未实名";
    }
    NSInteger is_network_stop = [checkSafeContent(deviceDic[@"is_network_stop"]) integerValue];
    if(is_network_stop) {
        activeStr = @"断网";
    } else {
        activeStr = @"在用";
    }
    self.statusL.text = [NSString stringWithFormat:@"%@/%@", activeStr ,realStr];
    
    NSString *useStr = [NSString stringWithFormat:@"已用 %@M", [NSString reviseString:checkSafeContent(deviceDic[@"traffic_used"])]];
    self.usedL.attributedText = [useStr dn_changeColor:[ZCConfigColor redColor] andRange:NSMakeRange(3, useStr.length-3)];
    
    NSString *traffic_total = [NSString stringWithFormat:@"共 %@M", [NSString reviseString:checkSafeContent(deviceDic[@"traffic_total"])]];
    NSString *traffic_useable = [NSString stringWithFormat:@"%@M", [NSString reviseString:checkSafeContent(deviceDic[@"traffic_useable"])]];
    NSString *retianStr = [NSString stringWithFormat:@"剩余 %@/%@", traffic_useable, traffic_total];
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:retianStr];
    [attributedStr addAttribute:NSForegroundColorAttributeName value:[ZCConfigColor redColor] range:NSMakeRange(3, traffic_useable.length)];
    [attributedStr addAttribute:NSForegroundColorAttributeName value:[ZCConfigColor txtColor] range:NSMakeRange(retianStr.length-traffic_total.length, traffic_total.length)];
    self.remainL.attributedText = attributedStr;
    
    double used = [checkSafeContent(deviceDic[@"traffic_used"]) doubleValue];
    double total = [checkSafeContent(deviceDic[@"traffic_total"]) doubleValue];
    CGFloat width = (SCREEN_W - AUTO_MARGIN(80))*used/total;
    if(used>0) {
        self.processView.frame = CGRectMake(0, 0, width, 8);
        [self configureLeftToRightViewColorGradient:self.processView width:width height:8 one:rgba(110, 177, 255, 1) two:rgba(58, 110, 245, 1) cornerRadius:4];
    }
}

- (void)configureDataInfo:(NSDictionary *)cardDic {
    [self.iconIv sd_setImageWithURL:checkSafeURL(cardDic[@"master_service_logo"])];
    self.titleL.text = [NSString stringWithFormat:@"卡号：%@", checkSafeContent(cardDic[@"iccid_short"])];
    NSInteger is_realname = [checkSafeContent(cardDic[@"data.is_realname"]) integerValue];
    NSString *realStr;
    NSString *activeStr;
    if(is_realname) {
        realStr = @"已实名";
    } else {
        realStr = @"未实名";
    }
    NSInteger network_status = [checkSafeContent(cardDic[@"network_status"]) integerValue];
    //1－待激活,2－已激活,4－停机,6－可测试,7－库存,8－预销户
    switch (network_status) {
        case 1:
            activeStr = @"待激活";
            break;
        case 2:
            activeStr = @"已激活";
            break;
        case 4:
            activeStr = @"停机";
            break;
        case 6:
            activeStr = @"可测试";
            break;
        case 7:
            activeStr = @"库存";
            break;
        case 8:
            activeStr = @"预销户";
            break;
            
        default:
            break;
    }
    self.statusL.text = [NSString stringWithFormat:@"%@/%@", activeStr ,realStr];
    
    NSString *useStr = [NSString stringWithFormat:@"已用 %@M", [NSString reviseString:checkSafeContent(cardDic[@"traffic_used"])]];
    self.usedL.attributedText = [useStr dn_changeColor:[ZCConfigColor redColor] andRange:NSMakeRange(3, useStr.length-3)];
    
    NSString *traffic_total = [NSString stringWithFormat:@"共 %@M", [NSString reviseString:checkSafeContent(cardDic[@"traffic_total"])]];
    NSString *traffic_useable = [NSString stringWithFormat:@"%@M", [NSString reviseString:checkSafeContent(cardDic[@"traffic_useable"])]];
    NSString *retianStr = [NSString stringWithFormat:@"剩余 %@/%@", traffic_useable, traffic_total];
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:retianStr];
    [attributedStr addAttribute:NSForegroundColorAttributeName value:[ZCConfigColor redColor] range:NSMakeRange(3, traffic_useable.length)];
    [attributedStr addAttribute:NSForegroundColorAttributeName value:[ZCConfigColor txtColor] range:NSMakeRange(retianStr.length-traffic_total.length, traffic_total.length)];
    self.remainL.attributedText = attributedStr;
    
    double used = [checkSafeContent(cardDic[@"traffic_used"]) doubleValue];
    double total = [checkSafeContent(cardDic[@"traffic_total"]) doubleValue];
    CGFloat width = (SCREEN_W - AUTO_MARGIN(80))*used/total;
    if(used>0) {
        self.processView.frame = CGRectMake(0, 0, width, 8);
        [self configureLeftToRightViewColorGradient:self.processView width:width height:8 one:rgba(110, 177, 255, 1) two:rgba(58, 110, 245, 1) cornerRadius:4];
    }
}

- (void)itemOpClick:(UIButton *)sender {
    
}

@end
