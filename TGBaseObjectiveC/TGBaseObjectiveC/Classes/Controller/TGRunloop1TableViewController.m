//
//  TGRunloop1TableViewController.m
//  TGBaseObjectiveC
//
//  Created by MacPro on 2017/12/11.
//  Copyright © 2017年 Centaline. All rights reserved.
//

#import "TGRunloop1TableViewController.h"

#import "TGImageModel.h"

#import "TGImageTableViewCell.h"

@interface TGRunloop1TableViewController ()
@property (strong, nonatomic) NSMutableArray *dataSources;

@end

@implementation TGRunloop1TableViewController

#pragma mark - LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    
    [self initTableView];
}

- (void)dealloc {
    NSLog(@"delloc");
}

- (void)initData {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        for (NSInteger i = 0; i < 200; i ++) {
            TGImageModel *imageModel = [[TGImageModel alloc] initWithImage:@"spaceship.jpg" Name:[NSString stringWithFormat:@"这是测试数据的第 %zd 条", i]];
            [self.dataSources addObject:imageModel];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    });
    
}

- (void)initTableView {
    self.tableView.rowHeight = 200;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSources.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TGImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TGImageTableViewCellID" forIndexPath:indexPath];
    cell.imageModel = self.dataSources[indexPath.row];
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"current mode: %@", [[NSRunLoop currentRunLoop] currentMode]);
}

#pragma mark - Setter && Getter
- (NSMutableArray *)dataSources {
    if (!_dataSources) {
        _dataSources = [NSMutableArray array];
    }
    return _dataSources;
}

@end
