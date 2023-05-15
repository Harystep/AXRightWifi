//
//  AXHomeItemVideoCell.m
//  AXRightWifi
//
//  Created by oneStep on 2023/5/15.
//

#import "AXHomeItemVideoCell.h"
#import "AXHomeItemPictureView.h"

@interface AXHomeItemVideoCell ()

@property (nonatomic,strong) UILabel *titleL;

@property (nonatomic,strong) UIImageView *iconIv;

@property (nonatomic,strong) UILabel *commentL;

@property (nonatomic,strong) UILabel *timeL;

@property (nonatomic,strong) UIImageView *playIv;

@end

@implementation AXHomeItemVideoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+ (instancetype)homeItemCellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    AXHomeItemVideoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AXHomeItemVideoCell" forIndexPath:indexPath];
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
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
    
    self.iconIv = [[UIImageView alloc] init];
    self.iconIv.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:self.iconIv];
    [self.iconIv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(self.contentView).inset(15);
        make.top.mas_equalTo(self.titleL.mas_bottom).offset(10);
        make.height.mas_equalTo(194);
    }];
    self.playIv.backgroundColor = [ZCConfigColor bgColor];
    
    self.playIv = [[UIImageView alloc] init];
    self.playIv.image       = kIMAGE(@"home_video_play");
    [self.iconIv addSubview:self.playIv];
    [self.playIv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.iconIv.mas_centerX);
        make.centerY.mas_equalTo(self.iconIv.mas_centerY);
    }];
    
    self.commentL = [self createSimpleLabelWithTitle:@" " font:12 bold:NO color:[ZCConfigColor subTxtColor]];
    [self.contentView addSubview:self.commentL];
    [self.commentL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.titleL.mas_leading);
        make.top.mas_equalTo(self.iconIv.mas_bottom).offset(6);
        make.height.mas_equalTo(17);
    }];
    
    self.timeL = [self createSimpleLabelWithTitle:@" " font:12 bold:NO color:[ZCConfigColor subTxtColor]];
    [self.contentView addSubview:self.timeL];
    [self.timeL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(self.contentView.mas_trailing).inset(15);
        make.centerY.mas_equalTo(self.commentL.mas_centerY);
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
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        UIImage *image = [self getVideoPreViewImage:[NSURL URLWithString:checkSafeContent(dataDic[@"video_url"])]];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.iconIv.image = image;
        });
    });
    self.commentL.text = [NSString stringWithFormat:@"%@ %@ 评论", checkSafeContent(dataDic[@"author"]), checkSafeContent(dataDic[@"discuss_num"])];
    self.timeL.text = [NSString timeWithYearMonthDayCountDown:checkSafeContent(dataDic[@"created_at"])];
}

// 获取视频第一帧
- (UIImage*)getVideoPreViewImage:(NSURL *)path
{
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:path options:nil];
    AVAssetImageGenerator *assetGen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    assetGen.appliesPreferredTrackTransform = YES;
    CMTime time = CMTimeMakeWithSeconds(5, 6);
    NSError *error = nil;
    CMTime actualTime;
    CGImageRef image = [assetGen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    UIImage *videoImage = [[UIImage alloc] initWithCGImage:image];
    CGImageRelease(image);
    return videoImage;
}

- (UIImage *)imageWithOriginalImage:(UIImage *)originalImage withScaleSize:(CGSize)size {
    UIGraphicsBeginImageContext(size);
    [originalImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
