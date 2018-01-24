//
//  TGDemo4ViewController.m
//  TGMVVMDemo
//
//  Created by MacPro on 2018/1/23.
//  Copyright © 2018年 Centaline. All rights reserved.
//

#import "TGDemo4ViewController.h"

#import <ReactiveCocoa.h>

@interface TGDemo4ViewController ()
@property (strong, nonatomic) NSString *test1;
@property (strong, nonatomic) NSString *test2;


@end

@implementation TGDemo4ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self testChanged];
    
}

- (void)testChanged {
    self.test1 = @"test1";
    RACChannelTo(self, test1) = RACChannelTo(self, test2);
    
}

- (void)testArray {
    NSArray *array = @[@"rrr", @"sss", @"ttt", @"aaa", @"ccc",@"zzz"];
    RACSignal *tempAignal = [[[array.rac_sequence.signal map:^id(NSString *string) {
        return @{string:string};
    }] collect] map:^id(id value) {
        NSLog(@"uuuu %@ -- %@", [value class], value);
        return value;
    }];
    
    RACSignal *signal = [RACSignal return:array];
    [signal subscribeNext:^(id x) {
        NSLog(@"x %@ -- %@", [x class], x);
    }];
    
    [tempAignal subscribeNext:^(id x) {
        NSLog(@"sssss %@ -- %@", [x class], x);
    }];
}

- (void)testCollectSignalCombineLatestOrZip {
    //1
    RACSignal *numbers = @[@(0), @(1), @(2)].rac_sequence.signal;
    
    RACSignal *letters1 = @[@"A", @"B", @"C"].rac_sequence.signal;
    RACSignal *letters2 = @[@"X", @"Y", @"Z"].rac_sequence.signal;
    RACSignal *letters3 = @[@"M", @"N"].rac_sequence.signal;
    NSArray *arrayOfSignal = @[letters1, letters2, letters3]; //2
    
    
    [[[[numbers
        map:^id(NSNumber *n) {
            //3
            return arrayOfSignal[n.integerValue];
        }]
       collect]
      flattenMap:^RACStream *(NSArray *arrayOfSignal) {
          return [RACSignal combineLatest:arrayOfSignal reduce:^(NSString *first, NSString *second, NSString *third){
              return [NSString stringWithFormat:@"%@-%@-%@", first, second, third];
          }];
      }] subscribeNext:^(NSString *x) {
          NSLog(@"%@, -- %@", [self class], x);
      } completed:^{
          NSLog(@"Completed");
      }];
     
}

@end
