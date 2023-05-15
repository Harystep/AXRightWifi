//
//  AXHomeItemView.m
//  AXRightWifi
//
//  Created by oneStep on 2023/5/15.
//

#import "AXHomeItemView.h"
#import "AXHomeItemMulPictureCell.h"

@interface AXHomeItemView ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic,assign) NSInteger page;

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *dataArr;

@property (nonatomic,copy) NSString *cate_id;

@end

@implementation AXHomeItemView

- (instancetype)initWithFrame:(CGRect)frame {
    if(self == [super initWithFrame:frame]) {
        
        [self createSubviews];
    }
    return self;
}

- (void)createSubviews {
    self.page = 1;
    [self addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.top.leading.trailing.mas_equalTo(self);
    }];
    kweakself(self);
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        weakself.page ++;
        [weakself queryAcrtleListInfo];
    }];
    self.tableView.mj_footer.automaticallyChangeAlpha = YES;
}

- (void)setIndex:(NSInteger)index {

    _index = index;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(queryTypeData:) name:[NSString stringWithFormat:@"kProductCategoryIndex%tu", index] object:nil];
}

- (void)queryTypeData:(NSNotification *)noti {
    NSDictionary *dic = noti.object;
    self.cate_id = checkSafeContent(dic[@"id"]);
}

- (void)queryAcrtleListInfo {
    //?page=1&pageSize=1&cate_id=&keyword=
    NSDictionary *parmas = @{@"cate_id":self.cate_id,
                             @"keyword":@"",
                             @"page":@(self.page),
                             @"pageSize":@"10"
    };
    [ZCHomeManage queryHomeSubCategoryListInfo:parmas completeHandler:^(id  _Nonnull responseObj) {
        NSLog(@"content:%@", responseObj);
        NSArray *dataArr = responseObj[@"data"][@"articles"];
        if(self.page == 1) {
            [self.dataArr removeAllObjects];
        }
        [self.dataArr addObject:dataArr];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.backgroundColor = UIColor.whiteColor;
        [_tableView registerClass:[AXHomeItemMulPictureCell class] forCellReuseIdentifier:@"AXHomeItemMulPictureCell"];
        
    }
    return _tableView;
}

@end
