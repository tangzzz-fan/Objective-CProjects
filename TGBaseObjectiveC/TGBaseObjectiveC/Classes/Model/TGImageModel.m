//
//  TGImageModel.m
//  TGBaseObjectiveC
//
//  Created by MacPro on 2017/12/11.
//  Copyright © 2017年 Centaline. All rights reserved.
//

#import "TGImageModel.h"
@interface TGImageModel()

@end

@implementation TGImageModel
- (instancetype)initWithImage:(NSString *)imageName Name:(NSString *)name {
    if (self = [super init]) {
        self.imageName = imageName;
        self.name = name;
    }
    return self;
}
@end
