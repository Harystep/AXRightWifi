//
//  AXFlowRewardItemCell.m
//  AXRightWifi
//
//  Created by oneStep on 2023/5/16.
//

#import "AXFlowRewardItemCell.h"

@interface AXFlowRewardItemCell ()

@property (nonatomic,strong) UIImageView *iconIv;

@property (nonatomic,strong) UILabel *contentL;

@property (nonatomic,strong) UILabel *timeL;

@end

@implementation AXFlowRewardItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+ (instancetype)flowRewardCellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    AXFlowRewardItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AXFlowRewardItemCell" forIndexPath:indexPath];
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
    self.bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W-30, 42)];
    [self.contentView addSubview:self.bgView];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(self.contentView).inset(15);
        make.top.bottom.mas_equalTo(self.contentView);
        make.height.mas_equalTo(42);
    }];
    self.bgView.backgroundColor = [ZCConfigColor whiteColor];
    
    self.iconIv = [[UIImageView alloc] init];
    [self.bgView addSubview:self.iconIv];
    [self.iconIv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.bgView.mas_leading).offset(20);
        make.width.height.mas_equalTo(32);
        make.top.mas_equalTo(self.bgView.mas_top).offset(5);
    }];
    [self.iconIv setViewCornerRadiu:16];
    self.iconIv.backgroundColor = [ZCConfigColor bgColor];
    
    self.contentL = [self createSimpleLabelWithTitle:@"dadsadsdadsasad" font:12 bold:NO color:[ZCConfigColor subTxtColor]];
    [self.bgView addSubview:self.contentL];
    [self.contentL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.iconIv.mas_centerY);
        make.leading.mas_equalTo(self.iconIv.mas_trailing).offset(10);
    }];
    
    self.timeL = [self createSimpleLabelWithTitle:@"10秒前" font:12 bold:NO color:[ZCConfigColor subTxtColor]];
    [self.bgView addSubview:self.timeL];
    [self.timeL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.iconIv.mas_centerY);
        make.trailing.mas_equalTo(self.bgView.mas_trailing).inset(15);
    }];
}

- (void)setDataDic:(NSDictionary *)dataDic {
    _dataDic = dataDic;
    [self.iconIv sd_setImageWithURL:checkSafeURL(dataDic[@"cover"])];
    NSString *name = checkSafeContent(dataDic[@"nickname"]);
    NSString *content = [NSString stringWithFormat:@"用户%@获得了%@M流量", name, checkSafeContent(dataDic[@"num"])];
    self.contentL.attributedText = [content dn_changeColor:rgba(209, 29, 32, 1) andRange:NSMakeRange(2, name.length)];
    self.timeL.text = [NSString timeWithYearMonthDayCountDown:checkSafeContent(dataDic[@"time"])];
    
}

@end
