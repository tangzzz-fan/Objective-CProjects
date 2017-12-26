//
//  DestinationViewModel.m
//  TGTestKit
//
//  Created by MacPro on 2017/12/25.
//  Copyright © 2017年 Centaline. All rights reserved.
//

#import "DestinationViewModel.h"
#import <CoreLocation/CoreLocation.h>

@interface DestinationViewModel()



@end

@implementation DestinationViewModel
- (void)refreshDataWithCompletationHandler:(void (^)(void))completationBlock {
    
    dispatch_queue_t dispatchQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(120 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        dispatch_async(dispatchQueue, ^{
            self.descriptionStr = @"Outdoor Adventure";
            [self updateHederSectionProperties];
            [self updateInfoSectionProperties];
            [self updateReviewSectionProperties];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self updateBlock];
                if (completationBlock) {
                    completationBlock();
                }
            });
        });
    });
}

#pragma mark - Private Functions
// 更新 headerSection 数据
- (void)updateHederSectionProperties {
    _topPhoto = [UIImage imageNamed:@"vacation-place"];
    _distinationName = @"Under The Stars";
    _locationName = @"Hyrum State Park, Utah";
    
    _descriptionStr = @"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed placerat tincidunt aliquet. Quisque dictum nisi felis, vel aliquet metus congue ac. Curabitur dui arcu, sagittis vel urna non, faucibus pellentesque sem.";
}

// 更新信息部分数据
- (void)updateInfoSectionProperties {
    self.locationInfo = @{@"Address":@"Hyrum State Park, 405 W 300 S, Hyrum, UT 84319",
                          @"WebSite":@"stateparks.utah.gov",
                          @"Phone":@"+1 435-245-6866"
                          }.mutableCopy;
    
}

// 更新评论部分的数据
- (void)updateReviewSectionProperties {
    _avarageRating = 4;

}

- (void)updateBlock {
    // 通知 viewModel 的观察者执行对应的操作
}
@end
