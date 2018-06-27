//
//  TGTestThreadViewController.m
//  TGTestUI
//
//  Created by MacPro on 2018/6/27.
//  Copyright © 2018年 Centaline. All rights reserved.
//

#import "TGTestThreadViewController.h"

@interface TGTestThreadViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) UIImage *image1;
@property (strong, nonatomic) UIImage *image2;


@end

@implementation TGTestThreadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}




- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self testOperation];

}


- (void)testOperation {
    // 创建非住队列
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    // 下载第一张图片
    NSBlockOperation *download1 = [NSBlockOperation blockOperationWithBlock:^{
        NSURL *url = [NSURL URLWithString:@"http://img2.3lian.com/2014/c7/12/d/77.jpg"];
        NSData *data = [NSData dataWithContentsOfURL:url];
        self.image1 = [UIImage imageWithData:data];
    }];
    // 下载第二张图片
    NSBlockOperation *download2 = [NSBlockOperation blockOperationWithBlock:^{
        NSURL *url = [NSURL URLWithString:@"http://img2.3lian.com/2014/c7/12/d/77.jpg"];
        NSData *data = [NSData dataWithContentsOfURL:url];
        self.image2 = [UIImage imageWithData:data];
    }];
    // 合成操作
    NSBlockOperation *combie = [NSBlockOperation blockOperationWithBlock:^{
        // 开启图形上下文
        UIGraphicsBeginImageContext(CGSizeMake(375, 667));
        // 绘制图片1
        [self.image1 drawInRect:CGRectMake(0, 0, 375, 333)];
        // 绘制图片2
        [self.image2 drawInRect:CGRectMake(0, 334, 375, 333)];
        // 获取合成图片
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        // 关闭图形上下文
        UIGraphicsEndImageContext();
        // 回到主线程刷新UI
        [[NSOperationQueue mainQueue]addOperationWithBlock:^{
            self.imageView.image = image;
        }];
    }];
    // 添加依赖，合成图片需要等图片1，图片2都下载完毕之后合成
    // 设置依赖
    [combie addDependency:download1];
    [combie addDependency:download2];
    // 添加操作到队列
    [queue addOperation:download1];
    [queue addOperation:download2];
    [queue addOperation:combie];
    
    
}

- (void)testNSThread {
    // 总票数为30
    self.numTicket = 30;
    self.thread01 = [[NSThread alloc]initWithTarget:self selector:@selector(saleTicket) object:nil];
    self.thread01.name = @"售票员01";
    self.thread02 = [[NSThread alloc]initWithTarget:self selector:@selector(saleTicket) object:nil];
    self.thread02.name = @"售票员02";
    self.thread03 = [[NSThread alloc]initWithTarget:self selector:@selector(saleTicket) object:nil];
    self.thread03.name = @"售票员03";
}

// 售票
-(void)saleTicket
{
    while (1) {
        // 创建对象
        // self.obj = [[NSObject alloc]init];
        // 锁对象，本身就是一个对象，所以self就可以了
        // 锁定的时候，其他线程没有办法访问这段代码
        @synchronized (self) {
            // 模拟售票时间，我们让线程休息0.05s
            [NSThread sleepForTimeInterval:0.05];
            if (self.numTicket > 0) {
                self.numTicket -= 1;
                NSLog(@"%@卖出了一张票，还剩下%zd张票",[NSThread currentThread].name,self.numTicket);
            }else{
                NSLog(@"票已经卖完了");
                break;
            }
        }
    }
}

@end
