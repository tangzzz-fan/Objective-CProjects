//
//  Test2ViewController.m
//  TGJavaScriptOC
//
//  Created by 汤振治 on 2017/12/1.
//  Copyright © 2017年 Imitations. All rights reserved.
//

#import "Test2ViewController.h"
#import <WebKit/WebKit.h>

@interface Test2ViewController ()<WKScriptMessageHandler, WKNavigationDelegate>
/** webView */
@property (strong, nonatomic) WKWebView *webView;
@end

@implementation Test2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     
    [self initWebView];
    
}
     
- (void)initWebView {
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    config.userContentController = [[WKUserContentController alloc] init];
    
    [config.userContentController addScriptMessageHandler:self name:@"test1"];
    [config.userContentController addScriptMessageHandler:self name:@"test2"];

    WKPreferences *preferences = [WKPreferences new];
    preferences.javaScriptCanOpenWindowsAutomatically = YES;
    preferences.minimumFontSize = 40.0;
    config.preferences = preferences;
  
    self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64) configuration:config];
    [self.view addSubview:self.webView];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"test2.html" ofType:nil];
    NSURL *fileURL = [NSURL fileURLWithPath:filePath];
    [self.webView loadRequest:[NSURLRequest requestWithURL:fileURL]];
    
//    self.webView.UIDelegate = self;
//    self.webView.navigationDelegate = self;
    
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    NSLog(@"asdasd");
    NSLog(@"name:%@ body:%@", message.name, message.body);
    if ([message.name isEqualToString:@"test1"]) {
        NSLog(@"Add NavigationBar");
        
        [self test1];
        
    } else if ([message.name isEqualToString:@"test2"]) {
        NSLog(@"remove NavigationBar");
        [self test2];
    }

}

- (void)test1 {
    NSLog(@"test1");
}

- (void)test2 {
    NSLog(@"test2");
}

@end
