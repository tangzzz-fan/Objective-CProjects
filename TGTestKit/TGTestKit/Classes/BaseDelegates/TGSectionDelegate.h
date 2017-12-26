//
//  TGSectionDelegate.h
//  TGTestKit
//
//  Created by MacPro on 2017/12/25.
//  Copyright © 2017年 Centaline. All rights reserved.
//

#import "PropagatingDelegate.h"

typedef enum : NSUInteger {
    Rnone = 0,
    Rwhole,
    Rsection,
} ReloadMode;

@interface TGSectionDelegate : PropagatingDelegate
@property (assign, nonatomic) PropagationMode propagationMode;
@property (assign, nonatomic) ReloadMode reloadModeOnChildDelegatesChanged;
@property (strong, nonatomic) UITableView *currentTableView;


@end
