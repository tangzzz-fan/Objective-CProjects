//
//  TGTestTableViewController.m
//  TGTestUI
//
//  Created by 汤振治 on 14/01/2018.
//  Copyright © 2018 Centaline. All rights reserved.
//

#import "TGTestTableViewController.h"

#import "TGTest1TableViewCell.h"

@interface TGTestTableViewController ()

@end

@implementation TGTestTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.rowHeight = 240;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TGTest1TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TGTest1TableViewCell" forIndexPath:indexPath];
    return cell;
}

@end
