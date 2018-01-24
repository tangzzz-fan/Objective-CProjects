//
//  TGDemo5ViewController.m
//  TGMVVMDemo
//
//  Created by MacPro on 2018/1/24.
//  Copyright © 2018年 Centaline. All rights reserved.
//

#import "TGDemo5ViewController.h"

#import "TGDemo5TableViewCell.h"

#import "TGDemo5CellViewModel.h"

@interface TGDemo5ViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) NSArray *viewModelArray;

@end

@implementation TGDemo5ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataWithChangedStr:@"test"];
    [self initTableView];
}

- (void)initTableView {
    [self.tableView registerNib:[UINib nibWithNibName:@"TGDemo5TableViewCell" bundle:nil] forCellReuseIdentifier:@"TGDemo5TableViewCell"];
    self.tableView.tableFooterView = [UIView new];
}

- (void)initDataWithChangedStr:(NSString *)changedStr {
    
    NSMutableArray *array = [NSMutableArray array];
    
    for (NSInteger i = 0; i < 5; i ++) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setObject:[NSString stringWithFormat:@"%@ -- %@", changedStr, @(i)] forKey:[NSString stringWithFormat:@"data-%zd", i]];
        TGDemo5CellViewModel *viewModel = [[TGDemo5CellViewModel alloc] initWithDict:dict];
        [array addObject:viewModel];
    }
    
    self.viewModelArray = array.copy;
}

// 点击更新数据源
- (IBAction)updateDataSource:(id)sender {
    [self initDataWithChangedStr:[NSString stringWithFormat:@"Update-%zd", arc4random() % 10]];
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TGDemo5TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TGDemo5TableViewCell" forIndexPath:indexPath];
    TGDemo5CellViewModel *cellViewModel = self.viewModelArray[indexPath.row];
    [cell bindWithViewModel:cellViewModel];
    return cell;
}




@end
