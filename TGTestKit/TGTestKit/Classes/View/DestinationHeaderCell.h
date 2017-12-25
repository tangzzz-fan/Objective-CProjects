//
//  DestinationHeaderCell.h
//  TGTestKit
//
//  Created by MacPro on 2017/12/22.
//  Copyright © 2017年 Centaline. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DestinationHeaderCell : UITableViewCell
+ (CGFloat)preferedHeight;

- (void)configureWithDescription:(NSString *)description isRow:(BOOL)isRow;
@end
