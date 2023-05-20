//
//  AXHomeItemView.m
//  AXRightWifi
//
//  Created by oneStep on 2023/5/15.
//

#import "AXHomeItemView.h"
#import "AXHomeItemMulPictureCell.h"
#import "AXHomeItemSinglePictureCell.h"
#import "AXHomeItemVideoCell.h"
#import "AXHomeItemCharCell.h"

@interface AXHomeItemView ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic,assign) NSInteger page;

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *dataArr;

@property (nonatomic,copy) NSString *cate_id;

@property (nonatomic,strong) NSString *key;

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
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakself.page = 1;
        [weakself queryAcrtleListInfo];
    }];
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        weakself.page ++;
        [weakself queryAcrtleListInfo];
    }];
    self.tableView.mj_footer.automaticallyChangeAlpha = YES;
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(searchKeyOperate:) name:@"kHoneSearchKey" object:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dataDic = self.dataArr[indexPath.row];
    NSArray *imgUrls = dataDic[@"cover"];
    NSString *video = checkSafeContent(dataDic[@"video_url"]);
    if(video.length > 0) {
        AXHomeItemVideoCell *cell = [AXHomeItemVideoCell homeItemCellWithTableView:tableView indexPath:indexPath];
        cell.dataDic = self.dataArr[indexPath.row];
        return cell;
    } else if (imgUrls.count > 1) {
        AXHomeItemMulPictureCell *cell = [AXHomeItemMulPictureCell homeItemCellWithTableView:tableView indexPath:indexPath];
        cell.dataDic = self.dataArr[indexPath.row];
        return cell;
    } else if (imgUrls.count == 1) {
        AXHomeItemSinglePictureCell *cell = [AXHomeItemSinglePictureCell homeItemCellWithTableView:tableView indexPath:indexPath];
        cell.dataDic = self.dataArr[indexPath.row];
        return cell;
    } else {
        AXHomeItemCharCell *cell = [AXHomeItemCharCell homeItemCellWithTableView:tableView indexPath:indexPath];
        cell.dataDic = self.dataArr[indexPath.row];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dataDic = self.dataArr[indexPath.row];
    NSString *video = checkSafeContent(dataDic[@"video_url"]);
    if(video.length > 0) {
        NSURL *url = [NSURL URLWithString:video];
        AVPlayerItem *playerItem  = [AVPlayerItem playerItemWithURL:url];
        AVPlayer     *player      = [AVPlayer playerWithPlayerItem:playerItem];
        
        AVPlayerViewController *playerVc = [[AVPlayerViewController alloc] init];
        playerVc.player = player;
        playerVc.title  = checkSafeContent(dataDic[@"title"]);
        [self.superViewController presentViewController:playerVc animated:YES completion:nil];
    } else {
        [HCRouter router:@"ConsultationDetail" params:@{@"id":checkSafeContent(dataDic[@"id"])} viewController:self.superViewController animated:YES];
    }
}

- (void)setIndex:(NSInteger)index {

    _index = index;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(queryTypeData:) name:[NSString stringWithFormat:@"kProductCategoryIndex%tu", index] object:nil];
}

- (void)queryTypeData:(NSNotification *)noti {
    NSDictionary *dic = noti.object;
    self.cate_id = checkSafeContent(dic[@"id"]);
    self.key = checkSafeContent(dic[@"content"]);
    self.page = 1;
    [self queryAcrtleListInfo];
}

- (void)queryAcrtleListInfo {
    //?page=1&pageSize=1&cate_id=&keyword=
    NSDictionary *parmas = @{@"cate_id":checkSafeContent(self.cate_id),
                             @"keyword":checkSafeContent(self.key),
                             @"page":@(self.page),
                             @"pageSize":@"10"
    };
    [ZCHomeManage queryHomeSubCategoryListInfo:parmas completeHandler:^(id  _Nonnull responseObj) {
        NSLog(@"content:%@", responseObj);
        NSArray *dataArr = responseObj[@"data"][@"articles"];
        if(self.page == 1) {
            [self.dataArr removeAllObjects];
            [self.tableView.mj_header endRefreshing];
        } else {
            [self.tableView.mj_footer endRefreshing];
        }
        [self.dataArr addObjectsFromArray:dataArr];
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
        [_tableView registerClass:[AXHomeItemCharCell class] forCellReuseIdentifier:@"AXHomeItemCharCell"];
        [_tableView registerClass:[AXHomeItemVideoCell class] forCellReuseIdentifier:@"AXHomeItemVideoCell"];
        [_tableView registerClass:[AXHomeItemSinglePictureCell class] forCellReuseIdentifier:@"AXHomeItemSinglePictureCell"];
    }
    return _tableView;
}

- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

@end
