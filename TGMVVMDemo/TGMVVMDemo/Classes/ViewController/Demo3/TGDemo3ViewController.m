//
//  TGDemo3ViewController.m
//  TGMVVMDemo
//
//  Created by 汤振治 on 22/01/2018.
//  Copyright © 2018 Centaline. All rights reserved.
//

#import "TGDemo3ViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
@interface TGDemo3ViewController ()
/** shuzu */
@property (nonatomic, strong) NSArray *testArray;
/** test */
@property (nonatomic, strong) NSArray *uuuArray;
@end

@implementation TGDemo3ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.testArray = @[@"test", @"sdads", @"eeee"];
    self.uuuArray = @[@"ddd", @"ffff", @"11111"];
    RAC(self, testArray) = RACObserve(self, uuuArray);
    
    [self createUI];
    
}

- (void)createUI {
    // 如果testarray 数目不为 0 就根据数据源创建标签
    if (self.testArray.count > 0) {
        for (NSInteger i = 0; i < self.testArray.count; i ++) {
            NSString *title = self.testArray[i];
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10 + 100 * i, 100, 80, 40)];
            label.text = title;
            label.backgroundColor = [UIColor redColor];
            [self.view addSubview:label];
        }
    }
}
@end
