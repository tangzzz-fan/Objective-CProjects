//
//  ViewController.m
//  TGTestGCD
//
//  Created by MacPro on 2017/11/29.
//  Copyright © 2017年 Centaline. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self testSycOnMainQueue];
//    [self testChangedQueue];
//    [self testAgain];
    // 死锁
    [self test1];
//    [self testAsyncSync];
    
//    [self dispatchBarrierAsyncDemo];
}

- (void)testSycOnMainQueue {
    dispatch_queue_t queue = dispatch_queue_create("com.tangzzz.queue", nil);
    dispatch_sync(queue, ^{
        NSLog(@"current thread = %@", [NSThread currentThread]);
        dispatch_sync(dispatch_get_main_queue(), ^{
            NSLog(@"current thread = %@", [NSThread currentThread]);
        });
    });
}

- (void)testChangedQueue {
    NSLog(@"current thread = %@", [NSThread currentThread]);

    dispatch_sync(dispatch_queue_create("1111", DISPATCH_QUEUE_SERIAL), ^{
        
        NSLog(@"current thread = %@", [NSThread currentThread]);

        NSLog(@"1111");
      
    });
    
    NSLog(@"222");
}

- (void)testAgain {
    dispatch_queue_t q = dispatch_queue_create("1111111", DISPATCH_QUEUE_SERIAL);

    // 同步分发一个任务给新的队列, 内部会有一个释放对队列操作的信号(操作在队列的最后一个), 在当前线程中执行对应的操作.
    //
    dispatch_sync(q, ^{
        
        NSLog(@"11111");
//        dispatch_sync(q, ^{
//            NSLog(@"22222");
//        });
        NSLog(@"33333");
    });
    
    NSLog(@"44444");
    NSLog(@"5555");
}

- (void)testAsyncSync {
    dispatch_queue_t queue = dispatch_queue_create("com.demo.serialQueue", DISPATCH_QUEUE_SERIAL);
    NSLog(@"1"); // 任务1
    // 死锁
    // dispatch_sync(queue, ^{
    // 死锁
    dispatch_async(queue, ^{
        // 异步派发中, 使用了线程池, 此时, 又在队列中的一个任务所在的线程上要求做任务, 行不通
        // 这里能不能认为: 此处同步派发一个任务, 去申请队列的使用权, (队列信号: wait),
        // 此时, 这个任务的附属任务(释放队列信号: signal)被添加到当前队列的最后,
        // 这个任务就等队列完成之后, 去释放信号, 但是迟迟等不到现在的队列完成
        NSLog(@"2"); // 任务2
        dispatch_sync(queue, ^{
            NSLog(@"3"); // 任务3
        });
        NSLog(@"4"); // 任务4
    });
    NSLog(@"5"); // 任务5
    
}

- (void)test {

}

- (void)test1 {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"1"); // 任务1
        // 此处没有出现死锁, 因为当前是作为异步任务被提交到并发队列中, 认为创建了一个子线程执行
        // 在子线程上又同步向主线程队列中派发了一个任务2, 因此 2, 3 顺序不一定
        // 任务 1 和任务 4 顺序不一定
        NSLog(@"async global current thread = %@", [NSThread currentThread]);

        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"async main current thread = %@", [NSThread currentThread]);
            NSLog(@"2"); // 任务2
        });
        sleep(3);
        NSLog(@"3"); // 任务3
        NSLog(@"current thread = %@", [NSThread currentThread]);
    });
    NSLog(@"4"); // 任务4
    
    // 1,4 顺序不一定: 在主队列中, 异步派发给全局并行队列.
    // 2,3 顺序不确定: 在全局并发队列中 创建了新的子线程, 从子线程到主线程的切换, 此时要看主线程中是否有正在执行的任务,
    // 如果正在执行3, 那 2 就在 3 后面, 因为是向串行队列中异步派发任务, 队列颗粒度仍然为1, 一次执行一个任务, 但此时可能创建了子线程.
}


- (void)dispatchBarrierAsyncDemo {
    //防止文件读写冲突，可以创建一个串行队列，操作都在这个队列中进行，没有更新数据读用并行，写用串行。
    // 在 setter 方法中, 使用异步任务来避免同步任务可能带来的死锁问题
    // setter 中使用 同步方法, 可能存在的死锁问题: 如果有多个
    // 两个条件: 1 自己定义的队列 2 要进行写操作时, 使用 barrier 栅栏先等待没有结束的任务完成,然后使用 barrier 中提供的 block 中执行写操作.
    dispatch_queue_t dataQueue = dispatch_queue_create("com.starming.gcddemo.dataqueue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(dataQueue, ^{
        [NSThread sleepForTimeInterval:2.f];
        NSLog(@"read data 1");
    });
    dispatch_async(dataQueue, ^{
        NSLog(@"read data 2");
    });
    //等待前面的都完成，在执行barrier后面的
    dispatch_barrier_async(dataQueue, ^{
        NSLog(@"write data 1");
        [NSThread sleepForTimeInterval:1];
    });
    dispatch_async(dataQueue, ^{
        [NSThread sleepForTimeInterval:1.f];
        NSLog(@"read data 3");
    });
    dispatch_async(dataQueue, ^{
        NSLog(@"read data 4");
    });
}

@end
