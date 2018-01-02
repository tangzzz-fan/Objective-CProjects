//
//  TGBaseModel.h
//  TGMVVMDemo
//
//  Created by MacPro on 2018/1/2.
//  Copyright © 2018年 Centaline. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TGBaseModel : NSObject
- (instancetype)initWithName:(NSString *)name index:(NSInteger)index description:(NSString *)desc;

@property (strong, nonatomic) NSString *desc;

@end
