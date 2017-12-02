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
}


#pragma mark - Actions
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    NSURL *url = [NSURL URLWithString:@"http://m2.pc6.com/xxj/ptgui.dmg"];
//    [self.downloader downloader:url];
//}
- (IBAction)download:(id)sender {
    NSURL *url = [NSURL URLWithString:@"http://m2.pc6.com/xxj/ptgui.dmg"];
//    [self.downloader downloader:url];
    [self.downloader downloader:url downloadInfo:^(long long totalSize) {
        NSLog(@"download info %lld", totalSize);
    } progress:^(float progress) {
        NSLog(@"下载进度, %f", progress);
    } succeed:^(NSString *filePath) {
        NSLog(@"下载成功, 路径:%@", filePath);
    } failed:^{
        NSLog(@"失败");
    }];
    
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
