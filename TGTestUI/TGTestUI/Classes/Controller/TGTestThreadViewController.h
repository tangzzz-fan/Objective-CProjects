//
//  TGTestThreadViewController.h
//  TGTestUI
//
//  Created by MacPro on 2018/6/27.
//  Copyright © 2018年 Centaline. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TGTestThreadViewController : UIViewController
@property(nonatomic,strong)NSThread *thread01;
@property(nonatomic,strong)NSThread *thread02;
@property(nonatomic,strong)NSThread *thread03;
@property(nonatomic,assign)NSInteger numTicket;


@end
