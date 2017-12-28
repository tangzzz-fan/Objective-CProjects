//
//  BesizerViewController.h
//  TGTestUI
//
//  Created by MacPro on 2017/12/28.
//  Copyright © 2017年 Centaline. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BesizerViewController : UIViewController
@property(nonatomic,strong)UIBezierPath * beizer;
@property(nonatomic,assign)CGPoint startPoint;
@property(nonatomic,assign)CGPoint movePoint;
@property(nonatomic,strong)CAShapeLayer * shapelayer;
@end
