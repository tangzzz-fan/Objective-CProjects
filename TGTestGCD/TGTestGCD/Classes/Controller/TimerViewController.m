//
//  TimerViewController.m
//  TGTestGCD
//
//  Created by MacPro on 2017/12/15.
//  Copyright © 2017年 Centaline. All rights reserved.
//

#import "TimerViewController.h"

@interface TimerViewController ()
@property (nonatomic,weak) NSTimer *timer1;
@property (nonatomic,weak) NSTimer *timer2;
@end

@implementation TimerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
}

- (void)viewDidDisappear:(BOOL)animated {
    // 造成引用的原因:
    [super viewDidDisappear:animated];
    [self.timer1 invalidate];
    [self.timer2 invalidate];
}

/**
 * NSTimer不是一种实时机制，官方文档明确说明在一个循环中如果RunLoop没有被识别（这个时间大概在50-100ms）或者说当前RunLoop在执行一个长的call out（例如执行某个循环操作）
 * 则NSTimer可能就会存在误差，RunLoop在下一次循环中继续检查并根据情况确定是否执行（NSTimer的执行时间总是固定在一定的时间间隔，
 * 例如1:00:00、1:00:01、1:00:02、1:00:05则跳过了第4、5次运行循环）。
 * 结论: NSTimer 不是一个实时机制
 */
- (void)test2 {
    
}

- (void)test1 {
    self.view.backgroundColor = [UIColor blueColor];
    
    // timer1创建后会自动以NSDefaultRunLoopMode默认模式添加到当前RunLoop中，所以可以正常工作
    self.timer1 = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timeInterval:) userInfo:nil repeats:YES];
    NSTimer *tempTimer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(timeInterval:) userInfo:nil repeats:YES];
    // 如果不把timer2添加到RunLoop中是无法正常工作的(注意如果想要在滚动UIScrollView时timer2可以正常工作可以将NSDefaultRunLoopMode改为NSRunLoopCommonModes)
    [[NSRunLoop currentRunLoop] addTimer:tempTimer forMode:NSDefaultRunLoopMode];
    // 此处 timer2 使用的是 weak 修饰, 如果直接复制, 则会立即释放, 此处没有出现问题是因为:已经将 timer 加入到当前的 runloop 中, 已经被强持有一次了, (runloop 对 timer 做了一次强引用(retain))
    // timer 的 target 为 self.
    /**
     一种是将target分离出来独立成一个对象（在这个对象中创建NSTimer并将对象本身作为NSTimer的target），控制器通过这个对象间接使用NSTimer；另一种方式的思路仍然是转移target，只是可以直接增加NSTimer扩展（分类），让NSTimer自身做为target，同时可以将操作selector封装到block中。
     */
    self.timer2 = tempTimer;
    
    CGRect rect = [UIScreen mainScreen].bounds;
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectInset(rect, 0, 200)];
    [self.view addSubview:scrollView];
    
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectInset(scrollView.bounds, -100, -100)];
    contentView.backgroundColor = [UIColor redColor];
    [scrollView addSubview:contentView];
    scrollView.contentSize = contentView.frame.size;
}


- (void)timeInterval:(NSTimer *)timer {
    if (self.timer1 == timer) {
        NSLog(@"timer1...in runloop Mode %@", [[NSRunLoop currentRunLoop] currentMode]);
    } else {
        NSLog(@"timer2...in runloop Mode %@", [[NSRunLoop currentRunLoop] currentMode]);
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (void)dealloc {
/** 此处出现了未及时释放的问题 */
    [self.timer1 invalidate];
    [self.timer2 invalidate];
    
    NSLog(@"timerViewController dealloc...");
}



@end
