//
//  TGTest1View.m
//  TGTestUI
//
//  Created by 汤振治 on 14/01/2018.
//  Copyright © 2018 Centaline. All rights reserved.
//

#import "TGTest1View.h"
@interface TGTest1View()
@property (strong, nonatomic) IBOutlet UIView *view;
@end
@implementation TGTest1View
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.view = [[[NSBundle mainBundle] loadNibNamed:@"TGTest1View" owner:nil options:nil] firstObject];
        [self addSubview:self.view];
        self.view.frame = frame;
    }
    return self;
}


@end
