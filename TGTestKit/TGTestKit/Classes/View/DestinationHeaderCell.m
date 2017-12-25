//
//  DestinationHeaderCell.m
//  TGTestKit
//
//  Created by MacPro on 2017/12/22.
//  Copyright © 2017年 Centaline. All rights reserved.
//

#import "DestinationHeaderCell.h"

@interface DestinationHeaderCell()
@property (strong, nonatomic) UILabel *testLabel;

@end

@implementation DestinationHeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

+ (CGFloat)preferedHeight {
    return 300;
}

- (void)configureWithDescription:(NSString *)description isRow:(BOOL)isRow {
    self.testLabel.text = description;
}

#pragma mark - Setter
- (UILabel *)testLabel {
    if (!_testLabel) {
        _testLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 300, 44)];
        _testLabel.textColor = [UIColor redColor];
        _testLabel.textAlignment = NSTextAlignmentCenter;
        _testLabel.backgroundColor = [UIColor greenColor];
    }
    return _testLabel;
}


@end
