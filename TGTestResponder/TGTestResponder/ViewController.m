//
//  ViewController.m
//  TGTestResponder
//
//  Created by MacPro on 2017/12/12.
//  Copyright © 2017年 Centaline. All rights reserved.
//

#import "ViewController.h"

#import "TGButton.h"
#import "TGTagButton.h"

#import "UIButton+TGExtension.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initACustomButton];
}

- (void)initACustomButton {
    
    // 扩大点击区域
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    bgView.backgroundColor = [UIColor redColor];
    [self.view addSubview:bgView];
    
    TGButton *button = [[TGButton alloc] initWithFrame:CGRectMake(20, 20, 20, 20)];
    button.backgroundColor = [UIColor greenColor];
    [bgView addSubview:button];
    
    // 限定在圆角内部
    UIView *bgView1 = [[UIView alloc] initWithFrame:CGRectMake(100, 300, 100, 100)];
    bgView1.backgroundColor = [UIColor redColor];
    [self.view addSubview:bgView1];
    
    TGTagButton *button1 = [[TGTagButton alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    button1.backgroundColor = [UIColor greenColor];
    button1.clipsToBounds = YES;
    button1.layer.cornerRadius = 50;
    [button1 addTarget:self action:@selector(buttonAction1:) forControlEvents:UIControlEventTouchUpInside];
    [bgView1 addSubview:button1];
    
    // 运行时更改
    UIView *bgView2 = [[UIView alloc] initWithFrame:CGRectMake(100, 500, 100, 100)];
    bgView2.backgroundColor = [UIColor redColor];
    [self.view addSubview:bgView2];
    
    UIButton *button2 = [[UIButton alloc] initWithFrame:CGRectMake(20, 20, 20, 20)];
    button2.backgroundColor = [UIColor greenColor];
    button2.hitTestEdgeInsets = UIEdgeInsetsMake(-20, -20, -20, -20);
    [button2 addTarget:self action:@selector(buttonAction2:) forControlEvents:UIControlEventTouchUpInside];
    
    [bgView2 addSubview:button2];
}

- (void)buttonAction1:(UIButton *)sender {
    NSLog(@"圆形扩大点击区域");
}

- (void)buttonAction2:(UIButton *)sender {
    NSLog(@"Runtime扩大点击");
}


@end
