//
//  ViewController.m
//  TGTestUI
//
//  Created by MacPro on 2017/12/26.
//  Copyright © 2017年 Centaline. All rights reserved.
//

#import "ViewController.h"
#import "TGPageViewController.h"
#import "Person.h"

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

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
//    Person *person = [[Person alloc] init];
//
//    __weak Person *waekP = person;
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//
//        NSLog(@"weakP ----- %@",waekP);
//
//        // 此时在这里对 person 有强引用, 看对象是否被释放, 就是看对象的引用计数.
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            NSLog(@"person ----- %@",person);
//        });
//    });
//    NSLog(@"touchBegin----------End");
    
    Person *person = [[Person alloc] init];
    
    __weak Person *waekP = person;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        NSLog(@"person ----- %@",person);
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSLog(@"weakP ----- %@",waekP);
        });
    });
    NSLog(@"touchBegin----------End");
}
@end
