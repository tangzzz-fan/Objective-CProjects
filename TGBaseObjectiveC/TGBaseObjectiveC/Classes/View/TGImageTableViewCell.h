//
//  TGImageTableViewCell.h
//  TGBaseObjectiveC
//
//  Created by MacPro on 2017/12/11.
//  Copyright © 2017年 Centaline. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TGImageModel;
@interface TGImageTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageView1;
@property (weak, nonatomic) IBOutlet UIImageView *imageView2;
@property (weak, nonatomic) IBOutlet UIImageView *imageView3;
@property (weak, nonatomic) IBOutlet UILabel *desLabel;


@property (strong, nonatomic) TGImageModel *imageModel;

@end
