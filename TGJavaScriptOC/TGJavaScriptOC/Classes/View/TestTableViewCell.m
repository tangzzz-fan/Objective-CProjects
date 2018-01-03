//
//  TestTableViewCell.m
//  TGJavaScriptOC
//
//  Created by MacPro on 2018/1/3.
//  Copyright © 2018年 Imitations. All rights reserved.
//

#import "TestTableViewCell.h"

@implementation TestTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _webHeight = 0;
    [self webView];
    [self.contentView addSubview:self.scrollView];
}


- (WKWebView *)webView
{
    if (!_webView) {
        WKWebViewConfiguration *wkWebConfig = [[WKWebViewConfiguration alloc] init];
        WKUserContentController *wkUController = [[WKUserContentController alloc] init];
        wkWebConfig.userContentController = wkUController;
        // 自适应屏幕宽度js
        NSString *jSString = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
        WKUserScript *wkUserScript = [[WKUserScript alloc] initWithSource:jSString injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
        // 添加js调用
        [wkUController addUserScript:wkUserScript];
        
        self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 1) configuration:wkWebConfig];
        self.webView.backgroundColor = [UIColor clearColor];
        self.webView.opaque = NO;
        self.webView.userInteractionEnabled = NO;
        self.webView.scrollView.bounces = NO;
        self.webView.UIDelegate = self;
        self.webView.navigationDelegate = self;
        [self.webView sizeToFit];
        [self.webView.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
        NSURL *url = [NSURL URLWithString:@"https://www.baidu.com"];
        NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
        [self.webView loadRequest:urlRequest];
        
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 1)];
        [self.scrollView addSubview:self.webView];
    }
    return _webView;
}
#pragma mark - <设置数据>
- (void)setModel:(NSString *)model
{
    
    // 手动改变图片适配问题，拼接html代码后，再加载html代码
//    NSString *myStr = [NSString stringWithFormat:@"<head><style>img{max-width:%f !important;}</style></head>", self.frame.size.width -15];
//    NSString *str = [NSString stringWithFormat:@"%@%@",myStr, model];
//    [self.webView loadHTMLString:str baseURL:nil];
//    [self.webView loadRequest:[NSURLRequest  requestWithURL:[NSURL URLWithString:model]]];
}


#pragma mark - <WKNavigationDelegate>
//- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
//{
//    [webView evaluateJavaScript:@"document.body.scrollHeight" completionHandler:^(id _Nullable response, NSError * _Nullable error) {
//        // 获取webView的高度
//        CGFloat webViewHeight = [response floatValue];
//        // 设置自定义scrollView的frame
//        self.scrollView.frame = CGRectMake(0, 0, 375, 300);
//        self.webView.frame = CGRectMake(0, 0, 375, 300);
//
//        if (_webHeight != webViewHeight) {
//            if (_Block_WebCellChangeHeight) {
//                _Block_WebCellChangeHeight(webViewHeight);
//            }
//            _webHeight = webViewHeight;
//        }
//
//
//    }];
//}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"contentSize"]) {
        // 方法一
        UIScrollView *scrollView = (UIScrollView *)object;
        CGFloat webViewHeight = scrollView.contentSize.height;
        if (_webHeight != webViewHeight) {
            webViewHeight = 300;
            if (_Block_WebCellChangeHeight) {
                _Block_WebCellChangeHeight(webViewHeight);
                self.scrollView.frame = CGRectMake(0, 0, self.frame.size.width, webViewHeight);
                self.scrollView.contentSize = CGSizeMake(self.frame.size.width, webViewHeight);
                self.backgroundColor = [UIColor redColor];
            }
            _webHeight = webViewHeight;
        }

        
        /*
         // 方法二
         [_webView evaluateJavaScript:@"document.body.offsetHeight" completionHandler:^(id _Nullable result, NSError * _Nullable error) {
         CGFloat height = [result doubleValue] + 20;
         self.webViewHeight = height;
         self.webView.frame = CGRectMake(0, 0, self.view.frame.size.width, height);
         self.scrollView.frame = CGRectMake(0, 0, self.view.frame.size.width, height);
         self.scrollView.contentSize =CGSizeMake(self.view.frame.size.width, height);
         [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:3 inSection:0], nil] withRowAnimation:UITableViewRowAnimationNone];
         }];
         */
    }
}

@end
