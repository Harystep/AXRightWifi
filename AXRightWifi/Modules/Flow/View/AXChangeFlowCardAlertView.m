//
//  AXChangeFlowCardAlertView.m
//  AXRightWifi
//
//  Created by oneStep on 2023/5/19.
//

#import "AXChangeFlowCardAlertView.h"
#import "AXChangeFlowCardCell.h"

#define kViewHeight 272

@interface AXChangeFlowCardAlertView ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic,strong) UIView *contentView;

@property (nonatomic,strong) UIScrollView *scView;

@property (nonatomic,strong) UIView *detailView;

@property (nonatomic,strong) UILabel *nameL;
@property (nonatomic,strong) UILabel *subL;
@property (nonatomic,strong) UILabel *descL;
@property (nonatomic,strong) UIImageView *iconIv;
@property (nonatomic,strong) UIButton *selectBtn;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray *itemArr;
@property (nonatomic,assign) NSInteger index;

@end

@implementation AXChangeFlowCardAlertView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createSubviews];
    }
    return self;
}

- (void)createSubviews {
    [self setViewColorAlpha:0.4 color:[ZCConfigColor txtColor]];
    self.index = -1;
    
    self.contentView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_H, SCREEN_W, kViewHeight)];
    self.contentView.backgroundColor = [ZCConfigColor whiteColor];
    [self addSubview:self.contentView];
    [self setupViewRound:self.contentView corners:UIRectCornerTopRight | UIRectCornerTopLeft];
    
    UILabel *titleL = [self createSimpleLabelWithTitle:@"请选择卡片切换" font:16 bold:YES color:[ZCConfigColor txtColor]];
    [self.contentView addSubview:titleL];
    [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
        make.top.mas_equalTo(self.contentView.mas_top).offset(20);
        make.height.mas_equalTo(22);
    }];
    
    UIButton *bindBtn = [self createSimpleButtonWithTitle:@"添加" font:14 color:[ZCConfigColor whiteColor]];
    [self.contentView addSubview:bindBtn];
    [bindBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(80);
        make.centerX.mas_equalTo(self.contentView.mas_centerX).offset(-70);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).inset(30);
    }];
    [bindBtn addTarget:self action:@selector(addBtnOperate) forControlEvents:UIControlEventTouchUpInside];
    bindBtn.backgroundColor = [ZCConfigColor txtColor];
    [bindBtn setBackgroundImage:kIMAGE(@"my_list_blue_bg") forState:UIControlStateNormal];
    [bindBtn setViewCornerRadiu:5];
    
    UIButton *knowBtn = [self createSimpleButtonWithTitle:@"确定" font:14 color:[ZCConfigColor whiteColor]];
    [self.contentView addSubview:knowBtn];
    [knowBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView.mas_centerX).offset(70);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(80);
        make.centerY.mas_equalTo(bindBtn.mas_centerY);
    }];
    [knowBtn addTarget:self action:@selector(sureBtnOperate) forControlEvents:UIControlEventTouchUpInside];
    [knowBtn setBackgroundImage:kIMAGE(@"my_list_red_bg") forState:UIControlStateNormal];
    [knowBtn setViewCornerRadiu:5];
    
    [self createOperatorView];
    
}

- (void)changeOperate:(UIButton *)sender {
    if(self.selectBtn == sender) return;
    [self configureOperateorView:sender status:YES];
    [self configureOperateorView:self.selectBtn status:NO];
    self.selectBtn = sender;
    self.itemArr = self.dataArr[sender.tag];
    self.index = -1;
    [self.tableView reloadData];
}

- (void)createOperatorView {
    UIView *itemView = [[UIView alloc] init];
    [self.contentView addSubview:itemView];
    [itemView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(152);
        make.height.mas_equalTo(126);
        make.top.mas_equalTo(self.contentView.mas_top).offset(62);
        make.leading.mas_equalTo(self.contentView.mas_leading);
    }];
    NSArray *dataArr = @[@{@"image":@"flow_yidong_icon", @"title":@"中国移动"},
                         @{@"image":@"flow_union_icon", @"title":@"中国联通"},
                         @{@"image":@"flow_dianxin_icon", @"title":@"中国电信"}
    ];
    for (int i = 0; i < dataArr.count; i ++) {
        NSDictionary *dic = dataArr[i];
        UIButton *btn = [self createSimpleButtonWithTitle:dic[@"title"] font:14 color:[ZCConfigColor point6TxtColor]];
        [itemView addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.mas_equalTo(itemView);
            make.height.mas_equalTo(42);
            make.top.mas_equalTo(42*i);
        }];
        [btn setTitleColor:[ZCConfigColor txtColor] forState:UIControlStateSelected];
        [btn setImage:kIMAGE(dic[@"image"]) forState:UIControlStateNormal];
        [btn dn_layoutButtonEdgeInset:DNEdgeInsetStyleLeft space:3];
        btn.tag = i;
        btn.backgroundColor = [ZCConfigColor bgColor];
        [btn addTarget:self action:@selector(changeOperate:) forControlEvents:UIControlEventTouchUpInside];
        if(i == 0) {
            [self configureOperateorView:btn status:YES];
            self.selectBtn = btn;
        }
    }
    
    [self.contentView addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(itemView.mas_trailing);
        make.trailing.mas_equalTo(self.contentView.mas_trailing);
        make.top.mas_equalTo(self.contentView.mas_top).offset(62);
        make.width.mas_equalTo(152);
        make.height.mas_equalTo(126);
    }];    
}

- (void)setDataArr:(NSArray *)dataArr {
    _dataArr = dataArr;
    self.itemArr = dataArr.firstObject;
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.itemArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AXChangeFlowCardCell *cell = [AXChangeFlowCardCell changeFlowCardCellWithTableView:tableView indexPath:indexPath];
    cell.dataDic = self.itemArr[indexPath.row];
    if(self.index == indexPath.row) {
        cell.selectBtn.selected = YES;
    } else {
        cell.selectBtn.selected = NO;
    }
    return cell;
}
   
- (void)routerWithEventName:(NSString *)eventName userInfo:(NSDictionary *)userInfo {
    if([eventName isEqualToString:@"select"]) {
        NSInteger index = [userInfo[@"index"] integerValue];
        self.index = index;
        self.selectDeviceDic = self.itemArr[index];
        [self.tableView reloadData];
    }
}

- (void)configureOperateorView:(UIButton *)sender status:(BOOL)status {
    sender.selected = status;
    UIColor *bgColor = [ZCConfigColor bgColor];
    if(status) {
        bgColor = UIColor.whiteColor;
    }
    sender.backgroundColor = bgColor;
}

#pragma -- mark 添加
- (void)addBtnOperate {

    [self maskBtnClick];
    if (self.bindDeviceOperate) {
        self.bindDeviceOperate();
    }
}
#pragma -- mark 确定
- (void)sureBtnOperate {
    [self maskBtnClick];
    if (self.knowDeviceInfoOperate) {
        self.knowDeviceInfoOperate(self.selectDeviceDic);
    }
}

- (void)showContentView {
    self.frame = CGRectMake(0, 0, SCREEN_W, SCREEN_H);
    [UIApplication.sharedApplication.keyWindow addSubview:self];
    self.contentView.frame = CGRectMake(0, SCREEN_H - kViewHeight, SCREEN_W, kViewHeight);
}

- (void)maskBtnClick {
    
    self.contentView.frame = CGRectMake(0, SCREEN_H, SCREEN_W, kViewHeight);
    self.contentView.hidden = YES;
    [self.contentView removeFromSuperview];
    [self removeFromSuperview];

}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.backgroundColor = UIColor.clearColor;
        [_tableView registerClass:[AXChangeFlowCardCell class] forCellReuseIdentifier:@"AXChangeFlowCardCell"];
        if (@available(iOS 15.0, *)) {
            _tableView.sectionHeaderTopPadding = 0;
        }
    }
    return _tableView;
}

@end
