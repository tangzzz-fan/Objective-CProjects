//
//  EmptyCOntentView.m
//  TGTestKit
//
//  Created by MacPro on 2017/12/25.
//  Copyright © 2017年 Centaline. All rights reserved.
//

#import "EmptyCOntentView.h"

@implementation EmptyCOntentView

- (EmptyCOntentView *)nibView {
    UINib *nib = [[[NSBundle mainBundle] loadNibNamed:@"EmptyCOntentView" owner:nil options:nil] lastObject];
    return (EmptyCOntentView *)nib;
}

@end
