//
//  TestPro.h
//  TestProtocolKit
//
//  Created by MacPro on 2017/12/25.
//  Copyright © 2017年 Centaline. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PKProtocolExtension.h"

@protocol TestPro

@optional
- (void)test;
@end

@defs(TestPro)
- (void)test {
    NSLog(@"this is called in defs");
}
@end

