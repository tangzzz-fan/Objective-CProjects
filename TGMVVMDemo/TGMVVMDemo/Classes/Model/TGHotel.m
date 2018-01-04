//
//  TGHotel.m
//  TGMVVMDemo
//
//  Created by 汤振治 on 04/01/2018.
//  Copyright © 2018 Centaline. All rights reserved.
//

#import "TGHotel.h"

@implementation TGHotel
// 属性映射
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"poiAttrTagList" : @"poiAttrTagList",
             @"lowestPrice" : @"lowestPrice",
             @"scoreIntro" : @"scoreIntro",
             @"avgScore" : @"avgScore",
             @"lng" : @"lng",
             @"lat" : @"lat",
             @"positionDescription" : @"posdescr",
             @"frontImageURL" : @"frontImg",
             @"name" : @"name",
             @"saleTag" : @"poiSaleAndSpanTag",
             @"lastOrderTime" : @"poiLastOrderTime"};
}

+ (NSValueTransformer *)frontImageURLJSONTransformer {
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}
@end
