//
//  TGDownloaderManager.m
//  TGDownloader
//
//  Created by MacPro on 2017/12/5.
//  Copyright © 2017年 Centaline. All rights reserved.
//

#import "TGDownloaderManager.h"
#import "NSString+Extension.h"

@interface TGDownloaderManager()<NSCopying, NSMutableCopying>
@property (strong, nonatomic) NSMutableDictionary *downloadInfo;

@end
@implementation TGDownloaderManager
static TGDownloaderManager *_sharedInstance;

+ (instancetype)sharedInstance {
    if (!_sharedInstance) {
        _sharedInstance = [[self alloc] init];
    }
    return _sharedInstance;
        
}

#pragma mark - Actions
- (void)downloader:(NSURL *)url downloaderInfo:(DownLoadInfoBlock)downloadInfo progress:(ProgressBlock)progress success:(SuccessBlock)success fail:(FailedBlock)fail {
    // 1 获取 url
    // 2 检查字典中是否有 url 任务
    // 3 调用 downloader 执行下载任务
    NSString *urlMD5Str = [url.absoluteString md5Str];
    TGDownloader *downloader = self.downloadInfo[urlMD5Str];
    if (!downloader) {
        downloader = [[TGDownloader alloc] init];
        self.downloadInfo[urlMD5Str] = downloader;
    }
    
    __weak typeof(self) weakSelf = self;
    [downloader downloader:url downloadInfo:downloadInfo progress:progress succeed:^(NSString *filePath) {
        // 从字典中移除对应的任务
        success(filePath);
        
        [weakSelf.downloadInfo removeObjectForKey:urlMD5Str];
        
    } failed:fail];
    
}

- (void)pauseWithURL:(NSURL *)url {
    NSString *urlMd5Str = [url.absoluteString md5Str];
    TGDownloader *downloader = self.downloadInfo[urlMd5Str];
    [downloader pauseCurrentTask];
}

- (void)resumeWithURL:(NSURL *)url {
    NSString *urlMd5Str = [url.absoluteString md5Str];
    TGDownloader *downloader = self.downloadInfo[urlMd5Str];
    [downloader resumeCurrentTask];
}

- (void)cancelWithURL:(NSURL *)url {
    NSString *urlMd5Str = [url.absoluteString md5Str];
    TGDownloader *downloader = self.downloadInfo[urlMd5Str];
    [downloader cancelCurrentTask];
}

- (void)pauseAll {
    [self.downloadInfo.allValues performSelector:@selector(pauseCurrentTask) withObject:nil];
}

- (void)resumeAll {
    [self.downloadInfo.allValues performSelector:@selector(resumeCurrentTask) withObject:nil];
}

- (void)cancelAll {
    [self.downloadInfo.allValues performSelector:@selector(cancelCurrentTask) withObject:nil];
}

#pragma mark - NSCopyingDelegate
+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    if (!_sharedInstance) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _sharedInstance = [super allocWithZone:zone];
        });
    }
    return _sharedInstance;
}

- (id)copyWithZone:(NSZone *)zone {
    return _sharedInstance;
}

- (id)mutableCopyWithZone:(NSZone *)zone {
    return _sharedInstance;
}

#pragma mark - Setter && Getter
- (NSMutableDictionary *)downloadInfo {
    if (!_downloadInfo) {
        _downloadInfo = [NSMutableDictionary dictionary];
    }
    return _downloadInfo;
}


@end
