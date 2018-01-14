//
//  TGTest1TableViewCell.m
//  TGJavaScriptOC
//
//  Created by 汤振治 on 14/01/2018.
//  Copyright © 2018 Imitations. All rights reserved.
//

#import "TGTest1TableViewCell.h"
#import <WebKit/WebKit.h>

@interface TGTest1TableViewCell()
/** webview */
@property (nonatomic, strong) WKWebView *webView;
@end

@implementation TGTest1TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.containerView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    [self.containerView addSubview:self.webView];
}

- (WKWebView *)webView {
    if (!_webView) {
        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, 375, 280)];
        _webView.backgroundColor = [UIColor redColor];
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"WKWebViewUsages.html" ofType:nil];
        NSURL *fileURL = [NSURL fileURLWithPath:filePath];
//        [_webView loadRequest:[NSURLRequest requestWithURL:fileURL]];
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]]];
    }
    return _webView;
}

@end
