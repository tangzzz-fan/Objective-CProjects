//
//  UIImage+ImageExtension.m
//  TGBaseObjectiveC
//
//  Created by MacPro on 2017/12/10.
//  Copyright © 2017年 Centaline. All rights reserved.
//

#import "UIImage+ImageExtension.h"

#import <objc/message.h>

@implementation UIImage (ImageExtension)

/** load 方法:当一个类被加载到运行环境中时调用, 同时会检查这个 load 方法中引用的其他对象(如果有)是否也加载完毕, 如果没有, 会报错
 *  加载位于 main 函数之前;
 *  类自有的 load 方法和 分类中实现的 load 方法调用顺序: 先是类自有的, 然后是分类的; 父类中也重写了 load 方法, 则会先主动调用父类的 load 方法, 如果父类没有实现 load 则不会调用
 *  [注] 和 + initialize 方法不同, 如果子类中重写 initialize 方法, 则会主动调用父类的 + initialize 方法, 此时要在父类中判断是否是自己这个类对象
 *  验证: 可以通过 .m 文件的加载顺序验证
 */
+ (void)load {
    // 交换方法(关联方法)
    // 获取 imageWithImageName: 方法
    Method imageWithImageName = class_getClassMethod(self, @selector(imageWithImageName:));
    
    // 获取 imageNamed 方法
    Method imageNamed = class_getClassMethod(self, @selector(imageNamed:));
    
    // 获取方法实现
    method_getImplementation(imageNamed);
    
    method_exchangeImplementations(imageWithImageName, imageNamed);
    
}

/** 此处不能再次调用 imageNamed: 方法, 会引起循环调用 */
+ (instancetype)imageWithImageName:(NSString *)name {
    // 图片能加载的原因, 在这个地方, load 之后, 已经交换了方法实现, 调用了 imageNamed: 方法
    UIImage *image = [self imageWithImageName:name];
    if (!image) {
        NSLog(@"加载空的图片");
    }
    return image;
}
@end
