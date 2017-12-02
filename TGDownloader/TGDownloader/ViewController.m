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
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSURL *url = [NSURL URLWithString:@"http://m2.pc6.com/xxj/ptgui.dmg"];
    [self.downloader downloader:url];
}

#pragma mark - Getter && Setter
- (TGDownloader *)downloader {
    if (!_downloader) {
        _downloader = [[TGDownloader alloc] init];
    }
    return _downloader;
}


@end
