//
//  TGScenic.m
//  TGMVVMDemo
//
//  Created by 汤振治 on 04/01/2018.
//  Copyright © 2018 Centaline. All rights reserved.
//

#import "TGScenic.h"

@implementation TGScenic
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"campaignTag" : @"campaignTag",
             @"lowestPrice" : @"lowestPrice",
             @"lng" : @"lng",
             @"lat" : @"lat",
             @"cityID" : @"cityId",
             @"cityName" : @"cityName",
             @"areaName" : @"areaName",
             @"frontImgURL" : @"frontImg",
             @"solds" : @"solds",
             @"name" : @"name", };
}

+ (NSValueTransformer *)frontImgURLJSONTransformer {
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}
@end
