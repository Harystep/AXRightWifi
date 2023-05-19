//
//  AXArticleCommentItemCell.m
//  AXRightWifi
//
//  Created by oneStep on 2023/5/19.
//

#import "AXArticleCommentItemCell.h"

@interface AXArticleCommentItemCell ()

@property (nonatomic,strong) UIImageView *iconIv;

@property (nonatomic,strong) UILabel *nameL;

@property (nonatomic,strong) UILabel *timeL;

@property (nonatomic,strong) UILabel *contentL;

@end

@implementation AXArticleCommentItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+ (instancetype)articleCommentItemCellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    AXArticleCommentItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AXArticleCommentItemCell" forIndexPath:indexPath];
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
    
    self.iconIv = [[UIImageView alloc] init];
    [self.contentView addSubview:self.iconIv];
    [self.iconIv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.mas_equalTo(32);
        make.leading.mas_equalTo(self.contentView.mas_leading).offset(15);
        make.top.mas_equalTo(self.contentView.mas_top);
    }];
    [self.iconIv setViewCornerRadiu:16];
    
    self.nameL = [self createSimpleLabelWithTitle:@" " font:12 bold:YES color:[ZCConfigColor txtColor]];
    [self.contentView addSubview:self.nameL];
    [self.nameL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.iconIv.mas_centerY);
        make.leading.mas_equalTo(self.iconIv.mas_trailing).offset(10);
    }];
    
    self.timeL = [self createSimpleLabelWithTitle:@" " font:12 bold:YES color:[ZCConfigColor subTxtColor]];
    [self.contentView addSubview:self.timeL];
    [self.timeL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.iconIv.mas_centerY);
        make.leading.mas_equalTo(self.nameL.mas_trailing).offset(10);
    }];
    
    self.contentL = [self createSimpleLabelWithTitle:@" " font:14 bold:NO color:[ZCConfigColor txtColor]];
    [self.contentView addSubview:self.contentL];
    [self.contentL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.iconIv.mas_trailing).offset(10);
        make.trailing.mas_equalTo(self.contentView.mas_trailing).inset(20);
        make.top.mas_equalTo(self.contentView.mas_top).offset(40);
//        make.bottom.mas_equalTo(self.contentView.mas_bottom).inset(15);
    }];
    [self.contentL setContentLineFeedStyle];
}

- (void)setDataDic:(NSDictionary *)dataDic {
    _dataDic = dataDic;
    NSDictionary *member = checkSafeDict(dataDic[@"member"]);
    [self.iconIv sd_setImageWithURL:checkSafeURL(member[@"head_portrait"])];
    self.nameL.text = checkSafeContent(member[@"nickname"]);
    self.timeL.text = [NSString timeWithYearMonthDayCountDown:checkSafeContent(dataDic[@"created_at"])];
    self.contentL.text = checkSafeContent(dataDic[@"content"]);
}

@end
