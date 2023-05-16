//
//  AXFlowDateView.m
//  AXRightWifi
//
//  Created by oneStep on 2023/5/16.
//

#import "AXFlowDateView.h"

@interface AXFlowDateView ()

@property (nonatomic,strong) NSMutableArray *contentArr;

@property (nonatomic,strong) NSMutableArray *titleArr;

@end

@implementation AXFlowDateView

- (instancetype)initWithFrame:(CGRect)frame {
    if(self == [super initWithFrame:frame]) {
        
        [self createSubviews];
    }
    return self;
}

- (void)createSubviews {
    
    UIView *bgView = [[UIView alloc] init];
    [self addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
        make.height.mas_equalTo(48);
    }];
    self.contentArr = [NSMutableArray array];
    self.titleArr = [NSMutableArray array];
    CGFloat width = (SCREEN_W-30)/3.0;
    for (int i = 0; i < 3; i ++) {
        UIView *itemView = [[UIView alloc] init];
        [bgView addSubview:itemView];
        [itemView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(bgView.mas_leading).offset(width*i);
            make.top.bottom.mas_equalTo(bgView);
            make.width.mas_equalTo(width);
        }];
        UILabel *contentL = [self createSimpleLabelWithTitle:@"0.0" font:20 bold:YES color:[ZCConfigColor txtColor]];
        [itemView addSubview:contentL];
        [contentL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.leading.trailing.mas_equalTo(itemView);
            make.height.mas_equalTo(30);
        }];
        contentL.textAlignment = NSTextAlignmentCenter;
        [self.contentArr addObject:contentL];
        
        UILabel *titleL = [self createSimpleLabelWithTitle:@" " font:12 bold:NO color:[ZCConfigColor subTxtColor]];
        [itemView addSubview:titleL];
        [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.leading.trailing.mas_equalTo(itemView);
            make.height.mas_equalTo(18);
        }];
        titleL.textAlignment = NSTextAlignmentCenter;
        [self.titleArr addObject:titleL];
    }    
}

- (void)setDescArr:(NSArray *)descArr {
    _descArr = descArr;
    for (int i = 0; i < descArr.count; i ++) {
        UILabel *lb = self.titleArr[i];
        lb.text = descArr[i];
    }
}

-(void)setDataDic:(NSDictionary *)dataDic {
    _dataDic = dataDic;
    NSArray *dataArr = @[[self convertDataWithContent:checkSafeContent(dataDic[@"will_get_traffic_today"])],
                         [self convertDataWithContent:checkSafeContent(dataDic[@"have_get_traffic_today"])],
                         [self convertDataWithContent:checkSafeContent(dataDic[@"wait_get_traffic"])]
    ];
    for (int i = 0; i < self.contentArr.count; i ++) {
        UILabel *lb = self.contentArr[i];
        NSString *content = dataArr[i];
        lb.attributedText = [content dn_changeFont:FONT_SYSTEM(12) andRange:NSMakeRange(content.length-4, 4)];
    }
}

- (NSString *)convertDataWithContent:(NSString *)content {
    return [NSString stringWithFormat:@"%.1fMB", [content doubleValue]];
}

@end

