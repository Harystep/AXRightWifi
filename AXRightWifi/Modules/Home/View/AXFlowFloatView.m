//
//  AXFlowFloatView.m
//  AXRightWifi
//
//  Created by oneStep on 2023/5/21.
//

#import "AXFlowFloatView.h"
#import "FLAnimatedImageView+WebCache.h"

@interface AXFlowFloatView ()

@property (nonatomic,strong) FLAnimatedImageView *loadIv;

@property (nonatomic,strong) FLAnimatedImageView *bindIv;

@property (nonatomic,strong) NSData *loadData;
@property (nonatomic,strong) NSData *bindData;

@end

@implementation AXFlowFloatView

- (instancetype)initWithFrame:(CGRect)frame {
    if(self == [super initWithFrame:frame]) {
        
        [self createSubviews];
    }
    return self;
}

- (void)createSubviews {
    
    self.loadIv = [[FLAnimatedImageView alloc] init];
    [self addSubview:self.loadIv];
    [self.loadIv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    self.loadIv.hidden = YES;
    
    self.bindIv = [[FLAnimatedImageView alloc] init];
    [self addSubview:self.bindIv];
    [self.bindIv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    self.bindIv.hidden = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewClick)];
    [self addGestureRecognizer:tap];
    
}

- (void)viewClick {
    [self routerWithEventName:@"change" userInfo:@{}];
}

- (void)setType:(NSInteger)type {
    _type = type;
    if(type) {
        [self createSportViewSubviews];
    } else {
        [self createNoneViewSubviews];
    }
}

- (void)createNoneViewSubviews {
    self.loadIv.hidden = YES;
    self.bindIv.hidden = NO;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"flow_bind_bg" ofType:@"gif"];
    self.loadData = [NSData dataWithContentsOfFile:path];
    dispatch_async(dispatch_get_main_queue(), ^{
        FLAnimatedImage *image = [FLAnimatedImage animatedImageWithGIFData:self.loadData];
        self.bindIv.animatedImage = image;
    });
}

- (void)createSportViewSubviews {
    self.loadIv.hidden = NO;
    self.bindIv.hidden = YES;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"flow_load_bg" ofType:@"gif"];
    self.bindData = [NSData dataWithContentsOfFile:path];
    dispatch_async(dispatch_get_main_queue(), ^{
        FLAnimatedImage *image = [FLAnimatedImage animatedImageWithGIFData:self.bindData];
        self.loadIv.animatedImage = image;
    });
}

@end
