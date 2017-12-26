//
//  DestinationReviewUserRowViewModel.h
//  TGTestKit
//
//  Created by MacPro on 2017/12/25.
//  Copyright © 2017年 Centaline. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DestinationReviewUserRowViewModel : NSObject
@property (strong, nonatomic) NSString *userName;
@property (strong, nonatomic) NSString *userReview;
@property (assign, nonatomic) NSInteger rating;



- (instancetype)initWithUserName:(NSString *)userName UserReview:(NSString *)userReview Rating:(NSInteger)rating;
@end
