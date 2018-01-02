//
//  TGTsetKVOController.m
//  TGBaseObjectiveC
//
//  Created by 汤振治 on 02/01/2018.
//  Copyright © 2018 Centaline. All rights reserved.
//

#import "TGTsetKVOController.h"

#import "NSObject+TGHook.h"

@interface TGTsetKVOController ()

@end

@implementation TGTsetKVOController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    
    TGTsetKVOController *vc = [[TGTsetKVOController alloc] init];
    [vc eat];
    
    NSLog(@"-------------");
    
    TGTsetKVOController *vcontroller = [[TGTsetKVOController alloc] init];
    
    [TGTsetKVOController hookWithInstance:vcontroller method:@selector(eat)];
    
    [vcontroller eat];
    
}

- (void)eat {
    NSLog(@"original eat");
}

@end
