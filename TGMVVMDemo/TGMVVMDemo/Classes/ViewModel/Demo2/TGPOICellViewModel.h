//
//  TGPOICellViewModel.h
//  TGMVVMDemo
//
//  Created by 汤振治 on 04/01/2018.
//  Copyright © 2018 Centaline. All rights reserved.
//  有 POI 的基线 CellViewModel

#import "TGBaseCellViewModel.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface TGPOICellViewModel : TGBaseCellViewModel
@property (nonatomic) RACSignal *frontImageSignal; //UIImage
@property (nonatomic) RACSignal *titleSignal; //NSString
@property (nonatomic) RACSignal *priceSignal; //NSAttributeText
@property (nonatomic) RACSignal *campaignSignal; //NSString
@property (nonatomic) RACSignal *campaignHiddenSignal; //NSNumber(BOOL)
@property (nonatomic) RACSignal *rightFooterSignal; //NSString

@end
