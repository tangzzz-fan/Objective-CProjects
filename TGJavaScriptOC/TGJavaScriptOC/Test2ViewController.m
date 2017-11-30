//
//  Test2ViewController.m
//  TGJavaScriptOC
//
//  Created by 汤振治 on 2017/12/1.
//  Copyright © 2017年 Imitations. All rights reserved.
//

#import "Test2ViewController.h"
#import <WebKit/WebKit.h>

@interface Test2ViewController ()<WKScriptMessageHandler, WKNavigationDelegate, WKUIDelegate>
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
    
    self.webView.UIDelegate = self;
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

#pragma mark - WKUINavigationDelegate
// 页面加载
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    
}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation {
    
}

// 页面跳转
// 接收到服务器跳转请求之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation {
    
}
// 在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    decisionHandler(WKNavigationResponsePolicyAllow);
}
// 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    decisionHandler(WKNavigationActionPolicyAllow);
}
@end
