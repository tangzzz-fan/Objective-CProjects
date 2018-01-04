//
//  TGHotelCellViewModel.m
//  TGMVVMDemo
//
//  Created by 汤振治 on 04/01/2018.
//  Copyright © 2018 Centaline. All rights reserved.
//

#import "TGHotelCellViewModel.h"

#import "TGHotel.h"

@interface TGHotelCellViewModel()
/** Hotel */
@property (nonatomic, strong) TGHotel *hotel;
@end

@implementation TGHotelCellViewModel
- (instancetype)initWithHotel:(TGHotel *)hotel {
    if (self = [super init]) {
        self.cellName = @"TGPOITableViewCell";
        _hotel = hotel;
        [self bindSignals];
    }
    return self;
}

- (void)bindSignals {
    RACSignal *hotelSignal = [RACSignal return:self.hotel];
    
    self.titleSignal = [hotelSignal map:^id (TGHotel *hotel) {
        return hotel.name;
    }];
    
    self.priceSignal = [RACSignal empty];
    self.campaignSignal = [hotelSignal map:^id (TGHotel *hotel) {
        return hotel.poiAttrTagList.firstObject ? : @"";
    }];
    
    self.campaignHiddenSignal = [hotelSignal map:^id (TGHotel *hotel) {
        return @(hotel.poiAttrTagList.count == 0);
    }];
    
    self.frontImageSignal = [[[hotelSignal map:^id (TGHotel *hotel) {
        NSData *data = [NSData dataWithContentsOfURL:hotel.frontImageURL];
        return [UIImage imageWithData:data];
    }] subscribeOn:[RACScheduler schedulerWithPriority:RACSchedulerPriorityBackground]]
                             deliverOnMainThread];
    self.rightFooterSignal = [RACSignal empty];
}
@end
