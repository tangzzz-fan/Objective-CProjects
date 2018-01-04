//
//  TGPOITableViewCell.h
//  TGMVVMDemo
//
//  Created by 汤振治 on 04/01/2018.
//  Copyright © 2018 Centaline. All rights reserved.
//

#import "TGBaseTableViewCell.h"

@interface TGPOITableViewCell : TGBaseTableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *frontImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightFooterLabel;
@property (weak, nonatomic) IBOutlet UILabel *campaignLabel;
@property (weak, nonatomic) IBOutlet UIView *campaignView;
@end
