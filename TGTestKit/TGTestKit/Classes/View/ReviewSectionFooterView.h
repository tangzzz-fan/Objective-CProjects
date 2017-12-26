//
//  ReviewSectionFooterView.h
//  TGTestKit
//
//  Created by MacPro on 2017/12/25.
//  Copyright © 2017年 Centaline. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ShowMoreInfoBlock)();

@interface ReviewSectionFooterView : UIView
@property (weak, nonatomic) IBOutlet UIButton *showModeButton;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@property (strong, nonatomic) NSString *buttonText;

@property (copy, nonatomic) ShowMoreInfoBlock showModeBlock;

@end
