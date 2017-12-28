//
//  ViewController.m
//  TGTestUI
//
//  Created by MacPro on 2017/12/26.
//  Copyright © 2017年 Centaline. All rights reserved.
//

#import "ViewController.h"
#import "TGPageViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (IBAction)showPageViewControllerAction:(id)sender {
    TGPageViewController *tgVc = [[TGPageViewController alloc] init];
    [self.navigationController pushViewController:tgVc animated:YES];
}


@end
