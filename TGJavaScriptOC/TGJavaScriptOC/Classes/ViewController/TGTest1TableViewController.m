//
//  TGTest1TableViewController.m
//  TGJavaScriptOC
//
//  Created by 汤振治 on 14/01/2018.
//  Copyright © 2018 Imitations. All rights reserved.
//

#import "TGTest1TableViewController.h"
#import "TGTest1TableViewCell.h"

@interface TGTest1TableViewController ()

@end

@implementation TGTest1TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.rowHeight = 300;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

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
