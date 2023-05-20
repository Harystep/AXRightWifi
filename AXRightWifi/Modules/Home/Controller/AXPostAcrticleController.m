//
//  AXPostAcrticleController.m
//  AXRightWifi
//
//  Created by oneStep on 2023/5/20.
//

#import "AXPostAcrticleController.h"
#import "SYBPictureView.h"
#import "TZImagePickerController.h"

@interface AXPostAcrticleController ()<TZImagePickerControllerDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIView  *contentView;

@property (nonatomic, strong) UIView  *suggestView;
@property (nonatomic, strong) UITextField *suggestTip;
@property (nonatomic, strong) UITextView *textView;

@property (nonatomic, strong) SYBPictureView *photoView;

@property (nonatomic, strong) NSMutableArray *picUrls;

//@property (nonatomic,strong) OSSClient *client;

@property (nonatomic, assign) NSInteger downIndex;//下载索引

@property (nonatomic,strong) NSArray *imageArr;

@end

@implementation AXPostAcrticleController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.showNavStatus = YES;
    self.naviView.backgroundColor = [ZCConfigColor whiteColor];
    [self.rightBtn setTitle:@"发布" forState:UIControlStateNormal];
    self.rightItemBlock = ^{
        
    };
    self.view.backgroundColor = UIColor.groupTableViewBackgroundColor;
    
    self.picUrls = [NSMutableArray array];
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
        
        make.bottom.mas_equalTo(self.contentView.mas_bottom).inset(AUTO_MARGIN(10));
    }];
    self.photoView.imageArr = @[];
        
}

#pragma mark -- Methods
- (void)submitAction {
    
    
}

- (void)routerWithEventName:(NSString *)eventName userInfo:(NSDictionary *)userInfo {
    if ([eventName isEqualToString:@"add"]) {
        TZImagePickerController *pick = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
        [self presentViewController:pick animated:YES completion:nil];
    } else if ([eventName isEqualToString:@"delete"]) {
        NSString *path = userInfo[@"data"];
        [self.picUrls removeObject:path];
        self.photoView.imageArr = self.picUrls;
    }
}

- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto infos:(NSArray<NSDictionary *> *)infos {
    self.imageArr = photos;
    self.downIndex = 0;
    [self.picUrls addObjectsFromArray:photos];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self updatePictureView:photos];
    });
    
    [self uploadPictureWithIndex:self.downIndex];
    
}

- (void)updatePictureView:(NSArray *)photos {
//    NSInteger imageCount = photos.count + self.picUrls.count;
    NSInteger imageCount = self.picUrls.count;
    NSInteger count = imageCount == 9 ? 9:(imageCount + 1);
    CGFloat height  = ceil(count / 3.0) * 100 + (ceil(count / 3.0) + 1)*10;
    [self.photoView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset(height);
    }];
    self.photoView.imageArr = self.picUrls;
}

- (void)uploadPictureWithIndex:(NSInteger)index {
    UIImage     *image       = self.imageArr[index];
    NSData  *imageData = UIImageJPEGRepresentation(image, 1.f);
    CGFloat scale = imageData.length / (500 * 1000.0);
    if (scale > 1) {
        imageData = UIImageJPEGRepresentation(image, 1.0/scale);
    }
//    [self uploadPictureOperate:imageData];
}
//
//- (RACSignal *)getOSSClientInfo
//{
//    // 根据异步请求创建一个新的RACSinal
//    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
//        [SYBOpenManager getOSSPictureOperateInfoCompleteHandler:^(id responseObj) {
//            [subscriber sendNext:responseObj];
//            [subscriber sendCompleted];
//        }];
//
//        return nil;
//    }];
//}
//
//- (void)uploadPictureOperate:(NSData *)imageData {
//
//    RACSignal *signal = [self getOSSClientInfo];
//
//    [signal subscribeNext:^(id  _Nullable x) {
//       dispatch_async(dispatch_get_main_queue(), ^{
//            NSString *endpoint = OSSENDPOINT;
//            NSString *accessKeyid = x[@"accessKeyId"];
//            NSString *secretKeyId = x[@"accessKeySecret"];
//            NSString *securityToken = x[@"securityToken"];
//            id<OSSCredentialProvider> credential = [[OSSStsTokenCredentialProvider alloc] initWithAccessKeyId:accessKeyid secretKeyId:secretKeyId securityToken:securityToken];
//           self.client = [[OSSClient alloc] initWithEndpoint:endpoint credentialProvider:credential];
//           [self uploadPictureOSSOperate:imageData];
//        });
//    }];
//}
//
//- (void)uploadPictureOSSOperate:(NSData *)imageData {
//    OSSPutObjectRequest *put = [OSSPutObjectRequest new];
//    put.bucketName = BUCKET_NAME;
//    NSString *path = [NSString stringWithFormat:@"cashierChoke/app/%@.png", [HRTransferString convertUniCodeStringWithCcontent:[[SYBUserInfo shareUserInfo].loginName stringByAppendingString:[NSDate getCurrentTimeSmpFormDate]]]];
//    path = [path stringByReplacingOccurrencesOfString:@"@" withString:@""];
//    put.objectKey = path;
//    put.uploadingData = imageData; // 直接上传NSData
//    // 配置可选字段。
//    put.uploadProgress = ^(int64_t bytesSent, int64_t totalByteSent, int64_t totalBytesExpectedToSend) {
//        // 指定当前上传长度、当前已经上传总长度、待上传的总长度。
//        NSLog(@"%lld, %lld, %lld", bytesSent, totalByteSent, totalBytesExpectedToSend);
//    };
//    NSDictionary *dict = @{@"callbackBodyType":@"application/x-www-form-urlencoded",
//                           @"callbackUrl":@"https://www.shouyinbei.net/manage/upload/ossCallback",
//                           @"callbackBody":@"filename=${object}&size=${size}&mimeType=${mimeType}&height=${imageInfo.height}&width=${imageInfo.width}"
//    };
//    put.callbackParam = dict;
//    OSSTask *putTask = [self.client putObject:put];
//    [putTask continueWithBlock:^id(OSSTask *task) {
//        if (!task.error) {
//            NSLog(@"objectKey--->%@", put.objectKey);
//            OSSPutObjectResult *result = task.result;
//            NSDictionary *dict = [HRTransferString dictionaryDataWithString:result.serverReturnJsonString];
//            NSLog(@"url-->%@", dict[@"url"]);
//            dispatch_async(dispatch_get_main_queue(), ^{
//                NSString *bankLogo = [NSString stringWithFormat:@"%@", dict[@"url"]];
//                [self.picUrls addObject:bankLogo];
//                self.photoView.imageArr = self.picUrls;
//            });
//        } else {
//            NSLog(@"upload object failed, error: %@" , task.error);
//        }
//        return nil;
//    }];
//}

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
