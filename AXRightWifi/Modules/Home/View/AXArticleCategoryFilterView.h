

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AXArticleCategoryFilterView : UIView

@property (nonatomic, copy) void (^clickLabelResule)(id value);

@property (nonatomic, copy) void (^clickLabelIndexResule)(NSInteger index);

/// 初始化
- (instancetype)init;

/// 行间距
@property (nonatomic) CGFloat spacingRow;
/// 列间距
@property (nonatomic) CGFloat spacingColumn;
/// 内容缩进
@property (nonatomic) UIEdgeInsets contentInset;
//1： 动作组  0 ：搜索
@property (nonatomic,assign) NSInteger type;

@property (nonatomic,strong) NSArray *tagsArr;

@property (nonatomic,assign) NSInteger selectIndex;//标记选中

@end

NS_ASSUME_NONNULL_END
