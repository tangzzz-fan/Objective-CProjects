//
//  WeakScriptMessageDelegate.h
//  TGJavaScriptOC
//
//  Created by 汤振治 on 2017/12/2.
//  Copyright © 2017年 Imitations. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>

@interface WeakScriptMessageDelegate : NSObject<WKScriptMessageHandler>
/** delegate */
@property (weak, nonatomic) id<WKScriptMessageHandler> weakScriptDelegate;
- (instancetype)initWithDelegate:(id<WKScriptMessageHandler>)scriptDelegate;

@end
