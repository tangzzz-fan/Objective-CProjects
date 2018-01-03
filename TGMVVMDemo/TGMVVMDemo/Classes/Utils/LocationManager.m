//
//  LocationManager.m
//  TGMVVMDemo
//
//  Created by MacPro on 2018/1/3.
//  Copyright © 2018年 Centaline. All rights reserved.
//

#import "LocationManager.h"

@implementation LocationManager
+ (instancetype)defaultLocationManager {
    static LocationManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[LocationManager alloc] init];
        manager.lastLoaionCityID = 1;
        manager.lastLoaionCityName = @"北京";
    });
    return manager;
}
@end
