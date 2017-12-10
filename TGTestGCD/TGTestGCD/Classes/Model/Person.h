//
//  Person.h
//  TGTestGCD
//
//  Created by 汤振治 on 2017/12/9.
//  Copyright © 2017年 Centaline. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Language.h"

@interface Person : NSObject
/** 使用的语言 */
@property (nonatomic, strong)  Language *language;
@end
