//
//  TestWKWebViewController.m
//  TGJavaScriptOC
//
//  Created by MacPro on 2018/1/3.
//  Copyright © 2018年 Imitations. All rights reserved.
//

#import "TestWKWebViewController.h"
#import "TestTableViewCell.h"

#define WeakSelf(weakSelf)  __weak __typeof(self)weakSelf = self;

@interface TestWKWebViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (assign, nonatomic) CGFloat webHeight;
@property (nonatomic, strong) WKWebView *webView;


@end

@implementation TestWKWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)dealloc {
    [self.webView.scrollView removeObserver:self forKeyPath:@"contentSize"];
}

#pragma mark - Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return _webHeight;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TestTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TestTableViewCell" forIndexPath:indexPath];
    cell.TestLabel.text = [NSString stringWithFormat:@"test %zd", indexPath.row];
    
    WeakSelf(weakSelf);
    
    cell.Block_WebCellChangeHeight = ^(float height) {
        weakSelf.webHeight = height;
        weakSelf.webView.frame = CGRectMake(0, 0, self.view.frame.size.width, height);
        [weakSelf.tableView reloadData];
    };
    
    return cell;
}

@end
