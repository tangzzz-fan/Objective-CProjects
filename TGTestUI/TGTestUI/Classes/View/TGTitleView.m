//
//  TGTitleView.m
//  TGTestUI
//
//  Created by MacPro on 2017/12/28.
//  Copyright © 2017年 Centaline. All rights reserved.
//

#import "TGTitleView.h"
// UI 风格
#import "TGStyle.h"

@interface TGTitleView()
// 标题数组
@property (strong, nonatomic) NSArray <NSString *> *titles;
@property (strong, nonatomic) TGStyle *tgStyle;

// 存放 label 的数组
@property (strong, nonatomic) NSMutableArray<UILabel *> *titleLabels;
@property (strong, nonatomic) UIScrollView *scrollView;

@property (assign, nonatomic) NSInteger currentIndex;


@end

@implementation TGTitleView
#pragma mark - LifeCycle
- (instancetype)initWithFrame:(CGRect)frame Titles:(NSArray<NSString *> *)titles TGStyle:(TGStyle *)tgStyle {
    if (self = [super initWithFrame:frame]) {
        _titles = titles;
        _tgStyle = tgStyle;
        
        _currentIndex = 0;
        [self setupUI];
    }
    return self;
}

#pragma mark - PrivateFunctions
- (void)setupUI {
    // 1 添加 scrollView
    [self addSubview:self.scrollView];
    // 2 创建 titleLabels
    [self setupTitleLabels];
    // 3 调整 titleLabels frame
    [self setupTitleLabelFrame];
}

// 根据 titles 创建对应的 titleLabel 添加到 scrollView 中
- (void)setupTitleLabels {
    [self.titles enumerateObjectsUsingBlock:^(NSString * _Nonnull title, NSUInteger idx, BOOL * _Nonnull stop) {
        // 创建 label
        UILabel *titleLabel = [[UILabel alloc] init];
        
        // 设置 label 的属性
        titleLabel.text = title;
        titleLabel.tag = idx;
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = [UIFont systemFontOfSize:17.0f];
        
        // 添加到父控件中
        [self.scrollView addSubview:titleLabel];
        
        // 持有
        [self.titleLabels addObject:titleLabel];
        
        // 添加手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(titleLabelClick:)];
        [titleLabel addGestureRecognizer:tap];
        titleLabel.userInteractionEnabled = YES;
        
    }];
}

// 调整 titleLabel 的 frame
- (void)setupTitleLabelFrame {
    
    NSInteger count = self.titleLabels.count;
    
    [self.titleLabels enumerateObjectsUsingBlock:^(UILabel * _Nonnull titleLabel, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat X = 0;
        CGFloat Y = 0;
        CGFloat Width = 0;
        CGFloat Height = self.bounds.size.height;
        
        if (!self.tgStyle.isScrollAble) { // 允许滚动
            Width = self.bounds.size.width / count;
            X = Width * idx;
        } else {
            Width = [self.titles[idx] boundingRectWithSize:CGSizeMake(MAXFLOAT, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.tgStyle.titleFont } context:nil].size.width;
            if (idx == 0) {
                X = self.tgStyle.titleMarign * 0.5;
            } else {
                UILabel *preLabel = self.titleLabels[idx -1];
                X = CGRectGetMaxX(preLabel.frame) + self.tgStyle.titleMarign;
            }
            
        }
        
        titleLabel.frame = CGRectMake(X, Y, Width, Height);
        
    }];
    
    CGFloat maxX = CGRectGetMaxX(self.titleLabels.lastObject.frame);
    
    [self.scrollView setContentSize:CGSizeMake(maxX, 0)];
}

/** 调整 label 的位置 */
- (void)adjustPosition:(UILabel *)label {
    if (!self.tgStyle.isScrollAble) return;
    
    // 计算 scrollView 的偏移量
    CGFloat offsetX = self.tgStyle.isScrollToMiddle ? label.center.x - self.scrollView.center.x : label.frame.origin.x - self.tgStyle.titleMarign * 0.5;
    
    // 处理边界情况
    // 左边的边界
    if (offsetX < 0) {
        offsetX = 0;
    }
    
    // 最大偏移距离
    CGFloat maxOffsetX = self.scrollView.contentSize.width - self.bounds.size.width;
    
    if (offsetX > maxOffsetX) {
        offsetX = maxOffsetX;
    }
    
    [self.scrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
}

#pragma mark - Actions
- (void)titleLabelClick:(UITapGestureRecognizer *)tap {
    // 1 取出点击的 label
    UILabel *newLabel = [[UILabel alloc] init];
    if (![tap.view isKindOfClass:[UILabel class]]) {
        newLabel = nil;
        return;
    }
    
    newLabel = (UILabel *)tap.view;
    
    // 2 改变 label 的样式
    UILabel *oldLabel = self.titleLabels[self.currentIndex];
    oldLabel.textColor = self.tgStyle.normalColor;
    newLabel.textColor = self.tgStyle.selectedColor;
    self.currentIndex = newLabel.tag;
    
    // 3 通知 contentVIew 改变当前位置
    // 使用代理向外传递 currentIndex 改变
    // 4 调整bottomLine 和 缩放比例
    // 5 调整位置
    [self adjustPosition:newLabel];
    // 6 调整 coverView 的位置
}



#pragma mark - Setter && Getter
- (NSMutableArray<UILabel *> *)titleLabels {
    if (!_titleLabels) {
        _titleLabels = [NSMutableArray array];
    }
    return _titleLabels;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.scrollsToTop = NO;
    }
    return _scrollView;
}

@end
