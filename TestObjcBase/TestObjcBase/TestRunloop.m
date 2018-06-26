//
//  TestRunloop.m
//  TestObjcBase
//
//  Created by MacPro on 2018/6/26.
//  Copyright © 2018年 Centaline. All rights reserved.
//

#import "TestRunloop.h"

@interface TestRunloop()
@property (strong, nonatomic) NSThread *thread;

@end

@implementation TestRunloop
- (void)testRunloop {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
       NSLog(@"线程开始");
        self.thread = [NSThread currentThread];
        
        NSRunLoop *runloop = [NSRunLoop currentRunLoop];
        // 添加一个port,防止 runloop 没事干退出
        [runloop addPort:[NSMachPort port] forMode:NSDefaultRunLoopMode];
        
        // 运行一个runloop.
        [runloop runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        
        NSLog(@"线程结束");
        
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 在一步线程中调用方法
        [self performSelector:@selector(receiveMsg) onThread:self.thread withObject:nil waitUntilDone:NO];
    });

    
}

- (void)receiveMsg {
    NSLog(@"收到消息了, 在这个线程%@", [NSThread currentThread]);
}
@end
