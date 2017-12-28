//
//  BesizerViewController.m
//  TGTestUI
//
//  Created by MacPro on 2017/12/28.
//  Copyright © 2017年 Centaline. All rights reserved.
//

#import "BesizerViewController.h"

@interface BesizerViewController ()

@end

@implementation BesizerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panTouch:)];
    [self.view addGestureRecognizer:pan];
    self.beizer = [UIBezierPath bezierPath];
    [self initCAShaper];

}

- (void)initCAShaper {
    self.shapelayer = [CAShapeLayer new];
//    self.shapelayer.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    self.shapelayer.fillColor = nil;
    self.shapelayer.lineCap = kCALineCapRound;
    self.shapelayer.strokeColor = [UIColor purpleColor].CGColor;
    self.shapelayer.lineWidth = 2;
    
    //阴影颜色
    self.shapelayer.shadowColor = [[UIColor blackColor] CGColor];
    //阴影offset
    self.shapelayer.shadowOffset = CGSizeMake(0, 3);
    //阴影path
    
    //不透明度
    self.shapelayer.shadowOpacity = 0.6;
    //阴影圆角半径
    self.shapelayer.shadowRadius = 3;
    
    [self.view.layer addSublayer:self.shapelayer];
    
}
- (void)panTouch:(UIPanGestureRecognizer *)pan {
    
    _startPoint = [pan locationInView:self.view];
    if (pan.state == UIGestureRecognizerStateBegan) {
        [self.beizer moveToPoint:_startPoint];
    }
    
    if (pan.state == UIGestureRecognizerStateChanged) {
        _movePoint = [pan locationInView:self.view];
        [_beizer addLineToPoint:_movePoint];
        self.shapelayer.path = _beizer.CGPath;
        self.shapelayer.shadowPath = _beizer.CGPath;
    }
}
@end
