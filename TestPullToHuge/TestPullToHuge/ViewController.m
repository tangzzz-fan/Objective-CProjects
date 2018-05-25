//
//  ViewController.m
//  TestPullToHuge
//
//  Created by MacPro on 2018/3/15.
//  Copyright © 2018年 Centaline. All rights reserved.
//

#import "ViewController.h"
#import "UIView+ZFCategory.h"
#import "TestTableViewCell.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTableView];
}

- (void)initTableView {
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.tableView registerNib:[UINib nibWithNibName:@"TestTableViewCell" bundle:nil] forCellReuseIdentifier:@"TestTableViewCell"];
    self.tableView.contentInset = UIEdgeInsetsMake(150, 0, 0, 0);
    self.tableView.estimatedRowHeight = 300;
    self.heightConstraints.constant = 214;

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section) {
        return 80;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section==1) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
        view.backgroundColor = [UIColor purpleColor];
        return view;
    }
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        TestTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TestTableViewCell" forIndexPath:indexPath];
        cell.testLabel.text = [NSString stringWithFormat:@"test--0 --%zd", indexPath.row];
        return cell;
    } else {
        TestTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TestTableViewCell" forIndexPath:indexPath];
        cell.testLabel.text = [NSString stringWithFormat:@"test--1 --%zd", indexPath.row];
        return cell;
    }
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.mj_offsetY;
    
    if (offsetY > 0) {
        self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        self.heightConstraints.constant = 0;
    } else if (offsetY < 0) {
        self.tableView.contentInset = UIEdgeInsetsMake(150, 0, 0, 0);
        self.heightConstraints.constant = -offsetY+64;
    }
    
}


@end
