//
//  AppDelegate+TGLocation.m
//  TGTestResponder
//
//  Created by MacPro on 2018/1/12.
//  Copyright © 2018年 Centaline. All rights reserved.
//

#import "AppDelegate+TGLocation.h"

@interface AppDelegate()<CLLocationManagerDelegate>

@end

@implementation AppDelegate (TGLocation)

- (void)setupLocationManager {
    
    if ([CLLocationManager locationServicesEnabled]) {
        
        CLLocationManager *manager = [[CLLocationManager alloc] init];
        
        self.manager = manager;
        
        manager.delegate = self;
        
        if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0 && [UIDevice currentDevice].systemVersion.floatValue < 9.0) {
            [manager requestAlwaysAuthorization];
        } else if ([UIDevice currentDevice].systemVersion.floatValue >= 9.0) {
            [manager requestLocation];
        }
        
        manager.distanceFilter = 100;
        
        [manager setDistanceFilter:kCLLocationAccuracyBest];
        
        [manager startUpdatingLocation];
        
    }
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    CLLocation *loc = locations[0];
    NSString *locStr = [NSString stringWithFormat:@"经度%f  纬度%f 速度 %.1f",loc.coordinate.longitude,loc.coordinate.latitude,loc.speed];
    NSLog(@"location update %@", locStr);
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"locaiton with error %@", error);
}

/** 定位服务状态改变时调用*/
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
        {
            NSLog(@"用户还未决定授权");
            [manager requestWhenInUseAuthorization];
            break;
        }
        case kCLAuthorizationStatusRestricted:
        {
            NSLog(@"访问受限");
            break;
        }
        case kCLAuthorizationStatusDenied:
        {
            // 类方法，判断是否开启定位服务
            if ([CLLocationManager locationServicesEnabled]) {
                NSLog(@"定位服务开启，被拒绝");
            } else {
                NSLog(@"定位服务关闭，不可用");
            }
            break;
        }
        case kCLAuthorizationStatusAuthorizedAlways:
        {
            NSLog(@"获得前后台授权");
            break;
        }
        case kCLAuthorizationStatusAuthorizedWhenInUse:
        {
            NSLog(@"获得前台授权");
            break;
        }
        default:
            break;
    }
}



#pragma mark - Delegate



@end
