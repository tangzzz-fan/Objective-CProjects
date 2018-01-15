//
//  ZFTestWK2TableViewController.m
//  TGJavaScriptOC
//
//  Created by MacPro on 2018/1/13.
//  Copyright © 2018年 Imitations. All rights reserved.
//

#import "ZFTestWK2TableViewController.h"

@interface ZFTestWK2TableViewController ()

@end

@implementation ZFTestWK2TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TGTest2TableViewCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor purpleColor];
    return cell;
}


@end
