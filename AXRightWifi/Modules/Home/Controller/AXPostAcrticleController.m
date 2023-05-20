//
//  AXPostAcrticleController.m
//  AXRightWifi
//
//  Created by oneStep on 2023/5/20.
//

#import "AXPostAcrticleController.h"
#import "SYBPictureView.h"
#import "TZImagePickerController.h"
#import "MovEncodeToMpegTool.h"
#import "AXArticleCategoryFilterView.h"

@interface AXPostAcrticleController ()<TZImagePickerControllerDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIView  *contentView;

@property (nonatomic, strong) UIView  *suggestView;
@property (nonatomic, strong) UITextField *suggestTip;
@property (nonatomic, strong) UITextView *textView;

@property (nonatomic, strong) SYBPictureView *photoView;

@property (nonatomic, strong) NSMutableArray *picUrls;

@property (nonatomic,strong) NSMutableArray *coverArr;

//@property (nonatomic,strong) OSSClient *client;

@property (nonatomic, assign) NSInteger downIndex;//下载索引

@property (nonatomic,strong) NSArray *imageArr;

@property (nonatomic,assign) BOOL assignVideoType;//标记是否是视频类型

@property (nonatomic,copy) NSString *videoUrl;

@property (nonatomic,copy) NSString *cate_id;

@property (nonatomic,strong) NSArray *cateArr;

@end

@implementation AXPostAcrticleController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.showNavStatus = YES;
    self.naviView.backgroundColor = [ZCConfigColor whiteColor];
    [self.rightBtn setTitle:@"发布" forState:UIControlStateNormal];
    kweakself(self);
    self.rightItemBlock = ^{
        [weakself submitAction];
    };
    self.view.backgroundColor = UIColor.groupTableViewBackgroundColor;
    self.cateArr = self.params[@"data"];
    
    self.picUrls = [NSMutableArray array];
    self.coverArr = [NSMutableArray array];
    
    [self setupSubviews];
    [self setupConstraints];
    // Do any additional setup after loading the view.
}

- (void)setupSubviews {
    
    self.contentView = [[UIView alloc] init];
    
    self.suggestView = [[UIView alloc] init];
    self.suggestView.backgroundColor = UIColor.whiteColor;
    
    self.suggestTip = [[UITextField alloc] init];
    self.suggestTip.placeholder = @"给文章想个标题吧";
    self.suggestTip.font = FONT_SYSTEM(14);
    
    UIView *sepView = [[UIView alloc] init];
    [self.suggestView addSubview:sepView];
    sepView.backgroundColor = [ZCConfigColor bgColor];
    [sepView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(self.suggestView).inset(15);
        make.height.mas_equalTo(1);
        make.top.mas_equalTo(self.suggestView.mas_top).offset(52);
    }];
    
    self.textView = [[UITextView alloc] init];
    self.textView.font = FONT_SYSTEM(14);
    self.textView.dn_maxLength   = 100;
    self.textView.dn_placeholder = @"编辑文章内容...";
    self.textView.dn_placeholderColor = [ZCConfigColor subTxtColor];
    
    self.photoView = [[SYBPictureView alloc] init];
    self.photoView.imageArr = @[];
        
}

- (void)setupConstraints {
    
    [self.view addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.naviView.mas_bottom);
        make.leading.trailing.mas_equalTo(self.view);
        if (@available(iOS 11.0, *)) {
            make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        } else {
            make.bottom.mas_equalTo(self.view.mas_bottom);
        }
    }];
    
    [self.scrollView addSubview:self.contentView];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.mas_equalTo(self.scrollView);
        make.width.mas_equalTo(self.scrollView.mas_width);
    }];
    
    [self.contentView addSubview:self.suggestView];
    [self.suggestView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.leading.trailing.mas_equalTo(self.contentView).inset(15);
    }];
    
    [self.suggestView setViewCornerRadiu:10];
    
    [self.suggestView addSubview:self.suggestTip];
    [self.suggestTip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(52);
        make.top.mas_equalTo(self.suggestView.mas_top);
        make.trailing.leading.mas_equalTo(self.suggestView).mas_offset(15);
    }];
    
    [self.suggestView addSubview:self.textView];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.suggestTip.mas_bottom).offset(10);
        make.leading.trailing.mas_equalTo(self.suggestView).inset(15);
        make.height.mas_offset(SCREEN_W * 0.3);
    }];
           
    [self.suggestView addSubview:self.photoView];
    [self.photoView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(self.textView.mas_bottom).mas_offset(20);
        make.leading.trailing.bottom.mas_equalTo(self.suggestView).inset(15);
        make.height.mas_offset(SCREEN_W * 0.32);
        
    }];
    self.photoView.imageArr = @[];
        
    UIView *cateBgView = [[UIView alloc] init];
    [self.contentView addSubview:cateBgView];
    [cateBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(self.contentView).inset(15);
        make.top.mas_equalTo(self.suggestView.mas_bottom).offset(15);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).inset(20);
    }];
    cateBgView.backgroundColor = [ZCConfigColor whiteColor];
    [cateBgView setViewCornerRadiu:10];
    
    UILabel *titleL = [self.view createSimpleLabelWithTitle:@"请选择文章分类" font:14 bold:NO color:[ZCConfigColor txtColor]];
    [cateBgView addSubview:titleL];
    [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(cateBgView.mas_leading).offset(15);
        make.height.mas_equalTo(45);
        make.top.mas_equalTo(cateBgView.mas_top);
    }];
    
    AXArticleCategoryFilterView *cateView = [[AXArticleCategoryFilterView alloc] init];
    [cateBgView addSubview:cateView];
    [cateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(cateBgView).inset(15);
        make.bottom.mas_equalTo(cateBgView.mas_bottom).inset(15);
        make.top.mas_equalTo(cateBgView.mas_top).offset(45);
    }];
    cateView.tagsArr = self.cateArr;
    kweakself(self);
    cateView.clickLabelResule = ^(id  _Nonnull value) {
        weakself.cate_id = checkSafeContent(value[@"id"]);
    };
}

#pragma mark -- Methods
- (void)submitAction {
    if(self.suggestTip.text.length == 0) {
        [[CFFAlertView sharedInstance] showTextMsg:@"请填写标题"];
        return;
    }
    if(self.textView.text.length == 0) {
        [[CFFAlertView sharedInstance] showTextMsg:@"请编辑文章内容"];
        return;
    }
    if(!(self.picUrls.count > 0 || self.videoUrl.length > 0)) {
        [[CFFAlertView sharedInstance] showTextMsg:@"请上传照片或者视频"];
        return;
    }
    if(self.cate_id.length == 0) {
        [[CFFAlertView sharedInstance] showTextMsg:@"请选择文章分类"];
        return;
    }
    NSDictionary *parms = @{@"title":self.suggestTip.text,
                            @"content":self.textView.text,
                            @"cate_id":self.cate_id
    };
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:parms];
    
    if(self.videoUrl.length > 0) {
        [dic setValue:self.videoUrl forKey:@"video_url"];
    } else {
        NSString *cover = @"";
        for (NSString *str in self.coverArr) {
            [cover stringByAppendingString:[NSString stringWithFormat:@",%@", str]];
        }
        [dic setValue:cover forKey:@"cover"];
    }
    [ZCHomeManage publishArticleOperateInfo:dic completeHandler:^(id  _Nonnull responseObj) {
        [[CFFAlertView sharedInstance] showTextMsg:checkSafeContent(responseObj[@"message"])];
        dispatch_async(dispatch_get_main_queue(), ^{
            if(self.callBackBlock) {
                self.callBackBlock(@"");
            }
            [self.navigationController popViewControllerAnimated:YES];
        });
    }];
}

- (void)routerWithEventName:(NSString *)eventName userInfo:(NSDictionary *)userInfo {
    if ([eventName isEqualToString:@"add"]) {
        TZImagePickerController *pick = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
        // 是否显示可选原图按钮
        pick.allowPickingOriginalPhoto = NO;        
        if(self.picUrls.count > 0) {
            // 是否允许显示视频
            pick.allowPickingVideo = NO;
        } else {
            pick.allowPickingVideo = YES;
        }
        [self presentViewController:pick animated:YES completion:nil];
    } else if ([eventName isEqualToString:@"delete"]) {
        NSString *path = userInfo[@"data"];
        self.videoUrl = @"";
        [self.coverArr removeObjectAtIndex:[userInfo[@"index"] integerValue]];
        [self.picUrls removeObject:path];
        self.photoView.imageArr = self.picUrls;
    }
}

- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto infos:(NSArray<NSDictionary *> *)infos {
    self.imageArr = photos;
    self.downIndex = 0;
    [self.picUrls addObjectsFromArray:photos];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self updatePictureView];
    });
    self.assignVideoType = NO;
    [self uploadPictureWithIndex:self.downIndex];
    
}

- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingVideo:(UIImage *)coverImage sourceAssets:(id)asset {
    self.assignVideoType = YES;
    NSLog(@"--------- 视频编码 ----------- 开始 ----------");
    [MovEncodeToMpegTool convertMovToMp4FromPHAsset:asset
                      andAVAssetExportPresetQuality:ExportPresetMediumQuality
                  andMovEncodeToMpegToolResultBlock:^(NSURL *mp4FileUrl, NSData *mp4Data, NSError *error) {
        NSLog(@"--------- 视频编码 ----------- 结束 ----------\n{\n  %@,\n   %ld,\n  %@\n}",mp4FileUrl,mp4Data.length,error.localizedDescription);
        if(error == nil) {
            [ZCHomeManage uploadVideoOperateInfo:mp4Data completeHandler:^(id  _Nonnull responseObj) {
                NSLog(@"video:%@", responseObj);
                self.videoUrl = checkSafeDict(responseObj[@"data"])[@"url"];
            }];
        }
    }];
    [self.picUrls addObject:coverImage];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self updatePictureView];
    });
}

- (void)updatePictureView {
    if(self.assignVideoType) {
        self.photoView.assignVideoType = YES;
        self.photoView.imageArr = self.picUrls;
    } else {
        NSInteger imageCount = self.picUrls.count;
        NSInteger count = imageCount == 9 ? 9:(imageCount + 1);
        CGFloat height  = ceil(count / 3.0) * 100 + (ceil(count / 3.0) + 1)*10;
        [self.photoView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_offset(height);
        }];
        self.photoView.assignVideoType = NO;
        self.photoView.imageArr = self.picUrls;
    }
}

- (void)uploadPictureWithIndex:(NSInteger)index {
    UIImage     *image       = self.imageArr[index];
    NSData  *imageData = UIImageJPEGRepresentation(image, 1.f);
    CGFloat scale = imageData.length / (500 * 1000.0);
    if (scale > 1) {
        imageData = UIImageJPEGRepresentation(image, 1.0/scale);
    }
//    [self uploadPictureOperate:imageData];
    
    [ZCHomeManage uploadPictureOperateInfo:imageData completeHandler:^(id  _Nonnull responseObj) {
        NSLog(@"file:%@", responseObj);
        [self.coverArr addObject:checkSafeContent(checkSafeDict(responseObj[@"data"])[@"url"])];
    }];
}

- (UIScrollView *)scrollView {
    
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.backgroundColor = UIColor.groupTableViewBackgroundColor;
        // 隐藏滚动条
        _scrollView.showsVerticalScrollIndicator   = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        
        if (@available(iOS 11.0, *)) {
            _scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets  = NO;
        }
    }
    return _scrollView;
}
@end
