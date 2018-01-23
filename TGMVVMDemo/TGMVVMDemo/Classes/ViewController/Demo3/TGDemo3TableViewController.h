//
//  TGDemo3TableViewController.h
//  TGMVVMDemo
//
//  Created by 汤振治 on 22/01/2018.
//  Copyright © 2018 Centaline. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TGDemo3TableViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)changeDataSourceAction:(id)sender;

@end
