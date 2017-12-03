//
//  WeakScriptMessageDelegate.m
//  TGJavaScriptOC
//
//  Created by 汤振治 on 2017/12/2.
//  Copyright © 2017年 Imitations. All rights reserved.
//

#import "WeakScriptMessageDelegate.h"

@implementation WeakScriptMessageDelegate
- (instancetype)initWithDelegate:(id<WKScriptMessageHandler>)scriptDelegate {
    if (self = [super init]) {
        _weakScriptDelegate = scriptDelegate;
    }
    return self;
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    [self.weakScriptDelegate userContentController:userContentController didReceiveScriptMessage:message];
}
@end
