//
//  ViewController.m
//  TGTestProtocol
//
//  Created by MacPro on 2017/12/22.
//  Copyright © 2017年 Centaline. All rights reserved.
//

#import "ViewController.h"

#import "TGBaseObject.h"
#import "TGFirstObject.h"


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    TGBaseObject *object = [[TGBaseObject alloc] initWithIndex:1 ChildDelegates:nil TableView:self.tableView];
    
    [object objectName];
    
    TGFirstObject *firstObject = [[TGFirstObject alloc] initWithIndex:2 ChildDelegates:nil TableView:self.tableView];
    [firstObject customName];
    [firstObject objectName];
    
    
}


@end
