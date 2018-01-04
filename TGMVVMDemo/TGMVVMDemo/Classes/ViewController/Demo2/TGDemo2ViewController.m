//
//  TGDemo2ViewController.m
//  TGMVVMDemo
//
//  Created by 汤振治 on 04/01/2018.
//  Copyright © 2018 Centaline. All rights reserved.
//

#import "TGDemo2ViewController.h"

#import <ReactiveCocoa.h>

#import "TGBaseCellViewModel.h"
#import "TGDemo2ViewModel.h"

#import "TGBaseTableViewCell.h"
#import "TGPOITableViewCell.h"

@interface TGDemo2ViewController ()
/** viewModel */
@property (nonatomic, strong) TGDemo2ViewModel *viewModel;
/** viewModels */
@property (nonatomic, strong) NSArray *cellViewModelArray;
@end

@implementation TGDemo2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _viewModel = [[TGDemo2ViewModel alloc] init];

    [self.tableView registerNib:[UINib nibWithNibName:@"TGPOITableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"TGPOITableViewCell"];
    
    self.refreshControl.rac_command = _viewModel.loadDataCommand;
    [self.refreshControl beginRefreshing];
    
    [self rac_liftSelector:@selector(refreshTableView:) withSignals:_viewModel.dataSignal, nil];
    [self rac_liftSelector:@selector(showError:) withSignals:_viewModel.errorSignal, nil];
    
    [_viewModel.loadDataCommand execute:nil];

}

- (void)bindViewModel {

}

- (void)initTableView {


}

- (void)refreshTableView:(NSArray *)cellViewModelArray {
    self.cellViewModelArray = cellViewModelArray;
    [self.tableView reloadData];
    [self.refreshControl endRefreshing];

}

- (void)showError:(NSError *)error {
    
    [self.refreshControl endRefreshing];
    self.cellViewModelArray = nil;
    [self.tableView reloadData];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:error.description preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction *_Nonnull action) {
    }]];
    
    [self presentViewController:alertController animated:YES completion:^{
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_cellViewModelArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TGBaseCellViewModel *cellViewModel = self.cellViewModelArray[indexPath.row];
    NSString *cellClassName = cellViewModel.cellName;
    TGBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellClassName];
    [cell bindViewModel:cellViewModel];
    return cell;
}

- (NSArray *)cellViewModelArray {
    if (!_cellViewModelArray) {
        _cellViewModelArray = [[NSArray alloc] init];
    }
    return _cellViewModelArray;
}

@end
