//
//  TGDownloader.h
//  TGDownloader
//
//  Created by MacPro on 2017/12/2.
//  Copyright © 2017年 Centaline. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, TGDownloadState) {
    TGDownloadStatePause,
    TGDownloadStateDownLoading,
    TGDownloadStatePauseSucced,
    TGDownloadStatePauseFailed
};

typedef void(^DownLoadInfoBlock)(long long totalSize);
typedef void(^ProgressBlock)(float progress);
typedef void(^SuccessBlock)(NSString *filePath);
typedef void(^FailedBlock)(void);
typedef void(^StateChangeBlock)(TGDownloadState state);

@interface TGDownloader : NSObject

@property (assign, nonatomic) TGDownloadState state;

@property (nonatomic, assign, readonly) float progress;

@property (nonatomic, copy) DownLoadInfoBlock downLoadInfo;
@property (nonatomic, copy) StateChangeBlock stateChange;
@property (nonatomic, copy) ProgressBlock progressChange;
@property (nonatomic, copy) SuccessBlock successBlock;
@property (nonatomic, copy) FailedBlock faildBlock;

- (void)downloader:(NSURL *)url downloadInfo:(DownLoadInfoBlock)downloadInfo progress:(ProgressBlock)progress succeed:(SuccessBlock)succeed failed:(FailedBlock)failed;

- (void)downloader:(NSURL *)url;

- (void)pauseCurrentTask;

- (void)cancelCurrentTask;

- (void)cancelAndClean;
@end
