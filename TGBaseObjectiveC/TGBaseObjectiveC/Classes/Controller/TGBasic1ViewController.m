//
//  TGBasic1ViewController.m
//  TGBaseObjectiveC
//
//  Created by 汤振治 on 04/02/2018.
//  Copyright © 2018 Centaline. All rights reserved.
//

#import "TGBasic1ViewController.h"

@interface TGBasic1ViewController ()

/** arrat */
@property (nonatomic, strong) NSMutableArray *tempArray;

@end

@implementation TGBasic1ViewController

- (void)dealloc {
    NSLog(@"TGBasic1ViewController delloc");
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    NSMutableArray *array = [NSMutableArray array];
    NSMutableArray *array = self.tempArray.mutableCopy;
    [array addObject:@"rrr"];
    self.tempArray = array;
    
    NSLog(@"self. temparray %@", self.tempArray);
    
}

- (NSMutableArray *)tempArray {
    if (!_tempArray) {
        _tempArray = [NSMutableArray array];
        _tempArray = @[@"w33", @"ddd", @"sss"].mutableCopy;
    }
    return _tempArray;
}


@end
