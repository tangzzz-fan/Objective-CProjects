//
//  TGTest1TableViewCell.m
//  TGTestUI
//
//  Created by 汤振治 on 14/01/2018.
//  Copyright © 2018 Centaline. All rights reserved.
//

#import "TGTest1TableViewCell.h"

#import "TGTest1View.h"
@interface TGTest1TableViewCell()
@property (weak, nonatomic) IBOutlet UIView *container;

/** containerView */
@property (nonatomic, strong) TGTest1View *containerView;
@end

@implementation TGTest1TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
//    NSLog(@"awakeFromNib container frame %@", NSStringFromCGRect(self.container.frame));
//    [self.contentView setNeedsLayout];
//    [self.contentView layoutIfNeeded];
//    NSLog(@"awakeFromNib container frame %@", NSStringFromCGRect(self.container.frame));
    
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    self.container.backgroundColor = [UIColor redColor];
    [self.container setNeedsLayout];
    [self.container layoutIfNeeded];
    [self.container addSubview:self.containerView];

}

- (UIView *)containerView {
    if (!_containerView) {
        
        NSLog(@"container frame %@", NSStringFromCGRect(self.container.bounds));
        _containerView = [[TGTest1View alloc] initWithFrame:self.container.bounds];
        _containerView.backgroundColor = [UIColor redColor];
    }
    return _containerView;
}

@end
