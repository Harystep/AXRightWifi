//
//  ZCMyController.m
//  AXRightWifi
//
//  Created by oneStep on 2023/5/3.
//

#import "ZCMyController.h"
#import "ZCLoginController.h"
#import "AXMyTopView.h"
#import "AXMyBaseFuncCell.h"
#import "AXBindCardHeadView.h"
#import "AXBindCardFooterView.h""

@interface ZCMyController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic,strong) AXMyTopView *topView;

@property (nonatomic,strong) UITableView *tableView;

@end

@implementation ZCMyController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [ZCConfigColor bgColor];
   
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.top.bottom.mas_equalTo(self.view);
    }];
    
    self.topView = [[AXMyTopView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, 315)];
    self.tableView.tableHeaderView = self.topView;        
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == 0) {
        return 0;
    } else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AXMyBaseFuncCell *cell = [AXMyBaseFuncCell baseFuncCellWithTableView:tableView indexPath:indexPath];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if(section == 0) {
        AXBindCardFooterView *footer = [[AXBindCardFooterView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, 54)];
        return footer;
    } else {
        return [UIView new];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if(section == 0) {
        AXBindCardHeadView *headView = [[AXBindCardHeadView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, 42)];
        return headView;
    } else {
        return [UIView new];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if(section == 0) {
        return 42;
    } else {
        return .01;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if(section == 0) {
        return 54;
    } else {
        return .01;
    }
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.backgroundColor = UIColor.clearColor;
        [_tableView registerClass:[AXMyBaseFuncCell class] forCellReuseIdentifier:@"AXMyBaseFuncCell"];
        if (@available(iOS 15.0, *)) {
            _tableView.sectionHeaderTopPadding = 0;
        }
        if (@available(iOS 11.0, *)) {
            self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _tableView;
}

@end
