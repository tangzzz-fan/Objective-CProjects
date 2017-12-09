//
//  Student.h
//  TGTestGCD
//
//  Created by 汤振治 on 2017/12/9.
//  Copyright © 2017年 Centaline. All rights reserved.
//

#import "Person.h"

@interface Student<ObjectType> : Person
/** language student 对象接受一个泛型 */
@property (nonatomic, strong) ObjectType programLanguage;

/** array */
@property (nonatomic, strong) NSArray *array;
@end
