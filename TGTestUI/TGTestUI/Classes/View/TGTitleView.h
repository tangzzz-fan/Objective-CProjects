//
//  TGTitleView.h
//  TGTestUI
//
//  Created by MacPro on 2017/12/28.
//  Copyright © 2017年 Centaline. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TGStyle;
@interface TGTitleView : UIView
- (instancetype)initWithFrame:(CGRect)frame Titles:(NSArray<NSString *> *)titles TGStyle:(TGStyle *)tgStyle;
@end
