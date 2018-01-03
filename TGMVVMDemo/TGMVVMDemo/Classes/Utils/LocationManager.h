//
//  LocationManager.h
//  TGMVVMDemo
//
//  Created by MacPro on 2018/1/3.
//  Copyright © 2018年 Centaline. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocationManager : NSObject

@property (nonatomic) NSInteger lastLoaionCityID;
@property (nonatomic) NSString *lastLoaionCityName;

+ (instancetype)defaultLocationManager;
@end
