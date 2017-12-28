//
//  TGDownloaderManager.h
//  TGDownloader
//
//  Created by MacPro on 2017/12/5.
//  Copyright © 2017年 Centaline. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TGDownloader.h"

@interface TGDownloaderManager : NSObject
+ (instancetype)sharedInstance;

// 添加 url 到 DownloaderManager 中执行下载
- (void)downloader:(NSURL *)url downloaderInfo:(DownLoadInfoBlock)downloadInfo progress:(ProgressBlock)progress success:(SuccessBlock)success fail:(FailedBlock)fail;

// 提高管理下载任务的方法
/** 停止一个任务 */
- (void)pauseWithURL:(NSURL *)url;
- (void)resumeWithURL:(NSURL *)url;
- (void)cancelWithURL:(NSURL *)url;

- (void)pauseAll;
- (void)resumeAll;
- (void)cancelAll;
@end

