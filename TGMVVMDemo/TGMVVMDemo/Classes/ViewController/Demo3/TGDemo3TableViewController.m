//
//  TGDemo3TableViewController.m
//  TGMVVMDemo
//
//  Created by 汤振治 on 22/01/2018.
//  Copyright © 2018 Centaline. All rights reserved.
//

#import "TGDemo3TableViewController.h"

#import "TGDemo3TableViewCell.h"

#import "TGDemo3CellViewModel.h"

@interface TGDemo3TableViewController ()
/** dataSource */
@property (nonatomic, strong) NSArray *viewModelArray;
@end

@implementation TGDemo3TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTableView];
    [self initDataWithFingure:0];
}

- (void)initTableView {
    self.tableView.rowHeight = 105;
    [self.tableView registerNib:[UINib nibWithNibName:@"TGDemo3TableViewCell" bundle:nil] forCellReuseIdentifier:@"TGDemo3TableViewCell"];
}

- (void)initDataWithFingure:(NSInteger)data {
    NSMutableArray *tempArray = [NSMutableArray array];
    for (NSInteger i = 0; i < 20; i++) {
        TGDemo3CellViewModel *cellViewModel = [[TGDemo3CellViewModel alloc] init];
        
        NSMutableArray *tempDataSource = [NSMutableArray array];
        for (NSInteger j = 0; j <= i; j ++) {
            NSString *testString = [NSString stringWithFormat:@"%zd-%zd", data, j];
            [tempDataSource addObject:testString];
        }
        cellViewModel.dataSource = tempDataSource.mutableCopy;
        
        [tempArray addObject:cellViewModel];
    }
    self.viewModelArray = tempArray.mutableCopy;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TGDemo3TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TGDemo3TableViewCell" forIndexPath:indexPath];
    TGDemo3CellViewModel *viewModel = self.viewModelArray[indexPath.row];
    [cell bindViewModel:viewModel];
    cell.backgroundColor = [UIColor orangeColor];
    return cell;
}

- (IBAction)changeDataSourceAction:(id)sender {
    NSInteger temp = (arc4random() % 10);
    [self initDataWithFingure:temp];
    [self.tableView reloadData];
}
@end
