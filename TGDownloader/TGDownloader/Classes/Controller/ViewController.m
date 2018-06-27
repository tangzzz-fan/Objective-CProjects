//
//  ViewController.m
//  TGDownloader
//
//  Created by MacPro on 2017/11/29.
//  Copyright © 2017年 Centaline. All rights reserved.
//

#import "ViewController.h"

#import "TGDownloader.h"

@interface ViewController ()
@property (strong, nonatomic) TGDownloader *downloader;

@end

@implementation ViewController

#pragma mark - LifrCycle

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self timer];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
//    [self.timer invalidate];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
//    [self.timer invalidate];
}

- (void)dealloc {
    NSLog(@"dealloc");
}
#pragma mark - Actions
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    NSURL *url = [NSURL URLWithString:@"http://m2.pc6.com/xxj/ptgui.dmg"];
//    [self.downloader downloader:url];
//}

- (void)update {
    NSLog(@"执行 update 方法");
//    NSLog(@"timer update, %lld", self.downloader.state);
}
- (IBAction)download:(id)sender {
    NSURL *url = [NSURL URLWithString:@"http://m2.pc6.com/xxj/ptgui.dmg"];
//    [self.downloader downloader:url];
    // 将获取到的总大小传递出来, 然后可以保存在沙盒中
    [self.downloader downloader:url downloadInfo:^(long long totalSize) {
        // 这个总的size 会根据head 请求获取到
        NSLog(@"download info %lld", totalSize);
    } progress:^(float progress) { // 重写了 progress 的setter方法, 每次变化都会通知
        NSLog(@"下载进度, %f", progress);
    } succeed:^(NSString *filePath) {
        NSLog(@"下载成功, 路径:%@", filePath);
    } failed:^{
        NSLog(@"失败");
    }];
    
    // 监听下载状态的变化
    [self.downloader setStateChange:^(TGDownloadState state) {
       NSLog(@"----stateChanged, %zd", state);
    }];
}

- (IBAction)pause:(id)sender {
    [self.downloader pauseCurrentTask];
}
- (IBAction)cancel:(id)sender {
    [self.downloader cancelCurrentTask];
}
- (IBAction)cancelAndClean:(id)sender {
    [self.downloader cancelAndClean];
}
#pragma mark - Getter && Setter
- (TGDownloader *)downloader {
    if (!_downloader) {
        _downloader = [[TGDownloader alloc] init];
    }
    return _downloader;
}


@end
