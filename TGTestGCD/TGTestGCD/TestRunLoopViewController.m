//
//  TestRunLoopViewController.m
//  TGTestGCD
//
//  Created by MacPro on 2017/12/6.
//  Copyright © 2017年 Centaline. All rights reserved.
//

#import "TestRunLoopViewController.h"
#import "TGThread.h"

@interface TestRunLoopViewController ()
@property (strong, nonatomic) TGThread *subThread;

@end

@implementation TestRunLoopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self testThread];
}

/** 测试线程保活 */
- (void)testThread {
    TGThread *thred = [[TGThread alloc] initWithTarget:self selector:@selector(subThreadEntryPoint) object:nil];
    [thred setName:@"subThtead"];
    [thred start];
    self.subThread = thred;
}

/** 子线程启动后, 启动 runloop  */
- (void)subThreadEntryPoint {
    @autoreleasepool {
        // 开启 runloop
        NSRunLoop *runloop = [NSRunLoop currentRunLoop];
        // 注册 runloop 需要监听的事件端口号
        // 此处如果将添加 port 注释掉, 因为 mode 中没有 item 任务
        // 向 mode 中添加两类 item 任务: NSPort: source1, NSTimer.
        // 如果使用 CFRunloopRef 则可以使用 C 语言的 API 添加 source timer, observer
        [runloop addPort:[NSPort port] forMode:NSRunLoopCommonModes];
        NSLog(@"before runloop start, %@", runloop.currentMode);
        [runloop run];
    }
}

/** 子线程任务 */
- (void)subThreadOperation {
    @autoreleasepool {
        // 输出 mode 为 defaultMode, 因为自定义创建的 thread 中的任务都在 defaultMode 中执行.
        // 在子线程创建完毕之后, 最好所有任务放在 autoreleasePool 中执行
        NSLog(@"after runloop start , %@", [NSRunLoop currentRunLoop].currentMode);
        NSLog(@"thread %@ start ", [NSThread currentThread]);
        [NSThread sleepForTimeInterval:4];
        NSLog(@"thread %@ end ", [NSThread currentThread]);
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self performSelector:@selector(subThreadOperation) onThread:self.subThread withObject:nil waitUntilDone:NO];
}

// AFNetworking 2.6.x 中使用 runloop 的例子
// 将任务添加到后台线程中,


@end
