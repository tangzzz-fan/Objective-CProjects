//
//  TGHotelCellViewModel.h
//  TGMVVMDemo
//
//  Created by 汤振治 on 04/01/2018.
//  Copyright © 2018 Centaline. All rights reserved.
//  为 Hotel 业务定义的 cellViewModel

#import "TGPOICellViewModel.h"

@class TGHotel;
@interface TGHotelCellViewModel : TGPOICellViewModel
- (instancetype)initWithHotel:(TGHotel *)hotel;
@end
