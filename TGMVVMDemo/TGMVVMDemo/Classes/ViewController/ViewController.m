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

#import "TGTestTableViewCell.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) NSMutableArray<__kindof TGBaseViewModel *> *viewModelArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TGTestTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.TestLabel.text = self.viewModelArray[indexPath.row].description;
    return cell;
}
#pragma mark - DataSource




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
@end
