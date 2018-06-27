//
//  ViewController.m
//  TGTestGCD
//
//  Created by MacPro on 2017/11/29.
//  Copyright © 2017年 Centaline. All rights reserved.
//

#import "ViewController.h"
#import "JavaScript.h"
@interface ViewController ()
@property (nonatomic) dispatch_source_t timerSource;
@end

@implementation ViewController

- (void)dealloc {
    NSLog(@"delloc");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self testGCD_semaphore];
    
//    [self testForObjectType];
    
//    [self testSycOnMainQueue];
//    [self testChangedQueue];
//    [self testAgain];
//    [self test1];
//    [self testAsyncSync];
//    [self dispatchBarrierAsyncDemo];
//    [self deadLockCase2];
//    [self deadLockCase3];
//    [self deadLockCase5];
//    [self testTargetQueue];
//    [self testWaitBlock];
//    [self testCancelBlock];
//    [self testDispatchGroupWait];
//    [self testAsyncGroup];
//    [self testDispatchSemaphore];
//    [self testDispatchTimer];
//    [self testDispatchIO];
//    [self testDispatchSource];
//    [self testANewDeadLock];
}

- (void)testGCD_semaphore {
    dispatch_semaphore_t signal = dispatch_semaphore_create(1);
    dispatch_time_t overTime = dispatch_time(DISPATCH_TIME_NOW, 3 * NSEC_PER_SEC);
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_semaphore_wait(signal, overTime); // wait 信号量 减1 signal 信号量 加1. 信号量大于0 可以继续访问, 否则就需要等待释放对应的信号, 信号值加1, 因此此处如果设置 signal 为其他的值, 输出的结果也不一样.
        NSLog(@"需要线程同步的操作1 开始");
        sleep(2);
        NSLog(@"需要线程同步的操作1 结束");
        dispatch_semaphore_signal(signal);
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(1);
        dispatch_semaphore_wait(signal, overTime);
        NSLog(@"需要线程同步的操作2");
        dispatch_semaphore_signal(signal);
    });
    
}

- (void)testANewDeadLock {
    dispatch_sync(dispatch_get_main_queue(), ^{
        NSLog(@"task 1 start");
        [NSThread sleepForTimeInterval:1.0];
        NSLog(@"task 1 over");
    });
}

/** 使用 dispatchSource 实现一个定时器 */
/** 使用 dispatch source API 检测系统预设的几个端口中可能产生的事件
 *  当这些对象有事件产生时, 就自动把事件的处理 block 提交到队列中执行(dispach to queue)
 *   DISPATCH_SOURCE_TYPE_DATA_ADD   变量增加
     DISPATCH_SOURCE_TYPE_DATA_OR    变量OR
     DISPATCH_SOURCE_TYPE_MACH_SEND  Mach端口发送
     DISPATCH_SOURCE_TYPE_MACH_RECV  Mach端口接收
     DISPATCH_SOURCE_TYPE_MEMORYPRESSURE 内存压力情况变化
     DISPATCH_SOURCE_TYPE_PROC       与进程相关的事件
     DISPATCH_SOURCE_TYPE_READ       可读取文件映像
     DISPATCH_SOURCE_TYPE_SIGNAL     接收信号
     DISPATCH_SOURCE_TYPE_TIMER      定时器事件
     DISPATCH_SOURCE_TYPE_VNODE      文件系统变更
     DISPATCH_SOURCE_TYPE_WRITE      可写入文件映像
 
    类比 ReactiveCocoa 中的事件处理.
 *  当事件发生时, dispatch source 自动将一个 block 放到一个 dispatch_queue 中执行
 *  dispatch_source_create : 创建一个 dispatch_source 事件源, 专门用于接收事件, 不能处理事件(交给 dispatch_queue 根据资源情况调配 handler 处理) 接收到事件后, dispatch_source 负责取最新的事件源,
 *  dispatch_source_set_event_handler dispatch_source 接收到的事件的处理者, 接收 dispatch_queue 调配.
 *  dispatch_source_set_cancel_handler 设置取消处理的 handler.
 *  dispatch_source_cancel 关闭 dispatch_source 停止监听 source, 就是有事件来之后, source 不再提交给 handler 处理.
 *
 *  使用 DispatchSource 实现一个 NSTimer 的比较.
 *  1 NSTimer 会默认和所在线程中的 runloop 关联, 比如如果在 UI 中定义一个 NSTimer, 则会默认关联 mainQueue 中的 runloop. 此时 runloop 设置的模式为 NSDefaultRunLoopMode 模式下, 出现一个 bug : 在 UITableView 上下滑动时, 会自动设置 runloop 的模式切换, 此时, 因为模式转化了, 主线程中的timer 便无法继续工作了.
 *   将 runloop 中的 timer 的模式设定为不被系统改变的模式: commonMode, 此时便不再受影响.
 *  2 NSTimer 不释放的问题 持续引用造成的内存泄漏 初始化 timer 时, 设置 timer 的 target 为视图控制器自己, 而 timer 又和 runloop 关联, 当在非主线程中使用了 timer, 要注意此时线程对应的 runloop  还没有开启
 *      内存溢出: 需要使用的内存超出了系统内存大小
 *  3 在视图即将消失, 还是视图已经消失的情况下设置 timer invialite
 *
 */
- (void)testDispatchSource {
    // 初始化 source 操作队列
    dispatch_queue_t queue = dispatch_queue_create("com.tangzz.queue", NULL);
    
    // 创建一个dispatch_source 并绑定操作队列
    _timerSource = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    // 设置定时器间隔时间
    uint64_t interval = 2 * NSEC_PER_SEC;
    // 设置定时器信息
    // 设置两秒钟执行一次 handler
    dispatch_source_set_timer(_timerSource, DISPATCH_TIME_NOW, interval, 0);
    
    // 设置时间的处理 handler
    dispatch_source_set_event_handler(_timerSource, ^{
       NSLog(@"receive time event");
        // 当处理完毕之后, 需要取消对应的事件源
        // dispatch_source_cancel(_timerSource);
    });
    
    // 设置 dispatch_source 开始执行
    dispatch_resume(_timerSource);
    
    // 设置 dispatch_suspend 事件挂起, 一般由于系统资源限制,或者资源条件等待 被挂起
    dispatch_suspend(_timerSource);
}

/** 读取大文件, 多个线程同时读取
 *  dispatch IO 和 dispatch_data 结合使用
 *  dispatch_global_queue 将文件按照指定分块大小同时读取,
 *  在 queue 中有多个并行的消费者
 *  当数据文件比较大时, 使用 dispatch_io 提高读取效率
 */
- (void)testDispatchIO {
//    //dispatch_io_create出错时handler执行的队列
//    dispatch_queue_t pipe_q = dispatch_queue_create("PipeQ", NULL);
//    dispatch_io_t pipe_channel = dispatch_io_create(DISPATCH_IO_STREAM, fd, pipe_q, ^(int err){
//        //出错时执行的handler
//        close(fd);
//    });
//    *out_fd = fdpair[1];
//
//    //设定一次读取的大小(分割大小)
//    dispatch_io_set_low_water(pipe_channel, SIZE_MAX);
//    dispatch_io_read(pipe_channel, 0, SIZE_MAX, pipe_q, ^(bool done, dispatch_data_t pipedata, int err){
//        if (error)
//            return;
//        if (err == 0)
//        {
//            //每次读取到数据进行数据的处理
//            size_t len = dispatch_data_get_size(pipedata);
//            if (len > 0)
//            {
//                const char *bytes = NULL;
//                char *encoded;
//                uint32_t eval;
//                dispatch_data_t md = dispatch_data_create_map(pipedata, (const void **)&bytes, &len);
//                encoded = asl_core_encode_buffer(bytes, len);
//                asl_msg_set_key_val(aux, ASL_KEY_AUX_DATA, encoded);
//                free(encoded);
//                eval = _asl_evaluate_send(NULL, (aslmsg)aux, -1);
//                _asl_send_message(NULL, eval, aux, NULL);
//                asl_msg_release(aux);
//                dispatch_release(md);
//            }
//        }
//        if (done)
//        {
//            //并发读取完毕
//            dispatch_semaphore_signal(sem);
//            dispatch_release(pipe_channel);
//            dispatch_release(pipe_q);
//        }
//    });
    
}

/** 结合 dispatch_after 使用 */
- (void)testDispatchTimer {
    // 延迟5秒提交任务, 什么时候执行, 取决于系统资源(系统分配对应的thread 执行)
    NSLog(@"现在提交一个任务 5秒后可能被执行");
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC));
    dispatch_after(time, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
       NSLog(@"jobs is doing");
    });
}

- (void)testDispatchSemaphore {
    // 创建一个信号量
    // creat 的参数: 表示资源的数量 信号量的初始值, 信号量监听的资源数, 最多可以分配给多少消费者使用
    // 一个资源使用者(生产者, 消费者 要使用临界资源) 先看这个资源上的信号是否大于0 大于0 可以使用
    dispatch_semaphore_t sem = dispatch_semaphore_create(1);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
       NSLog(@"do some job on thread, %@", [NSThread currentThread]);
        sleep(3);
        NSLog(@"increase sem");
        dispatch_semaphore_signal(sem);
    });
    NSLog(@"decrease sem");
    dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
}

/** 补充
 *  dispatch_group_async == group_enter && group_leave
 */
- (void)testAsyncGroup {
    dispatch_group_t group = dispatch_group_create();
    for (NSInteger i = 0; i < 10 ; i++) {
        dispatch_group_enter(group);
        NSLog(@"do block, %zd", i);
        dispatch_group_leave(group);
    }
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    NSLog(@"继续执行");
}

/** 可以用来同步 group 中的任务队列 */
- (void)testDispatchGroupWait {
    dispatch_queue_t queue = dispatch_queue_create("com.tangzz.queue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_group_t group = dispatch_group_create();
    // 将任务异步添加到 group 中执行
    dispatch_group_async(group, queue, ^{
       NSLog(@"block1");
    });
    dispatch_group_async(group, queue, ^{
        NSLog(@"block2");
    });
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    NSLog(@"goon");
    
}



- (void)testCancelBlock {
    dispatch_queue_t queue = dispatch_queue_create("queue", DISPATCH_QUEUE_SERIAL);
    dispatch_block_t block1 = dispatch_block_create(0, ^{
        NSLog(@"block1 begin");
        [NSThread sleepForTimeInterval:1];
        NSLog(@"block1 done");
    });
    dispatch_block_t block2 = dispatch_block_create(0, ^{
        NSLog(@"block2 ");
    });
    dispatch_async(queue, block1);
    dispatch_async(queue, block2);
    dispatch_block_cancel(block2);
}

- (void)testForObjectType {
    Person *p = [[Person alloc] init];
    p.language = [[Language alloc] init];
    
    // 声明一个 student 的泛型对象
    Student<JavaScript *> *stud = [[Student alloc] init];
    stud.programLanguage = [[JavaScript alloc] init];
}

- (void)testWaitBlock {
    dispatch_queue_t queue = dispatch_queue_create("queue", DISPATCH_QUEUE_SERIAL);
    dispatch_block_t block = dispatch_block_create(0, ^{
        NSLog(@"before sleep");
        [NSThread sleepForTimeInterval:1];
        NSLog(@"do something");
        NSLog(@"after sleep");
    });
    dispatch_async(queue, block);
    //等待前面的任务执行完毕
    dispatch_block_wait(block, DISPATCH_TIME_FOREVER);
    NSLog(@"coutinue");

}

- (void)testTargetQueue {
    dispatch_queue_t targetQueue = dispatch_queue_create("target_queue", DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t queue1 = dispatch_queue_create("queue1", DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t queue2 = dispatch_queue_create("queue2", DISPATCH_QUEUE_CONCURRENT);
    // setTargt 设置目标队列, 将自己和目标队列产生依赖
    dispatch_set_target_queue(queue1, targetQueue);
    dispatch_set_target_queue(queue2, targetQueue);
    dispatch_async(queue1, ^{
        NSLog(@"do job1");
        [NSThread sleepForTimeInterval:3.f];
    });
    dispatch_async(queue2, ^{
        NSLog(@"do job2");
        [NSThread sleepForTimeInterval:2.f];
    });
    dispatch_async(queue2, ^{
        NSLog(@"do job3");
        [NSThread sleepForTimeInterval:1.f];
    });
    
}

/** 补充: GCD 中产生死锁的另一个可能, dispatch_queue_set_specific 、dispatch_get_specific
 *  FMDB 中的 queue 中的一个 block 在线程中执行, block 中调用了 inDataBase, 这时要检查是否是在同一个 queue 中, 本质上还是
 *  避免在一个现行队列中执行串行任务 (因为对现行队列的使用会形成一个竞争死锁)
 */
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

// 不会死锁
- (void)deadLockCase2 {
    NSLog(@"1");
    //3会等2，因为2在全局并行队列里，不需要等待3，这样2执行完回到主队列，3就开始执行
    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        NSLog(@"2");
    });
    NSLog(@"3");
}

- (void)deadLockCase3 {
    dispatch_queue_t serialQueue = dispatch_queue_create("com.tangzzz.serialqueue", DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t serialQueue2 = dispatch_queue_create("com.tangzzz1.serialqueue", DISPATCH_QUEUE_SERIAL);
    
    NSLog(@"1");
    dispatch_async(serialQueue, ^{
        NSLog(@"2");
        //串行队列里面派发同步任务就会死锁
        dispatch_sync(serialQueue2, ^{
            NSLog(@"3");
        });
        NSLog(@"4");
    });
    NSLog(@"5");
}

- (void)deadLockCase5 {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"1");
        //回到主线程发现死循环后面就没法执行了
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"2");
        });
        NSLog(@"3");
    });
    NSLog(@"4");
    //死循环 主线程死循环,
    while (1) {
        //
    }
}

@end
