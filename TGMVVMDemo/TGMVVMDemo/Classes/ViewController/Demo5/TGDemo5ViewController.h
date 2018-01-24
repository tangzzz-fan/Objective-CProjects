//
//  TGDemo5ViewController.h
//  TGMVVMDemo
//
//  Created by MacPro on 2018/1/24.
//  Copyright © 2018年 Centaline. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TGDemo5ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)updateDataSource:(id)sender;

@end
