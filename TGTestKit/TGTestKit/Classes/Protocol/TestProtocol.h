//
//  TestProtocol.h
//  TGTestKit
//
//  Created by MacPro on 2017/12/21.
//  Copyright © 2017年 Centaline. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import <EXTConcreteProtocol.h>
#import "PKProtocolExtension.h"

@protocol TestProtocol
@optional
- (void)changed;
@end

// 实现协议扩展
//@defs(TestProtocol)
//- (void)changed {
//    NSLog(@"Update");
//}
//@end

