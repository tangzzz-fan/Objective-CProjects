//
//  TGPageViewController.m
//  TGTestUI
//
//  Created by MacPro on 2017/12/28.
//  Copyright © 2017年 Centaline. All rights reserved.
//

#import "TGPageViewController.h"

#import "TGStyle.h"

#import "TGTitleView.h"

@interface TGPageViewController ()

@end

@implementation TGPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGRect titleFrame = CGRectMake(0, 100, self.view.frame.size.width, 44);
    NSArray *titlesArray = @[@"test1", @"test1", @"test1", @"test1", @"test1", @"test1", @"test1", @"test1", @"test1", @"test1", @"test1", @"test1", @"test1", @"test1", @"test1", @"test1"];
    
    TGStyle *tgStyle = [[TGStyle alloc] init];
    
    tgStyle.isScrollAble = YES;
    tgStyle.isScrollToMiddle = YES;
    tgStyle.titleMarign = 10;
    tgStyle.titleFont = [UIFont systemFontOfSize:18.0f];
    tgStyle.isShowBottomLine = YES;
    tgStyle.bottomLineHeight = 4;
    tgStyle.bottomLineBackgroundColor = [UIColor orangeColor];
    tgStyle.isShowCoverView = YES;
    tgStyle.coverMargin = 16;
    tgStyle.coverHeight = 30;
    tgStyle.coverViewAlpha = 0.2;
    tgStyle.coverViewBackgroundColor = [UIColor purpleColor];
    
    TGTitleView *titleView = [[TGTitleView alloc] initWithFrame:titleFrame Titles:titlesArray TGStyle:tgStyle];
    [self.view addSubview:titleView];
}

@end
