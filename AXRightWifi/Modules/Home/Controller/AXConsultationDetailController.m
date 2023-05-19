//
//  AXConsultationDetailController.m
//  AXRightWifi
//
//  Created by oneStep on 2023/5/19.
//

#import "AXConsultationDetailController.h"
#import <WebKit/WebKit.h>
#import "AXArticleDetailHeadView.h"
#import "AXArticleCommentHeadView.h"
#import "AXArticleCommentItemCell.h"
#import "AXArticleCommentFooterView.h"

@interface AXConsultationDetailController ()<UITableViewDelegate, UITableViewDataSource, WKUIDelegate, WKNavigationDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) WKWebView *webView;

@property (nonatomic, assign) CGFloat webViewHeight;

@property (nonatomic,strong) AXArticleDetailHeadView *topView;

@property (nonatomic,strong) AXArticleCommentHeadView *commentView;

@property (nonatomic,strong) AXArticleCommentFooterView *footerView;

@property (nonatomic,strong) NSArray *dataArr;

@end

static NSString *reuseCommentCell = @"AXArticleCommentItemCell";
static NSString *reuseWebCell = @"WebCell";

@implementation AXConsultationDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.showNavStatus = YES;
    
    self.webViewHeight = 0.0;
    
    [self creatWebView];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:reuseWebCell];
    [self.tableView registerClass:[AXArticleCommentItemCell class] forCellReuseIdentifier:reuseCommentCell];
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view.mas_top).offset(NAV_BAR_HEIGHT);
        make.bottom.mas_equalTo(self.view.mas_bottom).inset(85);
    }];
    self.topView = [[AXArticleDetailHeadView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, 200)];
    
    self.commentView = [[AXArticleCommentHeadView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, 40)];
    
    self.footerView = [[AXArticleCommentFooterView alloc] init];
    [self.view addSubview:self.footerView];
    [self.footerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.leading.trailing.mas_equalTo(self.view);
        make.height.mas_equalTo(85);
    }];
    kweakself(self);
    self.footerView.sendCommentBlock = ^(NSString * _Nonnull content) {
        [weakself commentArticleOperate:content];
    };
    
    [self getArticleDetailInfo];
    
    [self getArticleCommectListInfo];
}

- (void)commentArticleOperate:(NSString *)content {
    NSDictionary *params = @{@"article_id":checkSafeContent(self.params[@"id"]),
                             @"content":content
    };
    [ZCHomeManage commentArticleOperateInfo:params completeHandler:^(id  _Nonnull responseObj) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [[CFFAlertView sharedInstance] showTextMsg:checkSafeContent(responseObj[@"message"])];
        });
        [self getArticleCommectListInfo];
    }];
}

- (void)getArticleCommectListInfo {
    NSDictionary *params = @{@"id":checkSafeContent(self.params[@"id"]),
                             @"pageSize":@"100",
                             @"page":@"1"
    };
    [ZCHomeManage queryArticleCommentListInfo:params completeHandler:^(id  _Nonnull responseObj) {
        NSLog(@"comment%@", responseObj);
        self.dataArr = checkSafeArray(responseObj[@"data"]);
        dispatch_async(dispatch_get_main_queue(), ^{
            NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:1];
            [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
        });
    }];
}

- (void)getArticleDetailInfo {
    [ZCHomeManage queryArticleDetailInfo:@{@"id":checkSafeContent(self.params[@"id"])} completeHandler:^(id  _Nonnull responseObj) {
//        NSLog(@"detail:%@", responseObj);
        NSDictionary *dataDic = responseObj[@"data"];
        NSString *html = [NSString stringWithFormat:@"<html> \n" "<head> \n" "<style type=\"text/css\"> \n" "body {font-size:15px;}\n" "</style> \n" "</head> \n" "<body>" "<script type='text/javascript'>" "window.onload = function(){\n" "var $img = document.getElementsByTagName('img');\n" "for(var p in  $img){\n" " $img[p].style.width = '100%%';\n" "$img[p].style.height ='auto'\n" "}\n" "}" "</script>%@" "</body>" "</html>", dataDic[@"content"]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self compareContentSize:dataDic withFont:20 widthLimited:SCREEN_W-30];
            [self.webView loadHTMLString:html baseURL:nil];
        });
    }];
}

- (void)compareContentSize:(NSDictionary *)dataDic withFont:(CGFloat)font widthLimited:(CGFloat)limitWidth {
    UIFont *fnt = FONT_BOLD(font);
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    //关键代码
    [paragraphStyle setLineSpacing:8];//设置距离
    NSDictionary *parms = @{NSFontAttributeName:fnt,
                            NSParagraphStyleAttributeName:paragraphStyle
    };
    NSString *title = checkSafeContent(dataDic[@"title"]);
    CGSize postJobSize = [title boundingRectWithSize:CGSizeMake(limitWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:parms context:nil].size;
    [self.topView.titleL mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(postJobSize.height);
    }];
    self.topView.authorL.text = checkSafeContent(dataDic[@"author"]);
    self.topView.timeL.text = [NSString timeWithYearMonthDayCountDown:checkSafeContent(dataDic[@"updated_at"])];
//    self.topView.subL.text = title;
    [self.topView.titleL setAttributeStringContent:title space:5 font:FONT_BOLD(font) alignment:NSTextAlignmentLeft];
    CGFloat height = [self.topView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    CGRect frame = self.topView.frame;
    frame.size.height = height;
    self.topView.frame = frame;
//    [self.tableView beginUpdates];
//    self.tableView.tableHeaderView = self.topView;
//    [self.tableView endUpdates];
    [self.tableView reloadData];
}

#pragma mark -------创建webView-------
- (void)creatWebView {
    WKWebViewConfiguration *wkWebConfig = [[WKWebViewConfiguration alloc] init];
    WKUserContentController *wkUController = [[WKUserContentController alloc] init];
    wkWebConfig.userContentController = wkUController;
    //自适应屏幕的宽度js
    NSString *jSString = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
    WKUserScript *wkUserScript = [[WKUserScript alloc] initWithSource:jSString injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
    //添加js调用
    [wkUController addUserScript:wkUserScript];
    
    self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 1) configuration:wkWebConfig];
    self.webView.backgroundColor = [UIColor clearColor];
    self.webView.opaque = NO;
    self.webView.userInteractionEnabled = YES;
    self.webView.scrollView.bounces = NO;
    self.webView.UIDelegate = self;
    self.webView.navigationDelegate = self;
    [self.webView sizeToFit];
    self.webView.scrollView.scrollEnabled = NO;
    [self.webView.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
    
//    NSURL *url = [NSURL URLWithString:@"https://www.baidu.com"];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    [self.webView loadRequest:request];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 1)];
    [self.scrollView addSubview:self.webView];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"contentSize"]) {
        //方法一
        UIScrollView *scrollView = (UIScrollView *)object;
        CGFloat height = scrollView.contentSize.height;
        self.webViewHeight = height;
        self.webView.frame = CGRectMake(0, 0, self.view.frame.size.width, height);
        self.scrollView.frame = CGRectMake(0, 0, self.view.frame.size.width, height);
        self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, height);
        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:0 inSection:0], nil] withRowAnimation:UITableViewRowAnimationNone];
        
        /*
        //方法二
        [_webView evaluateJavaScript:@"document.body.offsetHeight" completionHandler:^(id _Nullable result, NSError * _Nullable error) {
            CGFloat height = [result doubleValue] + 20;
            self.webViewHeight = height;
            self.webView.frame = CGRectMake(0, 0, self.view.frame.size.width, height);
            self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, height);
            [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:3 inSection:0], nil]  withRowAnimation:UITableViewRowAnimationNone];
        }];
         */
    }
}

#pragma mark -------UItableViewDelegate-------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == 0) {
        return 1;
    } else {
        return self.dataArr.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0) {
        return _webViewHeight;
    } else {
        NSDictionary *dataDic = self.dataArr[indexPath.row];
        return [self calculateContentSize:dataDic withFont:14 widthLimited:SCREEN_W-77];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseWebCell];
        [cell.contentView addSubview:self.scrollView];
        return cell;
    } else {
        AXArticleCommentItemCell *cell = [AXArticleCommentItemCell articleCommentItemCellWithTableView:tableView indexPath:indexPath];
        cell.dataDic = self.dataArr[indexPath.row];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
//    if(section == 1) {
//        return 85.;
//    } else {
//    }
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if(section == 0) {
        return self.topView.height;
    } else {
        return 40.0;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if(section == 0) {
        return self.topView;
    } else {
        self.commentView.numL.text = [NSString stringWithFormat:@"%tu", self.dataArr.count];
        return self.commentView;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
//    if(section == 1) {
//        return self.footerView;
//    } else {
//    }
    return [UIView new];
}

- (CGFloat)calculateContentSize:(NSDictionary *)dataDic withFont:(CGFloat)font widthLimited:(CGFloat)limitWidth {
    UIFont *fnt = FONT_SYSTEM(font);
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    //关键代码
    [paragraphStyle setLineSpacing:5];//设置距离
    NSDictionary *parms = @{NSFontAttributeName:fnt,
                            NSParagraphStyleAttributeName:paragraphStyle
    };
    NSString *title = checkSafeContent(dataDic[@"title"]);
    CGSize postJobSize = [title boundingRectWithSize:CGSizeMake(limitWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:parms context:nil].size;
    return postJobSize.height + 20+40;
}

@end
