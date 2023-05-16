//
//  AXMyBaseFuncCell.m
//  AXRightWifi
//
//  Created by oneStep on 2023/5/16.
//

#import "AXMyBaseFuncCell.h"

@interface AXMyBaseFuncCell ()

@end

@implementation AXMyBaseFuncCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+ (instancetype)baseFuncCellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    AXMyBaseFuncCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AXMyBaseFuncCell" forIndexPath:indexPath];
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
    NSArray *titleArr = @[@"推广中心",
                          @"我的钱包",
                          @"用户手册",
                          @"退出登录"
    ];
    UIView *bgView = [[UIView alloc] init];
    [self.contentView addSubview:bgView];
    bgView.backgroundColor = [ZCConfigColor whiteColor];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.top.leading.trailing.mas_equalTo(self.contentView).inset(15);
        make.height.mas_equalTo(40*titleArr.count);
    }];
    [bgView setViewCornerRadiu:10];
    
    for (int i = 0; i < titleArr.count; i ++) {
        UIView *item = [[UIView alloc] init];
        [bgView addSubview:item];
        [item mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.mas_equalTo(bgView);
            make.top.mas_equalTo(bgView.mas_top).offset(40*i);
            make.height.mas_equalTo(40);
        }];
        [self setupTargetViewSubviews:item data:titleArr[i]];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
        [item addGestureRecognizer:tap];
    }
}

- (void)tapClick:(UITapGestureRecognizer *)tap {
    UIView *view = tap.view;
    NSString *content;
    for (UIView *subView in view.subviews) {
        if([subView isKindOfClass:[UILabel class]]) {
            UILabel *lb = (UILabel *)subView;
            content = lb.text;
            break;
        }
    }
    
}

- (void)setupTargetViewSubviews:(UIView *)targetView data:(NSString *)title {
    UILabel *lbL = [self createSimpleLabelWithTitle:title font:14 bold:NO color:[ZCConfigColor txtColor]];
    [targetView addSubview:lbL];
    [lbL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(targetView.mas_centerY);
        make.leading.mas_equalTo(targetView.mas_leading).offset(20);
    }];
    
    UIImageView *arrowIv = [[UIImageView alloc] initWithImage:kIMAGE(@"base_arrow")];
    [targetView addSubview:arrowIv];
    [arrowIv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(targetView.mas_centerY);
        make.trailing.mas_equalTo(targetView.mas_trailing).inset(15);
    }];
    
}

@end
