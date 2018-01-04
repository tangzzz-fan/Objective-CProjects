//
//  TGHotel.h
//  TGMVVMDemo
//
//  Created by 汤振治 on 04/01/2018.
//  Copyright © 2018 Centaline. All rights reserved.
//  酒店的贫血实体

#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>

@interface TGHotel : MTLModel<MTLJSONSerializing>
@property (nonatomic) NSArray *poiAttrTagList;
@property (nonatomic) NSString *scoreIntro;
@property (nonatomic) double avgScore;
@property (nonatomic) double lowestPrice;
@property (nonatomic) double lng;
@property (nonatomic) double lat;
@property (nonatomic) NSString *lastOrderTime;
@property (nonatomic) NSString *saleTag;
@property (nonatomic) NSString *positionDescription;
@property (nonatomic) NSString *name;
@property (nonatomic) NSURL *frontImageURL;
@end
