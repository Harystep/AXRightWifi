//
//  AXHomeItemPictureView.m
//  AXRightWifi
//
//  Created by oneStep on 2023/5/15.
//

#import "AXHomeItemPictureView.h"

@interface AXHomeItemPictureView ()

@property (nonatomic,strong) NSMutableArray *viewArr;

@end

@implementation AXHomeItemPictureView

- (instancetype)initWithFrame:(CGRect)frame {
    if(self == [super initWithFrame:frame]) {
        
        [self createSubviews];
    }
    return self;
}

- (void)createSubviews {
    self.viewArr = [NSMutableArray array];
    CGFloat marginX = 15;
    CGFloat marigin = 3;
    CGFloat width = (SCREEN_W - 30 - 6)/3.0;
    for (int i = 0; i < 3; i ++) {
        UIImageView *item = [[UIImageView alloc] init];
        [self addSubview:item];
        [item mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.mas_equalTo(self);
            make.leading.mas_equalTo(self.mas_leading).offset(15+(width+marigin)*i);
            make.width.mas_equalTo(width);
        }];
        [item setViewCornerRadiu:4];
        [self.viewArr addObject:item];
    }
}

- (void)setImgUrls:(NSArray *)imgUrls {
    _imgUrls = imgUrls;
    NSInteger count = imgUrls.count>3?3:imgUrls.count;
    for (int i = 0; i < count; i ++) {
        UIImageView *iconIv = self.viewArr[i];
        [iconIv sd_setImageWithURL:[NSURL URLWithString:checkSafeContent(imgUrls[i])]];
    }
}

@end
