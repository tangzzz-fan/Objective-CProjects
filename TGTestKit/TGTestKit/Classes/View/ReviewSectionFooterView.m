//
//  ReviewSectionFooterView.m
//  TGTestKit
//
//  Created by MacPro on 2017/12/25.
//  Copyright © 2017年 Centaline. All rights reserved.
//

#import "ReviewSectionFooterView.h"

@implementation ReviewSectionFooterView
- (NSString *)buttonText {
    return self.showModeButton.titleLabel.text;
}

- (ReviewSectionFooterView *)footerView {
    return [[[NSBundle mainBundle] loadNibNamed:@"ReviewSectionFooterView" owner:nil options:nil] lastObject];
}

- (CGFloat)preferedHeight {
    return 46.0;
}

- (void)startActivityIndicator {
    if (self.activityIndicator.isHidden == NO) {
        return;
    } else {
        self.activityIndicator.hidden = NO;
        [self.activityIndicator startAnimating];
        self.showModeButton.titleLabel.alpha = 0.0;
    }
}

- (void)stopActivityIndicator {
    if (self.activityIndicator.isHidden == YES) {
        return;
    }
    
    self.activityIndicator.hidden = YES;
    [self.activityIndicator startAnimating];
    self.showModeButton.titleLabel.alpha = 1.0;
}

- (void)setButtonText:(NSString *)buttonText {
    [self.showModeButton setTitle:buttonText forState:UIControlStateNormal];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.activityIndicator.hidden = YES;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self setRoundCorner];
}

- (void)setRoundCorner {
    self.showModeButton.layer.cornerRadius = self.showModeButton.frame.size.height / 2;
}

- (IBAction)showMoreBtnClick:(id)sender {
    if (self.showModeBlock) {
        self.showModeBlock();
    }
}


@end
