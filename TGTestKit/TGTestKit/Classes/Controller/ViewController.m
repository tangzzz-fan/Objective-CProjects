//
//  ViewController.m
//  TGTestKit
//
//  Created by MacPro on 2017/12/21.
//  Copyright © 2017年 Centaline. All rights reserved.
//

#import "ViewController.h"

#import "CascadingTableDelegate.h"

#import "DestinationHeaderSectionDelegate.h"

@interface ViewController ()
@property (strong, nonatomic) id<CascadingTableDelegate> parentDelegate;
@property (strong, nonatomic) NSMutableArray<id<CascadingTableDelegate>> *childDelegates;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createRootDelegates];
}

- (void)createRootDelegates {
    self.childDelegates = [NSMutableArray array];
    DestinationHeaderSectionDelegate *headerDelegate;
    
}


@end
