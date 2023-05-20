//
//  ZCArticleCategoryFilterController.m
//  AXRightWifi
//
//  Created by oneStep on 2023/5/20.
//

#import "ZCArticleCategoryFilterController.h"
#import "AXArticleCategoryFilterView.h"

@interface ZCArticleCategoryFilterController ()

@property (nonatomic,strong) NSArray *cateArr;

@property (nonatomic,strong) AXArticleCategoryFilterView *filterView;

@end

@implementation ZCArticleCategoryFilterController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.showNavStatus = YES;
    self.titleStr = @"更多分类";
    self.view.backgroundColor = [ZCConfigColor whiteColor];
    self.cateArr = self.params[@"data"];
    
    self.filterView = [[AXArticleCategoryFilterView alloc] init];
    [self.view addSubview:self.filterView];
    [self.filterView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(self.view).inset(15);
        make.top.mas_equalTo(self.naviView.mas_bottom).offset(20);
    }];
    self.filterView.tagsArr = self.cateArr;
    kweakself(self);
    self.filterView.clickLabelIndexResule = ^(NSInteger index) {
        if(weakself.callBackBlock) {
            weakself.callBackBlock([NSString stringWithFormat:@"%tu", index]);
        }
        [weakself.navigationController popViewControllerAnimated:YES];
    };
}

@end
