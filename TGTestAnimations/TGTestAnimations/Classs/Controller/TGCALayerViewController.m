//
//  TGCALayerViewController.m
//  TGTestAnimations
//
//  Created by MacPro on 2018/1/27.
//  Copyright © 2018年 Centaline. All rights reserved.
//

#import "TGCALayerViewController.h"

@interface TGCALayerViewController ()

@end

@implementation TGCALayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self drawLineInRect];
//    [self drawPolygonView];
//    [self drawTiCircleView];
//    [self drawCircleView];
//    [self drawRoundedRect];
//    [self drawSingleRoundedRect];
//    [self drawArcRadius];
//    [self drawArcRadiusAndRect];
//    [self drawQuadCurveLine];
    [self drawQuadCurveLineThree];
    
}

// 绘制三次贝塞尔曲线, 即有两个控制点 曲线是由起点趋向控制点1，之后趋向控制点2，最后到达终点（不会经过控制点）的曲线
- (void)drawQuadCurveLineThree {
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMidX(self.view.frame) - 100, CGRectGetMidY(self.view.frame) - 100, 200, 200)];
    view.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:view];
    
    CGPoint startPoint = CGPointMake(0, 100);
    CGPoint endPoint = CGPointMake(200, 100);
    
    // 绿色二次贝塞尔曲线
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:startPoint];
    
    [path addCurveToPoint:endPoint controlPoint1:CGPointMake(50, 75) controlPoint2:CGPointMake(150, 125)]; // 二次贝塞尔曲线
    CAShapeLayer *pathLayer = [CAShapeLayer layer];
    pathLayer.lineWidth = 2;
    pathLayer.strokeColor = [UIColor greenColor].CGColor;
    pathLayer.fillColor = nil; // 默认为blackColor
    pathLayer.path = path.CGPath;
    [view.layer addSublayer:pathLayer];
}

// 绘制二次贝塞尔曲线, 二次贝塞尔曲线, 一个弯度, 三次贝塞尔曲线, 两个 或者多个弯度
- (void)drawQuadCurveLine {
    // 控制点, 就相当于绘图中的钢笔的位置
    // 同样有起始点, 和终点, 曲线的弯曲方向和控制点在一边
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMidX(self.view.frame) - 100, CGRectGetMidY(self.view.frame) - 100, 200, 200)];
    view.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:view];
    
    // 绿色二次贝塞尔曲线
    UIBezierPath *path1 = [UIBezierPath bezierPath];
    [path1 moveToPoint:CGPointMake(0, 100)];
    CGPoint end1Point = CGPointMake(200, 50);
    [path1 addQuadCurveToPoint:end1Point controlPoint:CGPointMake(100, 200)]; // 二次贝塞尔曲线
    
    CAShapeLayer *path1Layer = [CAShapeLayer layer];
    path1Layer.lineWidth = 2;
    path1Layer.strokeColor = [UIColor greenColor].CGColor;
    path1Layer.fillColor = nil; // 默认为blackColor
    path1Layer.path = path1.CGPath;
    [view.layer addSublayer:path1Layer];
    
    // 红色二次贝塞尔曲线
    UIBezierPath *path2 = [UIBezierPath bezierPath];
    [path2 moveToPoint:CGPointMake(0, 100)];
    CGPoint end2Point = CGPointMake(100, 50);
    [path2 addQuadCurveToPoint:end2Point controlPoint:CGPointMake(25, 25)]; // 二次贝塞尔曲线
    CAShapeLayer *path2Layer = [CAShapeLayer layer];
    path2Layer.lineWidth = 2;
    path2Layer.strokeColor = [UIColor redColor].CGColor;
    path2Layer.fillColor = nil; // 默认为blackColor
    path2Layer.path = path2.CGPath;
    [view.layer addSublayer:path2Layer];
    
}

- (void)drawArcRadiusAndRect {
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMidX(self.view.frame) - 100, CGRectGetMidY(self.view.frame) - 100, 200, 200)];
    view.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:view];
    
    // 线的路径
    CGPoint viewCenter = CGPointMake(view.frame.size.width / 2.0, view.frame.size.height / 2.0); // 画弧的中心点，相对于view
    
    // 定义折线的路径
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    [path moveToPoint:CGPointMake(50, 50)];
    [path addLineToPoint:CGPointMake(100, 100)];
    
    // 将弧线和折线连接起来, 其实是将这个弧线路径添加在 path 上
    [path addArcWithCenter:viewCenter radius:50 startAngle:0 endAngle:M_PI clockwise:YES]; // 添加一条弧线
    
    // 闭合
    [path closePath];
    
    CAShapeLayer *pathLayer = [CAShapeLayer layer];
    pathLayer.lineWidth = 2;
    pathLayer.strokeColor = [UIColor greenColor].CGColor;
    pathLayer.fillColor = nil; // 默认为blackColor, 如果不指定, 则为默认颜色
    pathLayer.path = path.CGPath;
    [view.layer addSublayer:pathLayer];
}

- (void)drawArcRadius {
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMidX(self.view.frame) - 100, CGRectGetMidY(self.view.frame) - 100, 200, 200)];
    view.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:view];
    
    // 线的路径
    // 定义中心点
    CGPoint viewCenter = CGPointMake(view.frame.size.width / 2.0, view.frame.size.height / 2.0); // 画弧的中心点，相对于view
    
    // 根据中心点创建 path, 指定半径, 起始弧度, 顺时针还是逆时针
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:viewCenter radius:50.0 startAngle:0 endAngle:M_PI_2 clockwise:YES];
    
    CAShapeLayer *pathLayer = [CAShapeLayer layer];
    pathLayer.lineWidth = 2;
    pathLayer.strokeColor = [UIColor greenColor].CGColor;
    pathLayer.fillColor = nil; // 默认为blackColor
    pathLayer.path = path.CGPath;
    [view.layer addSublayer:pathLayer];
    
}

- (void)drawSingleRoundedRect {
    // 需要圆视图
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMidX(self.view.frame) - 100, CGRectGetMidY(self.view.frame) - 100, 200, 200)];
    view.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:view];
    
    // 线的路径
    // 绘制圆角, 指定对应的角的位置
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(50, 0)];
    
    CAShapeLayer *pathLayer = [CAShapeLayer layer];
    pathLayer.lineWidth = 2;
    pathLayer.strokeColor = [UIColor greenColor].CGColor;
    pathLayer.path = path.CGPath;
    view.layer.mask = pathLayer;
//    pathLayer.fillColor = nil; // 默认为blackColor
//    [view.layer addSublayer:pathLayer];
}

// 可以通过设置绘制的图层, 为创建的 view 的 mask 图层
- (void)drawRoundedRect {
    // 需要画圆角矩形
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMidX(self.view.frame) - 100, CGRectGetMidY(self.view.frame) - 100, 200, 200)];
    view.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:view];
    
    // 线的路径
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:view.bounds cornerRadius:50];
    CAShapeLayer *pathLayer = [CAShapeLayer layer];
    pathLayer.lineWidth = 2;
    pathLayer.strokeColor = [UIColor greenColor].CGColor;
    pathLayer.path = path.CGPath;
//    pathLayer.fillColor = [UIColor lightGrayColor].CGColor; // 默认为blackColor
//    [view.layer addSublayer:pathLayer];
    view.layer.mask = pathLayer; // layer 的 mask属性，添加蒙版
    // mask 就是一个图层, 这个图层 定义了可以看到的内容. 就相当于 scrollView的 frame
}

- (void)drawCircleView {
    // 绘制一个正方形
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMidX(self.view.frame) - 100, CGRectGetMidY(self.view.frame) - 100, 200, 200)];
    view.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:view];
    
    // 线的路径
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:view.bounds];
    
    CAShapeLayer *pathLayer = [CAShapeLayer layer];
    pathLayer.lineWidth = 2;
    pathLayer.strokeColor = [UIColor greenColor].CGColor;
    pathLayer.path = path.CGPath;
    // [view.layer addSublayer:pathLayer];
    // pathLayer.fillColor = nil; // 默认为blackColor
    view.layer.mask = pathLayer; // layer 的 mask属性，添加蒙版
}

- (void)drawTiCircleView {
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMidX(self.view.frame) - 130, CGRectGetMidY(self.view.frame) - 100, 260, 200)];
    view.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:view];
    
    // 线的路径
    // 这里获取矩形的内切 path
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:view.bounds];
    
    CAShapeLayer *pathLayer = [CAShapeLayer layer];
    pathLayer.lineWidth = 2;
    pathLayer.strokeColor = [UIColor greenColor].CGColor;
    pathLayer.path = path.CGPath;
    pathLayer.fillColor = nil;
//    pathLayer.fillColor = [UIColor purpleColor].CGColor; // 默认为blackColor
    [view.layer addSublayer:pathLayer];
    
}

- (void)drawPolygonView {
    // closePath 连接曲线的起点和终点形成闭合曲线
    UIView * polygonView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMidX(self.view.frame) - 100, CGRectGetMidY(self.view.frame) - 100, 200, 200)];
    polygonView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:polygonView];
    
    // 线的路径
    UIBezierPath *polygonPath = [UIBezierPath bezierPath];
    // 起点
    [polygonPath moveToPoint:CGPointMake(20, 40)];
    // 其他点
    [polygonPath addLineToPoint:CGPointMake(160, 160)];
    [polygonPath addLineToPoint:CGPointMake(140, 50)];
    
    [polygonPath closePath]; // 添加一个结尾点和起点相同
    
    // 创建一个图层, 设置这个图层的 path,
    CAShapeLayer *polygonLayer = [CAShapeLayer layer];
    polygonLayer.lineWidth = 2;
    polygonLayer.strokeColor = [UIColor greenColor].CGColor;
    polygonLayer.path = polygonPath.CGPath;
    polygonLayer.fillColor = nil; // 默认为blackColor
    [polygonView.layer addSublayer:polygonLayer];
}

// 在矩形中绘制一条折线
- (void)drawLineInRect {
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMidX(self.view.frame) - 100, CGRectGetMidY(self.view.frame)- 100, 200, 200)];
    lineView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:lineView];
    
    /* 先指定点的位置,
     * 设置 layer, path 然后对应填充
     *
     */
    
    // 定义线的路径
    UIBezierPath *linePath = [UIBezierPath bezierPath];
    // 起点
    [linePath moveToPoint:CGPointMake(20, 30)];
    
    // 添加路径起点外的其他点
    [linePath addLineToPoint:CGPointMake(150, 120)];
    [linePath addLineToPoint:CGPointMake(180, 50)];
    
    // 设置图层
    CAShapeLayer *lineLayer = [CAShapeLayer layer];
    
    lineLayer.lineWidth = 2;
    // 画笔颜色
    lineLayer.strokeColor = [UIColor greenColor].CGColor;
    // 执行 layer 的 path, 即 设置 stroke 的路径
    lineLayer.path = linePath.CGPath;
    lineLayer.fillColor = nil; // 默认为blackColor
    [lineView.layer addSublayer:lineLayer];
    
}
@end
