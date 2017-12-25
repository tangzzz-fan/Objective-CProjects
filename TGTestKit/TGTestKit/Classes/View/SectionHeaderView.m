//
//  SectionHeaderView.m
//  TGTestKit
//
//  Created by MacPro on 2017/12/25.
//  Copyright © 2017年 Centaline. All rights reserved.
//

#import "SectionHeaderView.h"

@implementation SectionHeaderView
- (CGFloat)preferedHeight {
    return 41;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.headerLabel.text = nil;
}

- (SectionHeaderView *)viewWithHeaderText:(NSString *)headerText {

    UINib *nib = [[[NSBundle mainBundle] loadNibNamed:@"SectionHeaderView" owner:nil options:nil] lastObject];
    
    if ([nib isKindOfClass:[SectionHeaderView class]]) {
        SectionHeaderView *headerView = (SectionHeaderView *)nib;
        [headerView configureWithHeadText:headerText];
        return headerView;
    }
    
    SectionHeaderView *headerView = [[SectionHeaderView alloc]init];
    [headerView configureWithHeadText:headerText];
    return headerView;
}

- (void)configureWithHeadText:(NSString *)text {
    self.headerLabel.text = text;
}

@end
