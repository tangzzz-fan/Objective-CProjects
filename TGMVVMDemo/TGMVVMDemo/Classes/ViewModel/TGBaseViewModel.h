//
//  TGBaseViewModel.h
//  TGMVVMDemo
//
//  Created by MacPro on 2018/1/2.
//  Copyright © 2018年 Centaline. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TGBaseModel;
@interface TGBaseViewModel : NSObject

@property (strong, nonatomic) NSMutableArray<TGBaseModel *> *modelArray;

- (instancetype)initWithName:(NSString *)name index:(NSInteger)index;

- (NSString *)headerTitle;

@end
