//
//  SYBPictureItemCell.m
//  CashierChoke
//
//  Created by oneStep on 2023/4/20.
//  Copyright © 2023 zjs. All rights reserved.
//

#import "SYBPictureItemCell.h"

@interface SYBPictureItemCell ()

@property (nonatomic,strong) UIButton *addBtn;

@property (nonatomic,strong) UIImageView *iconIv;

@end

@implementation SYBPictureItemCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createSubviews];
        self.backgroundColor = [ZCConfigColor whiteColor];
    }
    return self;
}

- (void)createSubviews {
    
    self.iconIv = [[UIImageView alloc] init];
    [self.contentView addSubview:self.iconIv];
    [self.iconIv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView);
    }];
    self.iconIv.contentMode = UIViewContentModeScaleAspectFill;
    self.iconIv.clipsToBounds = YES;
    
    UIButton *delBtn = [[UIButton alloc] init];
    [self.contentView addSubview:delBtn];
    [delBtn setImage:kIMAGE(@"base_pic_del") forState:UIControlStateNormal];
    delBtn.backgroundColor = rgba(118, 120, 122, 0.6);
    [delBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.top.mas_equalTo(self.contentView);
        make.height.width.mas_equalTo(20);
    }];
    self.delBtn = delBtn;
    [delBtn addTarget:self action:@selector(delImageOperate) forControlEvents:UIControlEventTouchUpInside];
    
    self.addBtn = [[UIButton alloc] init];
    [self.contentView addSubview:self.addBtn];
    [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView);
    }];
    self.addBtn.hidden = YES;
    [self.addBtn setImage:kIMAGE(@"article_post_add") forState:UIControlStateNormal];
    [self.addBtn addTarget:self action:@selector(addImageOperate) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)setImageData:(id)imageData {
    _imageData = imageData;
    if (self.maxFlag) {
        self.addBtn.hidden = NO;
        self.iconIv.hidden = YES;
    } else {
        self.addBtn.hidden = YES;
        self.iconIv.hidden = NO;
        if ([imageData isKindOfClass:[UIImage class]]) {
            self.iconIv.image = imageData;
        } else {
            [self.iconIv sd_setImageWithURL:checkSafeURL(imageData)];
        }
        
    }
}

- (void)setMaxFlag:(NSInteger)maxFlag {
    _maxFlag = maxFlag;
}

- (void)delImageOperate {
    [self routerWithEventName:@"delete" userInfo:@{@"data":self.imageData}];
}


- (void)addImageOperate {
    [self routerWithEventName:@"add" userInfo:@{}];
}

@end
