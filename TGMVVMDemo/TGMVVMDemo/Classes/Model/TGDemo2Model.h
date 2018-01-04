//
//  TGDemo2Model.h
//  TGMVVMDemo
//
//  Created by 汤振治 on 04/01/2018.
//  Copyright © 2018 Centaline. All rights reserved.
//  该 Model 即作为数据层使用, 所谓的胖 Model
//  比如数据的网络获取会在这里实现

#import <Foundation/Foundation.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface TGDemo2Model : NSObject

// 获取旅行数据
- (RACSignal *)loadTravelData;
// 获取酒店数据
- (RACSignal *)loadHotelData;

@end
