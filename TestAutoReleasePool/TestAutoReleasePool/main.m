//
//  main.m
//  TestAutoReleasePool
//
//  Created by MacPro on 2018/6/8.
//  Copyright © 2018年 Centaline. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}