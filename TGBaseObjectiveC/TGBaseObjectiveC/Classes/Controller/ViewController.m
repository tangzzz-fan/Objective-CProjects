//
//  ViewController.m
//  TGBaseObjectiveC
//
//  Created by MacPro on 2017/12/10.
//  Copyright © 2017年 Centaline. All rights reserved.
//

#import "ViewController.h"

#import "Person.h"
#import "Student.h"

#import <objc/message.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
#pragma mark - Actions
/** 消息转发 */
- (IBAction)msgSendAction:(id)sender {
    /**
     * 主要依托
     * msgSend()
     * performSelector 的三个方法
     */
    
//    Class pClass = [Person class];
//
//    Person *person = [[Person alloc] init];
//
//    Student *student = [[Student alloc] init];
//    [student read:@"Change"];
    
    /** 调用类方法:
     *  在类对象的类元对象中保存的方法名列表中中找到对应方法的 imp, 然后再根据 imp 找到对应的函数实现
     */
//    [Person eat];
    
//    objc_msgSend(pClass, @selector(eat));

//    [Person performSelector:@selector(eat)];
//    [Person performSelector:@selector(read:) withObject:@"Programming"];
    
    
    /** 调用实例方法:
     :  调用实例方法, 在类对象中保存的方法名列表中找到对应方法的 imp, 根据 imp 找到对应的函数实现
     */
//    [person eat];
//
//    objc_msgSend(person, @selector(eat));
//
//    [person performSelector:@selector(eat)];
//    [person performSelector:@selector(read:) withObject:@"Programming"];

    /** 使用系统提供的 performSelector 提供的方法, 传递的参数有限, 对于多参数, 和有返回值的函数的使用有一定的限制 */
    
    
}

/** 方法交换
 *  方法交换实质: 在类被加载时, 动态更改方法的实现 (可以认为是更改了方法指针的指向)
 *  一般这个操作在 + load 方法中实现(main 函数之前)
 *  方法交换: 如果之前对应有方法实现, 交换的方法其实也是会被调用, 可以认为有方法实现的交换方法是追加的,
 *  如果交换的方法之前就没有实现, 则交换就是执行后增加的方法
 *  需求: 每次加载图片(imageNamed:) 方法被调用时, 就返回图片是否加载成功
 */
- (IBAction)functionExchangeAction:(id)sender {
//    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"test"]];
//    UIImageView *imageView1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"test1"]];
//
//    [imageView setFrame:CGRectMake(0, 0, 300, 300)];
//    imageView.backgroundColor = [UIColor greenColor];
//
//    [imageView1 setFrame:CGRectMake(0, 300, 300, 300)];
//    imageView1.backgroundColor = [UIColor redColor];
//    [self.view addSubview:imageView1];
//    [self.view addSubview:imageView];
    
//    [Person running];
    Person *person = [[Person alloc] init];
    [person working];
}
- (IBAction)dymaticAddFunctionsAction:(id)sender {
}
- (IBAction)addPropertyInCatrgoryAction:(id)sender {
}
- (IBAction)autoGeneratePropertyDisAction:(id)sender {
}
- (IBAction)dictToModelInKVCAction:(id)sender {
}
- (IBAction)dictToModelRunTimeAction1:(id)sender {
}
- (IBAction)dictToModelRuntimeActione2:(id)sender {
}
- (IBAction)differenceBetweenSuperAction:(id)sender {
}


@end
