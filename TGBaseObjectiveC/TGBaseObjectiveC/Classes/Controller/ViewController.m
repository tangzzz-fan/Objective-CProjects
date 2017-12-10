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
#import "Status.h"

#import "NSObject+Extension.h"

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
//    Person *person = [[Person alloc] init];
//    [person working];
}

/** 动态添加方法
 *  实质: 向一个对象发送一个不能识别的方法时, 通过拦截消息转发中的几个阶段, 实现不同的目的
 *  消息转发的三个阶段:
    0 消息解析(msgSend)
    1 动态方法处理: 询问对象是否能够处理接受到的实例方法, 类方法
    2 备援接收者处理(找能处理消息的对象 forwardTarget, 找其他对象 forwordInvocation)
    3 实质消息转发阶段:
 
 *  需求: 向对象发送一个没有实现的方法
 */
- (IBAction)dymaticAddFunctionsAction:(id)sender {
//    Person *person = [[Person alloc] init];
//    [person performSelector:@selector(buy)];
//    [person performSelector:@selector(workhard:) withObject:@(10000)];
}

/** 分类中添加属性
 *  设置关联对象的属性, 将要添加的属性添加到关联对象中
 *  UIView+Extension 中的方法使用:
 *  在类的分类中声明属性的 set get 方法, 本质并不是真的生成成员变量(属性) 而是 提供 get set 方法 供外界调用(伴随着在分类中的属性声明)
 */
- (IBAction)addPropertyInCatrgoryAction:(id)sender {
//    Student *stu = [[Student alloc] init];
//    stu.name = @"a default name";
//    NSLog(@"name, %@", stu.name);
    
}

/** 根据字典自动生成属性声明描述符 */
- (IBAction)autoGeneratePropertyDisAction:(id)sender {
    // 加载 plist
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"status.plist" ofType:nil];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:filePath];
    NSArray *dictArr = dict[@"statuses"];
    
    // 根据字典关键字 创建对应的属性声明
    [NSObject createPropertyDisWithDict:dictArr[0][@"user"]];
    
    
}

/** 使用 KVC 字典转模型 从字典中找到对应的 key, 然后生成对应的属性 容易生成多余的属性声明*/
- (IBAction)dictToModelInKVCAction:(id)sender {
//    // 加载 plist
//    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"status.plist" ofType:nil];
//    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:filePath];
//    NSArray *dictArr = dict[@"statuses"];
//
//    NSMutableArray *statusArray = [NSMutableArray array];
//    // KVC 转换
//    for (NSDictionary *dict  in dictArr) {
//        Status *status = [Status statusWithDict:dict];
//        [statusArray addObject:status];
//    }
//
//    NSLog(@"statusArray: %@", statusArray);
}

/** 一阶字典转模型 */
- (IBAction)dictToModelRunTimeAction1:(id)sender {
    // 加载 plist
//    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"status.plist" ofType:nil];
//    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:filePath];
//    NSArray *dictArr = dict[@"statuses"];
//
//    NSMutableArray *statusArray = [NSMutableArray array];
//    // KVC 转换
//    for (NSDictionary *dict  in dictArr) {
//        Status *status = [Status modelWithDict:dict];
//        [statusArray addObject:status];
//    }
//
//    NSLog(@"statusArray: %@", statusArray);
    
}

/** 二阶字典转模型 */
- (IBAction)dictToModelRuntimeActione2:(id)sender {
    // 加载 plist
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"status.plist" ofType:nil];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:filePath];
    NSArray *dictArr = dict[@"statuses"];
    
    NSMutableArray *statusArray = [NSMutableArray array];
    // KVC 转换
    for (NSDictionary *dict  in dictArr) {
        Status *status = [Status modelWithDict:dict];
        [statusArray addObject:status];
    }
    
    NSLog(@"statusArray: %@", statusArray);
}

/** class super class */
- (IBAction)differenceBetweenSuperAction:(id)sender {
    Person *p = [[Person alloc] init];
    [p test];
    [Person test];
    
    Student *stu = [[Student alloc] init];
    [stu test];
    [Student test];
    
}


@end
