//
//  UIView+ZFCategory.h
//  findproperty
//
//  Created by MacAir on 16/7/23.
//  Copyright © 2016年 Centaline. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIView (ZFCategory)

@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat maxX;
@property (nonatomic, assign) CGFloat maxY;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat originX;

/**
 * 判断一个控件是否真正显示在主窗口
 */
- (BOOL)isShowingOnKeyWindow;

- (UIWindow *)keyWindow;


/**
 *  从 xib 文件中加载文件
 */
+ (instancetype)viewFromXib;

- (UIImage *)snapScreen;
//获取该视图的控制器
- (UIViewController *)viewController;

//删除当前视图内的所有子视图
- (void)removeChildViews;
// 删除最上面的视图
- (void)removeLastChildView;
//删除tableview底部多余横线
- (void)setExtraCellLineHidden:(UITableView *)tableView;

/** 自定义电话弹窗*/
- (void)showZFCustomAlertViewWithTelNumber:(NSString *)telNumber AdviserName:(NSString *)adviserName ButtonArray:(NSArray *)buttonArray;
///** 自定义提示弹框*/
- (void)showZFCustomAlertViewWithTitle:(NSString *)title SubMessage:(NSString *)subMessage;

- (void)showCustomAlertViewWithPhoneNumber:(NSString *)title Subtitle:(NSString *)subtitle ButtonArray:(NSArray *)buttonArray;

/** block 点击事件*/

- (void)showCustomAlertViewWithPhoneNumber:(NSString *)title Subtitle:(NSString *)subtitle ButtonArray:(NSArray *)buttonArray block:(void (^)(void))block;

#pragma mark - 设置部分圆角
/**
 *  设置部分圆角(绝对布局)
 *
 *  @param corners 需要设置为圆角的角 UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight | UIRectCornerAllCorners
 *  @param radii   需要设置的圆角大小 例如 CGSizeMake(20.0f, 20.0f)
 */
- (void)addRoundedCorners:(UIRectCorner)corners
                withRadii:(CGSize)radii;
/**
 *  设置部分圆角(相对布局)
 *
 *  @param corners 需要设置为圆角的角 UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight | UIRectCornerAllCorners
 *  @param radii   需要设置的圆角大小 例如 CGSizeMake(20.0f, 20.0f)
 *  @param rect    需要设置的圆角view的rect
 */
- (void)addRoundedCorners:(UIRectCorner)corners
                withRadii:(CGSize)radii
                 viewRect:(CGRect)rect;


@end
