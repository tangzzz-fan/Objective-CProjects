//
//  TGTestThreadViewController.m
//  TGTestUI
//
//  Created by MacPro on 2018/6/27.
//  Copyright © 2018年 Centaline. All rights reserved.
//

#import "TGTestThreadViewController.h"

@interface TGTestThreadViewController ()
//@property (weak, nonatomic) IBOutlet UIImageView *imageView;
//@property (strong, nonatomic) UIImage *image1;
//@property (strong, nonatomic) UIImage *image2;
//
//@property (strong, nonatomic) NSThread *mythread;

@end

@implementation TGTestThreadViewController




- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self example1];
    
    
}

// ARC

/**
 在ARC模式下，打印出来的结果并不是NSStackBlock这个类型，很多人以为在ARC模式下block的类型只有NSGlobalBlock和NSMallocBlock两种，其实这种观点是错误的。在ARC情况下，生成的block也是NSStackBlock，只是当赋值给strong对象时，系统会主动对其进行copy:
 */
- (void)example1 {
    int base = 100;
    // arc 下访问外部局部变量, 自动从栈上拷贝到堆上, 类型变为 mallocStack
    long (^stackBlock) (int a, int b) = ^long(int a, int b) {
        return base + a + b;
    };
    
    NSLog(@"%@", stackBlock);
    
    // 没有赋值给其他人, 没有访问外部变量
    int i=0;
    NSLog(@"%@", ^{
        NSLog(@"stack block here, i=%d", i);
    });
    
    
    // 赋值给strong对象时void
    void (^block)(void)=^{
        NSLog(@"stack block here, i=%d", i);
    };
    NSLog(@"%@",block);
}

// MRC
- (void)addBlockToArray:(NSMutableArray *)array {
    NSString *b = @"Test";
    // 该 block 为栈block, 在 mrc 下, 在堆中调用栈中的数据 会引起闪退
    [array addObject:[^{
        NSLog(@"%@", b);
    } copy]];
}

- (void)example {
    
    NSMutableArray *array = [NSMutableArray array];
    
    for (NSInteger i = 0; i < 10; i ++) {
        [self addBlockToArray:array];
        void (^block)(void) = [array objectAtIndex:i];
        block();
    }
    
    
}

//- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//    NSLog(@"viewWillAppear__str:%@", weakObj);
//    NSLog(@"viewWillAppear__str2:%@", weakObj2);
//}
//
//- (void)viewDidAppear:(BOOL)animated {
//    [super viewDidAppear:animated];
//    NSLog(@"viewDidAppear__str:%@", weakObj);
//    NSLog(@"viewDidAppear__str2:%@", weakObj2);
//}
//- (void)alwaysRunInBackground {
//    // 1 创建一个 thread
//    // vc 持有
//    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(myThreadRun) object:@"Tango"];
//    // 为runloop 添加source
//    
//    
////    self.mythread  = thread;
////    [self.mythread start];
//}
//
//- (void)myThreadRun {
//    
//    // 此时 在非主线程 开启对应的runloop: 添加 source
//    [[NSRunLoop currentRunLoop] addPort:[[NSPort alloc] init] forMode:NSDefaultRunLoopMode];
//    [[NSRunLoop currentRunLoop] run];
//    
//    NSLog(@"mythread run, %s", __func__);
//}
//
//- (void)tryPerformSelectorOnMianThread{
//    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        
//        [self performSelector:@selector(backGroundThread) onThread:[NSThread currentThread] withObject:nil waitUntilDone:NO];
//    
//        // 获取这个线程的 runloop 开启
//        NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
//        [runLoop run];
//    
//    });
//}
//    
//- (void)mainThreadMethod{
//    
//    NSLog(@"execute %s",__func__);
//}
//
//- (void)backGroundThread{
//    
//    NSLog(@"----- %u",[NSThread isMainThread]);
//    
//    NSLog(@"execute %s",__func__);
//    
//}
//
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//
////    [self testRunloop];
//
////    [self backgroundRunin];
//}
//
//- (void)backgroundRunin {
//    NSLog(@"%@",self.mythread);
////    每次都会执行, 但是后台任务并没有开启.
//    [self performSelector:@selector(doBackGroundThreadWork) onThread:self.mythread withObject:nil waitUntilDone:NO];
//}
//
//- (void)doBackGroundThreadWork {
//    NSLog(@"I am doing my work background");
//}
//
//- (void)testRunloop {
//    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_TARGET_QUEUE_DEFAULT, 0), ^{
//        while (1) {
//            NSLog(@"while begin");
//            // the thread be blocked here
//            NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
//            NSLog(@"%@",runLoop);
//
//            NSThread *thread = [NSThread currentThread];
//            NSLog(@"currentThread %@", thread);
//            [runLoop runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
//            // this will not be executed
//            NSLog(@"while end");
//            
//        }
//    });
//    
//   
//}
//
//
//- (void)testOperation {
//    // 创建非住队列
//    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
//    // 下载第一张图片
//    NSBlockOperation *download1 = [NSBlockOperation blockOperationWithBlock:^{
//        NSURL *url = [NSURL URLWithString:@"http://img2.3lian.com/2014/c7/12/d/77.jpg"];
//        NSData *data = [NSData dataWithContentsOfURL:url];
//        self.image1 = [UIImage imageWithData:data];
//    }];
//    // 下载第二张图片
//    NSBlockOperation *download2 = [NSBlockOperation blockOperationWithBlock:^{
//        NSURL *url = [NSURL URLWithString:@"http://img2.3lian.com/2014/c7/12/d/77.jpg"];
//        NSData *data = [NSData dataWithContentsOfURL:url];
//        self.image2 = [UIImage imageWithData:data];
//    }];
//    // 合成操作
//    NSBlockOperation *combie = [NSBlockOperation blockOperationWithBlock:^{
//        // 开启图形上下文
//        UIGraphicsBeginImageContext(CGSizeMake(375, 667));
//        // 绘制图片1
//        [self.image1 drawInRect:CGRectMake(0, 0, 375, 333)];
//        // 绘制图片2
//        [self.image2 drawInRect:CGRectMake(0, 334, 375, 333)];
//        // 获取合成图片
//        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//        // 关闭图形上下文
//        UIGraphicsEndImageContext();
//        // 回到主线程刷新UI
//        [[NSOperationQueue mainQueue]addOperationWithBlock:^{
//            self.imageView.image = image;
//        }];
//    }];
//    // 添加依赖，合成图片需要等图片1，图片2都下载完毕之后合成
//    // 设置依赖
//    [combie addDependency:download1];
//    [combie addDependency:download2];
//    // 添加操作到队列
//    [queue addOperation:download1];
//    [queue addOperation:download2];
//    [queue addOperation:combie];
//    
//    
//}
//
//- (void)testNSThread {
//    // 总票数为30
//    self.numTicket = 30;
//    self.thread01 = [[NSThread alloc]initWithTarget:self selector:@selector(saleTicket) object:nil];
//    self.thread01.name = @"售票员01";
//    self.thread02 = [[NSThread alloc]initWithTarget:self selector:@selector(saleTicket) object:nil];
//    self.thread02.name = @"售票员02";
//    self.thread03 = [[NSThread alloc]initWithTarget:self selector:@selector(saleTicket) object:nil];
//    self.thread03.name = @"售票员03";
//}
//
//// 售票
//-(void)saleTicket
//{
//    while (1) {
//        // 创建对象
//        // self.obj = [[NSObject alloc]init];
//        // 锁对象，本身就是一个对象，所以self就可以了
//        // 锁定的时候，其他线程没有办法访问这段代码
//        @synchronized (self) {
//            // 模拟售票时间，我们让线程休息0.05s
//            [NSThread sleepForTimeInterval:0.05];
//            if (self.numTicket > 0) {
//                self.numTicket -= 1;
//                NSLog(@"%@卖出了一张票，还剩下%zd张票",[NSThread currentThread].name,self.numTicket);
//            }else{
//                NSLog(@"票已经卖完了");
//                break;
//            }
//        }
//    }
//}

@end
