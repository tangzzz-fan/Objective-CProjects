//
//  TGDemo1ViewModel.m
//  TGMVVMDemo
//
//  Created by 汤振治 on 04/01/2018.
//  Copyright © 2018 Centaline. All rights reserved.
//

#import "TGDemo2ViewModel.h"
#import "TGDemo2Model.h"

#import "TGHotelCellViewModel.h"
#import "TGScenicCellViewModel.h"

#import "TGScenic.h"
#import "TGHotel.h"

@interface TGDemo2ViewModel()

@property (nonatomic, strong, readwrite) RACSignal *dataSignal;

@property (nonatomic, strong, readwrite) RACSignal *errorSignal;

@property (nonatomic, strong, readwrite) RACCommand *loadDataCommand;

@end
@implementation TGDemo2ViewModel
- (instancetype)init {
    
    if (self = [super init]) {
        _dataSignal = [[self.loadDataCommand.executionSignals flattenMap:^RACStream *(RACSignal *dataSignal) {
//            LocationManager *locationManager = [LocationManager defaultLocationManager];

            return [dataSignal map:^id (RACTuple *data) {
                NSArray *scenicArray = data.first;
                NSArray *hotelArray = data.second;
                return [[[[scenicArray rac_sequence] map:^id (TGScenic *scenic) {
                    TGScenicCellViewModel *viewModel = [[TGScenicCellViewModel alloc] initWithScenic:scenic];
//                    viewModel.currentCityID = locationManager.lastLoaionCityID;
                    return viewModel;
                }] concat:[[hotelArray rac_sequence] map:^id (TGHotel *hotel) {
                    TGHotelCellViewModel *viewModel = [[TGHotelCellViewModel alloc] initWithHotel:hotel];
                    return viewModel;
                }]] array];
            }];
        }] deliverOnMainThread];
        _errorSignal = self.loadDataCommand.errors;
    }
    return self;
}

- (RACCommand *)loadDataCommand {
    if (!_loadDataCommand) {
        _loadDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            TGDemo2Model *model = [[TGDemo2Model alloc] init];
            RACSignal *travelSignal = [model loadTravelData];
            RACSignal *hotelSignal = [model loadHotelData];
            return [travelSignal zipWith:hotelSignal];
        }];
    }
    return _loadDataCommand;
}

@end
