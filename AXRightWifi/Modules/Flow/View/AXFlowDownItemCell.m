//
//  AXFlowDownItemCell.m
//  AXRightWifi
//
//  Created by oneStep on 2023/5/16.
//

#import "AXFlowDownItemCell.h"

@interface AXFlowDownItemCell ()

@property (nonatomic,strong) UIImageView *iconIv;

@property (nonatomic,strong) UILabel *nameL;

@property (nonatomic,strong) UILabel *subL;

@property (nonatomic,strong) UIButton *downBtn;

@end

@implementation AXFlowDownItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+ (instancetype)flowDownItemCellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    AXFlowDownItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AXFlowDownItemCell" forIndexPath:indexPath];
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
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(15, 0, SCREEN_W-15, 65)];
    [self.contentView addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(self.contentView).inset(15);
        make.bottom.top.mas_equalTo(self.contentView);
    }];
    self.bgView = bgView;
    bgView.backgroundColor = [ZCConfigColor whiteColor];
        
    self.iconIv = [[UIImageView alloc] init];
    [self.bgView addSubview:self.iconIv];
    [self.iconIv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.bgView.mas_leading).offset(20);
        make.width.height.mas_equalTo(50);
        make.top.mas_equalTo(self.bgView.mas_top);
        make.bottom.mas_equalTo(self.bgView.mas_bottom).inset(15);
    }];
    [self.iconIv setViewCornerRadiu:10];
    self.iconIv.backgroundColor = [ZCConfigColor bgColor];
    
    self.nameL = [self createSimpleLabelWithTitle:@" " font:18 bold:YES color:[ZCConfigColor txtColor]];
    [self.bgView addSubview:self.nameL];
    [self.nameL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.iconIv.mas_top);
        make.leading.mas_equalTo(self.iconIv.mas_trailing).offset(15);
        make.height.mas_equalTo(22);
    }];
    
    self.subL = [self createSimpleLabelWithTitle:@" " font:12 bold:NO color:[ZCConfigColor subTxtColor]];
    [self.bgView addSubview:self.subL];
    [self.subL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.iconIv.mas_trailing).offset(15);
        make.top.mas_equalTo(self.nameL.mas_bottom).offset(6);
        make.height.mas_equalTo(22);
    }];
    
    UIButton *downBtn = [self createSimpleButtonWithTitle:@"立即下载" font:14 color:[ZCConfigColor whiteColor]];
    [self.bgView addSubview:downBtn];
    [downBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.iconIv.mas_centerY);
        make.trailing.mas_equalTo(self.bgView.mas_trailing).inset(15);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(28);
    }];
    [downBtn addTarget:self action:@selector(downOperate) forControlEvents:UIControlEventTouchUpInside];
    [downBtn setBackgroundImage:kIMAGE(@"flow_btn_bg") forState:UIControlStateNormal];
}

- (void)downOperate {
    
}

- (void)setDataDic:(NSDictionary *)dataDic {
    _dataDic = dataDic;
    [self.iconIv sd_setImageWithURL:checkSafeURL(dataDic[@"cover"])];
    self.nameL.text = checkSafeContent(dataDic[@"name"]);
    self.subL.text = checkSafeContent(dataDic[@"description"]);
}

@end
