//
//  ViewController.m
//  TGCacheDemo
//
//  Created by MacPro on 2017/11/29.
//  Copyright © 2017年 Centaline. All rights reserved.
//

#import "ViewController.h"

#import "YTKNetwork.h"

#import "UIImageView+WebCache.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
    [imageV sd_setImageWithURL:[NSURL URLWithString:@""]];
    [self.view addSubview:imageV];
    
}
- (IBAction)touchAction:(id)sender {
    ZFIndexDefaultRecEstatesApi *api = [[ZFIndexDefaultRecEstatesApi alloc] init];
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSLog(@"responseObject %@", request.responseJSONObject);
        
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSLog(@"request error %@", request.error);
    }];
}


@end
