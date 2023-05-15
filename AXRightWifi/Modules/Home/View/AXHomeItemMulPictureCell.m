//
//  AXHomeItemMulPictureCell.m
//  AXRightWifi
//
//  Created by oneStep on 2023/5/15.
//

#import "AXHomeItemMulPictureCell.h"
#import "AXHomeItemPictureView.h"

@interface AXHomeItemMulPictureCell ()

@property (nonatomic,strong) UILabel *titleL;

@property (nonatomic,strong) AXHomeItemPictureView *pictureView;

@property (nonatomic,strong) UILabel *commentL;

@property (nonatomic,strong) UILabel *timeL;

@end

@implementation AXHomeItemMulPictureCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+ (instancetype)homeItemCellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    AXHomeItemMulPictureCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AXHomeItemMulPictureCell" forIndexPath:indexPath];
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createSubViews];
    }
    return self;
}

- (void)createSubViews {
    
    self.titleL = [self createSimpleLabelWithTitle:@"" font:18 bold:NO color:[ZCConfigColor txtColor]];
    [self.contentView addSubview:self.titleL];
    [self.titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(self.contentView).inset(15);
        make.top.mas_equalTo(12);
    }];
    [self.titleL setContentLineFeedStyle];
    
    self.pictureView = [[AXHomeItemPictureView alloc] init];
    [self.contentView addSubview:self.pictureView];
    [self.pictureView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(self.contentView);
        make.top.mas_equalTo(self.titleL.mas_bottom).offset(10);
        make.height.mas_equalTo(88);
    }];
    
    self.commentL = [self createSimpleLabelWithTitle:@" " font:12 bold:NO color:[ZCConfigColor subTxtColor]];
    [self.contentView addSubview:self.commentL];
    [self.commentL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.titleL.mas_leading);
        make.top.mas_equalTo(self.pictureView.mas_bottom).offset(6);
        make.height.mas_equalTo(17);
    }];
    
    UIView *sepView = [[UIView alloc] init];
    [self.contentView addSubview:sepView];
    sepView.backgroundColor = [ZCConfigColor bgColor];
    [sepView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.contentView.mas_bottom);
        make.leading.trailing.mas_equalTo(self.contentView).inset(15);
        make.height.mas_equalTo(1);
        make.top.mas_equalTo(self.commentL.mas_bottom).offset(10);
    }];
    
}

- (void)setDataDic:(NSDictionary *)dataDic {
    _dataDic = dataDic;
    self.titleL.text = checkSafeContent(dataDic[@"title"]);
    self.pictureView.imgUrls = dataDic[@"cover"];
    
    self.commentL.text = [NSString stringWithFormat:@"%@ %@ 评论", checkSafeContent(dataDic[@"author"]), checkSafeContent(dataDic[@"discuss_num"])];
    self.timeL.text = checkSafeContent(dataDic[@"created_at"]);
}

@end
