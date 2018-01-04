//
//  TGScenic.h
//  TGMVVMDemo
//
//  Created by 汤振治 on 04/01/2018.
//  Copyright © 2018 Centaline. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <Mantle/Mantle.h>

@interface TGScenic : MTLModel<MTLJSONSerializing>

@property (nonatomic) NSString *campaignTag;
@property (nonatomic) double lowestPrice;
@property (nonatomic) double lng;
@property (nonatomic) double lat;
@property (nonatomic) NSInteger cityID;
@property (nonatomic) NSString *cityName;
@property (nonatomic) NSString *areaName;
@property (nonatomic) NSURL *frontImgURL;
@property (nonatomic) NSInteger solds;
@property (nonatomic) NSString *name;

@end
