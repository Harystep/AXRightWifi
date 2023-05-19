//
//  AXChangeFlowCardCell.m
//  AXRightWifi
//
//  Created by oneStep on 2023/5/19.
//

#import "AXChangeFlowCardCell.h"

@interface AXChangeFlowCardCell ()

@property (nonatomic,strong) UILabel *titleL;

@property (nonatomic,assign) NSInteger index;

@end

@implementation AXChangeFlowCardCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+ (instancetype)changeFlowCardCellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    AXChangeFlowCardCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AXChangeFlowCardCell" forIndexPath:indexPath];
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
    self.titleL = [self createSimpleLabelWithTitle:@"" font:14 bold:NO color:[ZCConfigColor txtColor]];
    [self.contentView addSubview:self.titleL];
    [self.titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.contentView.mas_leading);
        make.trailing.mas_equalTo(self.contentView.mas_trailing).inset(60);
        make.height.mas_equalTo(42);
        make.top.bottom.mas_equalTo(self.contentView);
    }];
    self.titleL.textAlignment = NSTextAlignmentCenter;
    
    self.selectBtn = [[UIButton alloc] init];
    [self.contentView addSubview:self.selectBtn];
    [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.trailing.mas_equalTo(self.contentView.mas_trailing).inset(10);
        make.width.height.mas_equalTo(30);
    }];
    [self.selectBtn setImage:kIMAGE(@"protocol_agree_nor") forState:UIControlStateNormal];
    [self.selectBtn setImage:kIMAGE(@"protocol_agree_sel") forState:UIControlStateSelected];
    [self.selectBtn addTarget:self action:@selector(selectItemClick) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)setDataDic:(NSDictionary *)dataDic {
    _dataDic = dataDic;
    self.titleL.text = checkSafeContent(dataDic[@"iccid_short"]);
}

- (void)selectItemClick {
    [self routerWithEventName:@"select" userInfo:@{@"index":[NSString stringWithFormat:@"%tu", self.index]}];
}

@end
