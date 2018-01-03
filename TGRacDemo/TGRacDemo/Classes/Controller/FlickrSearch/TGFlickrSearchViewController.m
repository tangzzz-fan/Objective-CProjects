//
//  TGFlickrSearchViewController.m
//  TGRacDemo
//
//  Created by MacPro on 2017/12/27.
//  Copyright © 2017年 Centaline. All rights reserved.
//

#import "TGFlickrSearchViewController.h"

#import "TGFlickrSearchCell.h"

@interface TGFlickrSearchViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation TGFlickrSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TGFlickrSearchCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TGFlickrSearchCell" forIndexPath:indexPath];
    return cell;
}

@end
