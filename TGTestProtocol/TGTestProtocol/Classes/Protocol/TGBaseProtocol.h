//
//  TGBaseProtocol.h
//  TGTestProtocol
//
//  Created by MacPro on 2017/12/22.
//  Copyright © 2017年 Centaline. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TGBaseProtocol <NSObject>
@required
- (void)name;

@optional
- (void)changedName:(NSString *)name;
@end
