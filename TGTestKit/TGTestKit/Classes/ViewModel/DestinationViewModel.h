//
//  DestinationViewModel.h
//  TGTestKit
//
//  Created by MacPro on 2017/12/25.
//  Copyright © 2017年 Centaline. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface DestinationViewModel : NSObject
@property (strong, nonatomic) NSString *destinationTitle;
// headerSection 观察者
@property (strong, nonatomic) NSMutableArray *distinationHeaderSectionViewModelObserver;
// 观察评论部分数据变化
@property (strong, nonatomic) NSMutableArray *distinationReviewSectionViewModelObserver;
// 观察信息部分数据变化
@property (strong, nonatomic) NSMutableArray *distinationInfoSectionViewModelObserver;

// 顶部图片
@property (strong, nonatomic) UIImage *topPhoto;

// 图片描述
@property (strong, nonatomic) NSString *descriptionStr;
// 目的地名称
@property (strong, nonatomic) NSString *distinationName;
@property (strong, nonatomic) NSString *locationName;
//@property (assign, nonatomic) CLLocationCoordinate2D locationCoordinate;

@property (strong, nonatomic) NSMutableDictionary *locationInfo;
// 平均评价
@property (assign, nonatomic) CGFloat avarageRating;
@property (strong, nonatomic) NSMutableArray *rowViewModels;
// 剩余评论数
@property (assign, nonatomic) NSInteger remainingRowViewModels;

- (void)refreshDataWithCompletationHandler:(void(^)(void))completationBlock;

@end
