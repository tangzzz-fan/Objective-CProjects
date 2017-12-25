//
//  DestinationHeaderSectionDelegate.h
//  TGTestKit
//
//  Created by MacPro on 2017/12/22.
//  Copyright © 2017年 Centaline. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CascadingTableDelegate.h"

#import "DestinationHeaderSectionViewModel.h"

@interface DestinationHeaderSectionDelegate : NSObject
// 行号
//@property (assign, nonatomic, setter=setRow:) NSInteger row;

@property (strong, nonatomic) NSMutableDictionary *rowDict;

@property (assign, nonatomic) NSInteger index;

@property (strong, nonatomic) NSArray<id<CascadingTableDelegate>> *childDelegates;
@property (weak, nonatomic) id<CascadingTableDelegate> parentDelegate;
@property (strong, nonatomic) id<DestinationHeaderSectionViewModel> viewModel;

@property (strong, nonatomic) UITableView *currentTableView;




@end
