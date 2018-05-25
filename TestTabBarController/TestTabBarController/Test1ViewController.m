//
//  Test1ViewController.m
//  TestTabBarController
//
//  Created by MacPro on 2018/4/4.
//  Copyright © 2018年 Centaline. All rights reserved.
//

#import "Test1ViewController.h"
#import "Test2ViewController.h"

@interface Test1ViewController ()

@end

@implementation Test1ViewController
- (IBAction)jumptotabbarAction:(id)sender {
    Test2ViewController *testVC2 = [[Test2ViewController alloc] init];
    testVC2.view.backgroundColor = [UIColor redColor];
    testVC2.title = @"sssss";
    UITabBarController *tabBarVC = [[UITabBarController alloc] init];
    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:testVC2];
    [tabBarVC addChildViewController:nav1];
    
    Test2ViewController *testVC3 = [[Test2ViewController alloc] init];
    testVC3.view.backgroundColor = [UIColor greenColor];
    testVC3.title = @"aaaa";
    UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:testVC3];
    [tabBarVC addChildViewController:nav2];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:tabBarVC animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
