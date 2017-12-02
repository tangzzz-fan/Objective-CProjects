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


@interface TGDownloader : NSObject

@property (assign, nonatomic) TGDownloadState state;


- (void)downloader:(NSURL *)url;

- (void)pauseCurrentTask;

- (void)cancelCurrentTask;

- (void)cancelAndClean;
@end
