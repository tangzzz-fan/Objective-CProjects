//
//  DestinationReviewUserRowViewModel.m
//  TGTestKit
//
//  Created by MacPro on 2017/12/25.
//  Copyright © 2017年 Centaline. All rights reserved.
//

#import "DestinationReviewUserRowViewModel.h"

@implementation DestinationReviewUserRowViewModel
- (instancetype)initWithUserName:(NSString *)userName UserReview:(NSString *)userReview Rating:(NSInteger)rating {
    if (self = [super init]) {
        self.userName = userName;
        self.userReview = userReview;
        self.rating = rating;
    }
    return self;
}
@end
