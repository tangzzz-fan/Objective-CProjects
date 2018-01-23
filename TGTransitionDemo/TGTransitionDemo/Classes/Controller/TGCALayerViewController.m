//
//  TGCALayerViewController.m
//  TGTransitionDemo
//
//  Created by 汤振治 on 23/01/2018.
//  Copyright © 2018 Centaline. All rights reserved.
//

#import "TGCALayerViewController.h"

@interface TGCALayerViewController ()<CALayerDelegate>

@end

@implementation TGCALayerViewController

#define WIDTH [UIScreen mainScreen].bounds.size.width/8
#define HEIGHT [UIScreen mainScreen].bounds.size.height
#define PHOTO_HEIGHT 150



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self drawCircleLayer];
    
//    [self drawMyLayer];
}

// 设置圆角, 设置阴影
- (void)drawCircleLayer {
//    [self setupCustomLayer];
    [self setupCustomShadowLayer];
}

- (void)setupCustomShadowLayer {
    self.view.backgroundColor = [UIColor orangeColor];

    // 设置图片位置和边框
    CGPoint position = CGPointMake(160, 200);
    CGRect bounds = CGRectMake(0, 0, PHOTO_HEIGHT, PHOTO_HEIGHT);
    CGFloat cornerRadius = PHOTO_HEIGHT/2;
    CGFloat borderWidth = 2;
    
    // 阴影图层
    CALayer *shadowLayer = [[CALayer alloc] init];
    shadowLayer.bounds = bounds;
    shadowLayer.position = position;
    shadowLayer.cornerRadius = cornerRadius;
    shadowLayer.shadowColor = [UIColor blackColor].CGColor;
    shadowLayer.shadowOffset = CGSizeMake(2, 1);
    shadowLayer.shadowOpacity = 1;
    shadowLayer.borderColor = [UIColor whiteColor].CGColor;
    shadowLayer.borderWidth = borderWidth;
    [self.view.layer addSublayer:shadowLayer];
    
    // 容器图层
    CALayer *layer = [[CALayer alloc] init];
    layer.bounds = bounds;
    layer.position = position;
    layer.backgroundColor = [UIColor redColor].CGColor;
    layer.cornerRadius = cornerRadius;
    layer.masksToBounds = YES;
    layer.borderColor = [UIColor whiteColor].CGColor;
    layer.borderWidth = borderWidth;
    ////
    UIImage *image=[UIImage imageNamed:@"photo.jpg"];
    // 设置设置 image 为 content
    [layer setContents:(id)image.CGImage];
    ////
    [self.view.layer addSublayer:layer];
    
//    layer.transform = CATransform3DMakeRotation(M_PI, 1, 0, 0);

//    layer.delegate = self;
    
    // 调用 setNeedsDisplay
//    [layer setNeedsDisplay];
    
}

// 无法同时设置阴影效果
- (void)setupCustomLayer {
    
    self.view.backgroundColor = [UIColor orangeColor];
    //自定义图层
    CALayer *layer = [[CALayer alloc] init];
    layer.bounds = CGRectMake(0, 0, PHOTO_HEIGHT, PHOTO_HEIGHT);
    layer.position = CGPointMake(160, 200);
    layer.backgroundColor = [UIColor redColor].CGColor;
    layer.cornerRadius = PHOTO_HEIGHT/2;
    
    //注意仅仅设置圆角，对于图形而言可以正常显示，但是对于图层中绘制的图片无法正确显示
    //如果想要正确显示则必须设置masksToBounds=YES，剪切子图层
    layer.masksToBounds = YES;
    //阴影效果无法和masksToBounds同时使用，因为masksToBounds的目的就是剪切外边框，
    //而阴影效果刚好在外边框
    //    layer.shadowColor=[UIColor grayColor].CGColor;
    //    layer.shadowOffset=CGSizeMake(2, 2);
    //    layer.shadowOpacity=1;
    //设置边框
    layer.borderColor = [UIColor whiteColor].CGColor;
    layer.borderWidth = 2;
    
    //设置图层代理
    layer.delegate = self;
    
    //添加图层到根图层
    [self.view.layer addSublayer:layer];
    
    //调用图层setNeedDisplay,否则代理方法不会被调用
    [layer setNeedsDisplay];
}

// 调整 calayer 的 position
- (void)drawMyLayer {
    
    CGSize size = [UIScreen mainScreen].bounds.size;
    
    //获得根图层
    CALayer *layer = [[CALayer alloc] init];
    //设置背景颜色,由于QuartzCore是跨平台框架，无法直接使用UIColor
    layer.backgroundColor = [UIColor colorWithRed:0 green:146/255.0 blue:1.0 alpha:1.0].CGColor;
    //设置中心点
    layer.position = CGPointMake(size.width/2, size.height/2);
    //设置大小
    layer.bounds = CGRectMake(0, 0, WIDTH, WIDTH);
    //设置圆角,当圆角半径等于矩形的一半时看起来就是一个圆形
    layer.cornerRadius = WIDTH / 2;
    //设置阴影
    layer.shadowColor = [UIColor grayColor].CGColor;
    layer.shadowOffset = CGSizeMake(2, 2);
    layer.shadowOpacity = 0.9;
    //设置边框
    layer.borderColor = [UIColor whiteColor].CGColor;
    layer.borderWidth = 2;
    
    //设置锚点
    layer.anchorPoint = CGPointZero;
    
    [self.view.layer addSublayer:layer];
    
}

#pragma mark - Actions
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    // 用户点击时,获取最上层的图层, 获取点击的位置, 设置为获取的 layer 的 position
    
//    UITouch *touch = [touches anyObject];
//    // 获取最上层的图层
//    CALayer *layer = self.view.layer.sublayers[0];
//    CGFloat width = layer.bounds.size.width;
//
//    if (width == WIDTH) {
//        width = WIDTH * 4;
//    } else {
//        width = WIDTH;
//    }
//
//    layer.bounds = CGRectMake(0, 0, width, width);
//    // 调整 position
//    layer.position = [touch locationInView:self.view];
//    layer.cornerRadius = width / 2;
}

#pragma mark - Delegate
- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx {
    //    NSLog(@"%@",layer);//这个图层正是上面定义的图层
//    CGContextSaveGState(ctx);
    
    //图形上下文形变，解决图片倒立的问题
//    CGContextScaleCTM(ctx, 1, -1);
//    CGContextTranslateCTM(ctx, 0, -PHOTO_HEIGHT);
    
    UIImage *image = [UIImage imageNamed:@"photo.jpg"];
    //注意这个位置是相对于图层而言的不是屏幕
    CGContextDrawImage(ctx, CGRectMake(0, 0, PHOTO_HEIGHT, PHOTO_HEIGHT), image.CGImage);
    
//    CGContextFillRect(ctx, CGRectMake(0, 0, PHOTO_HEIGHT, PHOTO_HEIGHT));
//    CGContextDrawPath(ctx, kCGPathFillStroke);
    
//    CGContextRestoreGState(ctx);
}

@end
