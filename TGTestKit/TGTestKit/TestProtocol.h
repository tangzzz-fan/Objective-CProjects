//
//  TestProtocol.h
//  TGTestKit
//
//  Created by MacPro on 2017/12/21.
//  Copyright © 2017年 Centaline. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PKProtocolExtension.h"


@protocol TestProtocol <NSObject>
@optional
- (void)changed;
@end

@defs(TestProtocol)
- (void)changed {
    NSLog(@"Update");
}
@end
