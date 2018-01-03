//
//  TGViewController.m
//  TGRacDemo
//
//  Created by MacPro on 2017/12/27.
//  Copyright © 2017年 Centaline. All rights reserved.
//

#import "TGViewController.h"
#import "TGFlickrSearchViewController.h"

@interface TGViewController ()

@property (strong, nonatomic) UINavigationController *navigationController;


@end

@implementation TGViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)flickrSearchAction:(id)sender {

}



/** 创建初始控制器 */
- (void)createInitialViewController {
    // 使用 navigationcontroller 创建 MVVM 需要使用的服务总线
    
    
    // 使用 服务总线初始化 总的 viewModel
}

@end
