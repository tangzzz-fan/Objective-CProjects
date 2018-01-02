//
//  ViewController.m
//  TGMVVMDemo
//
//  Created by MacPro on 2018/1/2.
//  Copyright © 2018年 Centaline. All rights reserved.
//

#import "ViewController.h"

#import "TGTest1ViewModel.h"
#import "TGTest2ViewModel.h"
#import "TGTest3ViewModel.h"
#import "TGTest4ViewModel.h"
#import "TGBaseModel.h"

#import "TGTest1TableViewCell.h"
#import "TGTest2TableViewCell.h"
#import "TGTest3TableViewCell.h"
#import "TGTest4TableViewCell.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) NSMutableArray<__kindof TGBaseViewModel *> *viewModelArray;
@property (strong, nonatomic) NSDictionary *mapDict;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.viewModelArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModelArray[section].modelArray.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.viewModelArray[section].headerTitle;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TGBaseViewModel *viewModel = self.viewModelArray[indexPath.section];
    
    NSString *classString = self.mapDict[NSStringFromClass([viewModel class])];

//    NSLog(@"viewModel class %@, tableViewCell %@", [viewModel class], classString);
    
    Class class = NSClassFromString(classString);
    
    TGBaseTableViewCell *cell = [[class alloc] init];
    
    NSInteger indexRow = indexPath.row;
    
    NSDictionary *dict = @{@"DataIndexPath":@(indexRow)};
    
    NSLog(@"dict %@", dict);
    
    cell = [tableView dequeueReusableCellWithIdentifier:classString forIndexPath:indexPath];
    
    [cell bindViewModel:viewModel withParams:dict];
    
    return cell;
}

- (__kindof TGBaseTableViewCell *)creatCellWithTableView:(UITableView *)tableView cellString:(NSString *)classString IndexPath:(NSIndexPath *)indexPath{
//    Class cls = NSClassFromString(classString);
    
    return  [tableView dequeueReusableCellWithIdentifier:classString forIndexPath:indexPath];
;
}

#pragma mark - DataSource


#pragma mark - Setter && Getter
- (NSMutableArray<TGBaseViewModel *> *)viewModelArray {
    if (!_viewModelArray) {
        _viewModelArray = [[NSMutableArray alloc] init];
        TGTest1ViewModel *test1VM = [[TGTest1ViewModel alloc] initWithName:@"Test1" index:1];
        TGTest2ViewModel *test2VM = [[TGTest2ViewModel alloc] initWithName:@"Test2" index:2];
        TGTest3ViewModel *test3VM = [[TGTest3ViewModel alloc] initWithName:@"Test3" index:3];
        TGTest4ViewModel *test4VM = [[TGTest4ViewModel alloc] initWithName:@"Test4" index:4];

        [_viewModelArray addObject:test1VM];
        [_viewModelArray addObject:test2VM];
        [_viewModelArray addObject:test3VM];
        [_viewModelArray addObject:test4VM];

    }
    return _viewModelArray;
}

- (NSDictionary *)mapDict {
    return @{
             @"TGTest1ViewModel":@"TGTest1TableViewCell",
             @"TGTest2ViewModel":@"TGTest2TableViewCell",
             @"TGTest3ViewModel":@"TGTest3TableViewCell",
             @"TGTest4ViewModel":@"TGTest4TableViewCell"
             };
}
@end
