//
//  ViewController.m
//  TestArray
//
//  Created by MacPro on 2018/4/24.
//  Copyright © 2018年 Centaline. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSMutableArray *array = [[NSMutableArray alloc] init];
    array = @[@"23", @"asd", @"as:asd"].mutableCopy;
    NSMutableArray *arr = array.mutableCopy;
    array[0] = @"change";
    
    NSLog(@"array %@", array);
    NSLog(@"arr %@", arr);
    
}


@end
