//
//  TestTableViewCell.h
//  TGJavaScriptOC
//
//  Created by MacPro on 2018/1/3.
//  Copyright © 2018年 Imitations. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

typedef void(^Block_WebCellChangeHeight)(float);

@interface TestTableViewCell : UITableViewCell<WKNavigationDelegate, WKUIDelegate, WKNavigationDelegate>

@property (weak, nonatomic) IBOutlet UILabel *TestLabel;

@property (copy, nonatomic) Block_WebCellChangeHeight Block_WebCellChangeHeight;

@property (strong, nonatomic)  WKWebView                 *webView;
@property (strong, nonatomic) UIScrollView                  *scrollView;
@property (assign, nonatomic) float                      webHeight;

- (void)setModel:(NSString *)model;
@end
