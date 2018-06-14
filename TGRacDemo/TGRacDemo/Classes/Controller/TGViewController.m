//
//  TGViewController.m
//  TGRacDemo
//
//  Created by MacPro on 2017/12/27.
//  Copyright © 2017年 Centaline. All rights reserved.
//

#import "TGViewController.h"
#import "TGFlickrSearchViewController.h"

#import <ReactiveCocoa.h>

@interface TGViewController ()

@property (strong, nonatomic) UINavigationController *navigationController;


@end

@implementation TGViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    RACSignal *tempSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        return nil;
    }];
    
}

- (IBAction)flickrSearchAction:(id)sender {

}



/** 创建初始控制器 */
- (void)createInitialViewController {
   
}

@end
