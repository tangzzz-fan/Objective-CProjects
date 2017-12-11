//
//  TGImageModel.h
//  TGBaseObjectiveC
//
//  Created by MacPro on 2017/12/11.
//  Copyright © 2017年 Centaline. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TGImageModel : NSObject

@property (strong, nonatomic) NSString *imageName;
@property (strong, nonatomic) NSString *name;


- (instancetype)initWithImage:(NSString *)imageName Name:(NSString *)name;

@end
