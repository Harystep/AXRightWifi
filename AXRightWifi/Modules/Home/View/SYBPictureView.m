//
//  SYBPictureView.m
//  CashierChoke
//
//  Created by oneStep on 2023/4/20.
//  Copyright © 2023 zjs. All rights reserved.
//

#import "SYBPictureView.h"
#import "SYBPictureItemCell.h"

@interface SYBPictureView ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic,strong) UICollectionView *collectView;

@end

@implementation SYBPictureView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createSubviews];
    }
    return self;
}

- (void)createSubviews {
    [self addSubview:self.collectView];
    [self.collectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
}

- (void)setImageArr:(NSArray *)imageArr {
    _imageArr = imageArr;    
    [self.collectView reloadData];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.imageArr.count<9?self.imageArr.count+1:9;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    SYBPictureItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SYBPictureItemCell" forIndexPath:indexPath];
    if (indexPath.row == self.imageArr.count) {
        cell.maxFlag = YES;
        cell.imageData = @"";
        cell.delBtn.hidden = YES;
    } else {
        if(indexPath.row == self.imageArr.count) {
            cell.delBtn.hidden = YES;
        } else {
            cell.delBtn.hidden = NO;
        }
        cell.maxFlag = NO;
        cell.imageData = self.imageArr[indexPath.row];
    }
    return cell;
}

#pragma mark -- UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (UICollectionView *)collectView {
    
    if (!_collectView) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake(100, 100);
        flowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
        _collectView = [[UICollectionView alloc] initWithFrame:CGRectZero
                                             collectionViewLayout:flowLayout];
        _collectView.backgroundColor = UIColor.whiteColor;
        _collectView.bounces = NO;
        // 添加代理
        _collectView.delegate   = self;
        // 添加数据源
        _collectView.dataSource = self;
        // 绑定 cell
        [_collectView registerClass:[SYBPictureItemCell class] forCellWithReuseIdentifier:@"SYBPictureItemCell"];
    }
    return _collectView;
}

@end
