//
//  ViewController.m
//  TGTestKit
//
//  Created by MacPro on 2017/12/21.
//  Copyright © 2017年 Centaline. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) NSString *target;

@end

@implementation ViewController
- (IBAction)touchAction:(id)sender {
    dispatch_queue_t queue = dispatch_queue_create("parallel", DISPATCH_QUEUE_CONCURRENT);
    for (int i = 0; i < 1000000 ; i++) {
        dispatch_async(queue, ^{
            // 异步线程并发赋值
            self.target = [NSString stringWithFormat:@"parallel%d",i];
        });
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    dispatch_queue_t queue = dispatch_get_main_queue();
    dispatch_async(queue, ^{
        NSLog(@"I am here");
    });
    NSLog(@"aaaaa");
}

//- (void)setTarget:(NSString *)target {
//    @synchronized(_target) {
//        _target = target;
//    }
//}


@end
