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
    
    UIImageView *tempImageView = [[UIImageView alloc] init];
    tempImageView.frame = CGRectMake(0, 0, 300, 300);

    [tempImageView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
    
    [self.view addSubview:tempImageView];
}

@end
