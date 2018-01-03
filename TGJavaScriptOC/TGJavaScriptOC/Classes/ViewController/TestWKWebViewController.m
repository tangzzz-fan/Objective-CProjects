//
//  TestWKWebViewController.m
//  TGJavaScriptOC
//
//  Created by MacPro on 2018/1/3.
//  Copyright © 2018年 Imitations. All rights reserved.
//

#import "TestWKWebViewController.h"
#import "TestTableViewCell.h"

@interface TestWKWebViewController ()<UITableViewDelegate, UITableViewDataSource>


@end

@implementation TestWKWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 300;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TestTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TestTableViewCell" forIndexPath:indexPath];
    cell.TestLabel.text = [NSString stringWithFormat:@"test %zd", indexPath.row];
    return cell;
}

@end
