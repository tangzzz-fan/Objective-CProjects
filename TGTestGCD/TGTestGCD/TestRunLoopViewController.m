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



@end
