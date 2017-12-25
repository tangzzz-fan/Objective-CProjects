//
//  TGRootDelegate.h
//  TGTestKit
//
//  Created by MacPro on 2017/12/25.
//  Copyright © 2017年 Centaline. All rights reserved.
//

#import "PropagatingDelegate.h"

@interface TGRootDelegate : PropagatingDelegate
@property (assign, nonatomic) PropagationMode propagationMode;

@property (strong, nonatomic) UITableView *currentTableView;

@property (assign, nonatomic) BOOL reloadOnChildDelegateChanged;

@end
