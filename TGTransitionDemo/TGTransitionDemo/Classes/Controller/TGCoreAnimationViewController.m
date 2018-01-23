//
//  TGCoreAnimationViewController.m
//  TGTransitionDemo
//
//  Created by 汤振治 on 23/01/2018.
//  Copyright © 2018 Centaline. All rights reserved.
//

#import "TGCoreAnimationViewController.h"

@interface TGCoreAnimationViewController ()<CAAnimationDelegate>
/** calayer */
@property (nonatomic, strong) CALayer *layer;
@end

@implementation TGCoreAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self testBasicAnimation];
//    [self testCoreAnimation];
}

- (void)testBasicAnimation {
    // 设置背景为图片
    UIImage *backgroundImage = [UIImage imageNamed:@"background.jpg"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:backgroundImage];
    
    //自定义一个图层
    self.layer = [[CALayer alloc] init];
    self.layer.bounds = CGRectMake(0, 0, 10, 20);
    self.layer.position = CGPointMake(50, 150);
    self.layer.contents = (id)[UIImage imageNamed:@"patal.png"].CGImage;
    [self.view.layer addSublayer:self.layer];
}

- (void)testCoreAnimation {
    UIImage *image = [UIImage imageNamed:@"photo.jpg"];
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = image;
    imageView.frame = CGRectMake(120, 140, 80, 80);
    [self.view addSubview:imageView];
    
    //两秒后开始一个持续一分钟的动画
    [UIView animateWithDuration:1 delay:2 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        imageView.frame = CGRectMake(80, 100, 160, 160);
    } completion:nil];
}

#pragma mark 移动动画
- (void)translatonAnimation:(CGPoint)location {
    //1.创建动画并指定动画属性
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    
    //2.设置动画属性初始值和结束值
    //    basicAnimation.fromValue=[NSNumber numberWithInteger:50];//可以不设置，默认为图层初始状态
    basicAnimation.toValue = [NSValue valueWithCGPoint:location];
    
    //设置其他动画属性
    basicAnimation.duration = 1.0;//动画时间5秒
    //basicAnimation.repeatCount=HUGE_VALF;//设置重复次数,HUGE_VALF可看做无穷大，起到循环动画的效果
    basicAnimation.removedOnCompletion = NO;//运行一次是否移除动画
    basicAnimation.delegate = self;
    //存储当前位置在动画结束后使用
    [basicAnimation setValue:[NSValue valueWithCGPoint:location] forKey:@"KCBasicAnimationLocation"];
    
    //3.添加动画到图层，注意key相当于给动画进行命名，以后获得该动画时可以使用此名称获取
    [self.layer addAnimation:basicAnimation forKey:@"KCBasicAnimation_Translation"];
}

#pragma mark 点击事件
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = touches.anyObject;
    CGPoint location = [touch locationInView:self.view];
    //创建并开始动画
    [self translatonAnimation:location];
}

#pragma mark - 动画代理方法
#pragma mark 动画开始
- (void)animationDidStart:(CAAnimation *)anim {
    NSLog(@"animation(%@) start.\r_layer.frame=%@",anim,NSStringFromCGRect(self.layer.frame));
    NSLog(@"%@",[self.layer animationForKey:@"KCBasicAnimation_Translation"]);//通过前面的设置的key获得动画
}

#pragma mark 动画结束
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    NSLog(@"animation(%@) stop.\r_layer.frame=%@",anim,NSStringFromCGRect(self.layer.frame));
    self.layer.position = [[anim valueForKey:@"KCBasicAnimationLocation"] CGPointValue];
}

@end
