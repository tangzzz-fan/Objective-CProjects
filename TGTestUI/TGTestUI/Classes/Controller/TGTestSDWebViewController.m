//
//  TGTestSDWebViewController.m
//  TGTestUI
//
//  Created by MacPro on 28/06/2018.
//  Copyright © 2018 Centaline. All rights reserved.
//

#import "TGTestSDWebViewController.h"

#import "SDWebImageDownloader.h"
#import "SDWebImageManager.h"

#import "UIImageView+WebCache.h"

@interface TGTestSDWebViewController ()

@end

@implementation TGTestSDWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self testBarrierSync];
}


- (void)testBarrierSync {
    dispatch_queue_t queue = dispatch_queue_create("Tango", DISPATCH_QUEUE_CONCURRENT);
    
    
    
    dispatch_async(queue, ^{
        NSLog(@"Test1");
    });
    dispatch_async(queue, ^{
        NSLog(@"Test2");
    });
    dispatch_async(queue, ^{
        NSLog(@"Test3");
    });
//    dispatch_barrier_sync(queue, ^{
//        for (NSInteger i = 0; i < 10000; i ++) {
//            if (i == 500) {
//                NSLog(@"point1");
//            } else if (i == 600) {
//                NSLog(@"point2");
//            } else if (i == 700){
//                NSLog(@"point3");
//            }
//        }
//        NSLog(@"barrier");
//    });
    dispatch_barrier_sync(queue, ^{
        for (NSInteger i = 0; i < 10000; i ++) {
            if (i == 500) {
                NSLog(@"point1");
            } else if (i == 600) {
                NSLog(@"point2");
            } else if (i == 700){
                NSLog(@"point3");
            }
        }
        NSLog(@"barrier");
    });
    NSLog(@"aaa");
    dispatch_async(queue, ^{
        NSLog(@"Test4");
    });
    NSLog(@"bbb");
    dispatch_async(queue, ^{
        NSLog(@"Test5");
    });
    dispatch_async(queue, ^{
        NSLog(@"Test6");
    });
}

- (void)testSDWebimage {
    UIImageView *tempImageView = [[UIImageView alloc] init];
    tempImageView.frame = CGRectMake(0, 0, 300, 300);
    
    [tempImageView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
    
    [self.view addSubview:tempImageView];
    
    
    SDWebImageDownloader *downloader = [SDWebImageDownloader sharedDownloader];
    [downloader downloadImageWithURL:[NSURL URLWithString:@""] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
    } completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
        
    }];
}

@end
