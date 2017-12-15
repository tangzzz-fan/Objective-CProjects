//
//  Timer2ViewController.m
//  TGTestGCD
//
//  Created by MacPro on 2017/12/15.
//  Copyright © 2017年 Centaline. All rights reserved.
//

#import "Timer2ViewController.h"

@interface Timer2ViewController ()
@property (nonatomic,weak) NSTimer *timer1;
@property (nonatomic,strong) NSThread *thread1;
@end

@implementation Timer2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    
    // 由于下面的方法无法拿到NSThread的引用，也就无法控制线程的状态
    //[NSThread detachNewThreadSelector:@selector(performTask) toTarget:self withObject:nil];
    self.thread1 = [[NSThread alloc] initWithTarget:self selector:@selector(performTask) object:nil];
    [self.thread1 start];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.thread1 cancel];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dealloc {
    [self.timer1 invalidate];
    NSLog(@"ViewController dealloc.");
}

- (void)performTask {
    // 使用下面的方式创建定时器虽然会自动加入到当前线程的RunLoop中，但是除了主线程外其他线程的RunLoop默认是不会运行的，必须手动调用
    __weak typeof(self) weakSelf = self;
    self.timer1 = [NSTimer scheduledTimerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
        if ([NSThread currentThread].isCancelled) {
            //[NSObject cancelPreviousPerformRequestsWithTarget:weakSelf selector:@selector(caculate) object:nil];
            //[NSThread exit];
            [weakSelf.timer1 invalidate];
        }
        NSLog(@"timer1...");
    }];
    
    NSLog(@"runloop before performSelector:%@",[NSRunLoop currentRunLoop]);
    
    // 区分直接调用和「performSelector:withObject:afterDelay:」区别,下面的直接调用无论是否运行RunLoop一样可以执行，但是后者则不行。
    //[self caculate];
    [self performSelector:@selector(caculate) withObject:nil afterDelay:2.0];
    
    // 取消当前RunLoop中注册测selector（注意：只是当前RunLoop，所以也只能在当前RunLoop中取消）
    // [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(caculate) object:nil];
    NSLog(@"runloop after performSelector:%@",[NSRunLoop currentRunLoop]);
    
    // 非主线程RunLoop必须手动调用
    [[NSRunLoop currentRunLoop] run];
    
    
    // 当 runloop 的 observer, Source, timer 没有了之后, runloop 会自动退出
    NSLog(@"注意：如果RunLoop不退出（运行中），这里的代码并不会执行，RunLoop本身就是一个循环.");
    
    
}

- (void)caculate {
    for (int i = 0;i < 99;++i) {
        NSLog(@"%i,%@",i,[NSThread currentThread]);
        if ([NSThread currentThread].isCancelled) {
            return;
        }
    }
}

@end
