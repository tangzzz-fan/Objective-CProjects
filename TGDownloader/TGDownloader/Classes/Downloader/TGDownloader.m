//
//  TGDownloader.m
//  TGDownloader
//
//  Created by MacPro on 2017/12/2.
//  Copyright © 2017年 Centaline. All rights reserved.
//

#import "TGDownloader.h"
#import "TGFileTool.h"

#define kCachePath NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject
#define kTmpPath NSTemporaryDirectory()

@interface TGDownloader()<NSURLSessionDataDelegate>
{
    long long _totalSize;
    long long _tempSize;
}

@property (strong, nonatomic) NSURLSession *session;
@property (copy, nonatomic) NSString *downloadedPath;
@property (copy, nonatomic) NSString *downloadingPath;
/** 文件传输 */
@property (strong, nonatomic) NSOutputStream *outputStream;
/** session 中包含了 dataTask, 这里使用 weak 修饰!!! */
@property (weak, nonatomic) NSURLSessionDataTask *dataTask;


@end
@implementation TGDownloader
- (void)downloader:(NSURL *)url downloadInfo:(DownLoadInfoBlock)downloadInfo progress:(ProgressBlock)progress succeed:(SuccessBlock)succeed failed:(FailedBlock)failed {
    self.downLoadInfo = downloadInfo;
    self.progressChange = progress;
    self.successBlock = succeed;
    self.faildBlock = failed;
    [self downloader:url];
}

- (void)downloader:(NSURL *)url {
    
    // 检查任务是否存在,如果存在, 且未完成,就继续下载, 如果没有任务 则从新开始下载
    if ([url isEqual:self.dataTask.originalRequest.URL]) {
        // 任务已经存在, 检查任务状态
//        if (self.dataTask.state == 3) {
//            NSLog(@"任务已存在并完成");
//            return;
//        } else {
//            [self resumeCurrentDataTask];
//        }
        [self resumeCurrentTask];
        
        return;
    }
    
    // 文件的下载: 下载时, 放在 temp 中, 下载完成了放在 cache 中,
    NSString *fileName = url.lastPathComponent;
    
    self.downloadedPath = [kCachePath stringByAppendingPathComponent:fileName];
    self.downloadingPath = [kTmpPath stringByAppendingPathComponent:fileName];
    
    // 检查本地的数据是否存在, 如果存在相同文件名, 就比较文件数据的大小, 将消息告诉外界
    if ([TGFileTool fileExists:self.downloadedPath]) {
        // 下载完成, 不再重复下载
//        NSLog(@"下载完成");
        self.state = TGDownloadStatePauseSucced;
        return;
    }
    
    // 检查临时文件是否存在, 如果不存在, 就从零开始请求资源
    if (![TGFileTool fileExists:self.downloadingPath]) {
        [self downloadWithUrl:url offset:0];
        return;
    }
    
    // 本地 temp 路径下存在文件, 获取文件大小, 重新开始下载
    _tempSize = [TGFileTool fileSize:self.downloadingPath];
    [self downloadWithUrl:url offset:_tempSize];

}

/** 使用 url 从特定字节开始处下载文件 */
- (void)downloadWithUrl:(NSURL *)url offset:(long long)offset {
    // 设置 http-header 的 rang 处的值为偏移量
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:0];
    [request setValue:[NSString stringWithFormat:@"bytes=%lld-", offset] forHTTPHeaderField:@"Range"];
    // session 分配 task
    self.dataTask = [self.session dataTaskWithRequest:request];
    [self.dataTask resume];
}

/** 继续任务 判断之前的状态 */
- (void)resumeCurrentTask {
    if (self.state == TGDownloadStatePause && self.dataTask) {
        self.state = TGDownloadStateDownLoading;
        [self.dataTask resume];
    }
}

- (void)pauseCurrentTask {
    if (self.state == TGDownloadStateDownLoading) {
        self.state = TGDownloadStatePause;
        [self.dataTask suspend];
    }
}

- (void)cancelCurrentTask {
    self.state = TGDownloadStatePause;
    [self.session invalidateAndCancel];
    self.session = nil;
}

- (void)cancelAndClean {
    [self cancelCurrentTask];
    [TGFileTool removeFile:self.downloadingPath];
}

#pragma mark - NSUrlSessionDataDelegate
/** 第一次接收到服务器响应调用, 返回交互的头文件信息, 没有资源文件
 *  根据返回的信息决定是否继续请求, 还是取消本次请求
 *
 *  使用 NSURLSessionDataTask 实现大文件断电续传, 使用head 请求, 获取文件大小, 保存在本地沙盒中
 *  当再次进入程序时, 可以先检查沙盒中是否存在对应的临时文件, 如果存在则再获取文件大小, 或者偏移量继续进行下载, 如果没有则重新进行下载.
 *
 */

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSHTTPURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler {
    
    NSLog(@"返回的 response %@", response);
    // 此处获取文件数据的还是有问题, 有的 Content-Range bytes <int> */<size>
    
    _totalSize = [response.allHeaderFields[@"Content-Length"] longLongValue];
    NSString *contentRangrStr = response.allHeaderFields[@"Content-Range"];
    if (contentRangrStr.length != 0) {
        _totalSize = [[contentRangrStr componentsSeparatedByString:@"/"].lastObject longLongValue];
    }
    
    if (self.downLoadInfo) {
        self.downLoadInfo(_totalSize);
    }
    
    if (_tempSize == _totalSize) {
        // 移动到下载文件夹
        NSLog(@"文件已下载完成");
        [TGFileTool moveFile:self.downloadingPath toPath:self.downloadedPath];
        self.state = TGDownloadStatePauseSucced;
        completionHandler(NSURLSessionResponseCancel);
        return;
    } else if (_totalSize < _tempSize) {
        NSLog(@"清除本地缓存, 从新下载");
        [TGFileTool removeFile:self.downloadingPath];
        [self downloader:response.URL];
        completionHandler(NSURLSessionResponseCancel);
        return;
    } else {
        NSLog(@"继续接受数据");
        self.state = TGDownloadStateDownLoading;
        self.outputStream = [NSOutputStream outputStreamToFileAtPath:self.downloadingPath append:YES];
        [self.outputStream open];
        completionHandler(NSURLSessionResponseAllow);
    }
    
}

/** 正式开始接收数据 */
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data {
    [self.outputStream write:data.bytes maxLength:data.length];
    NSLog(@"接受后续数据");
    // 计算 progress
    _tempSize += data.length;
    self.progress = 1.0 * _tempSize / _totalSize;
    
}

/** 请求完成时调用 此时的请求状态未知 */
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    NSLog(@"下载 task 完成, 但是文件状态未知");
    if (!error) {
        // 不一定就是下载成功, 此只为 task 请求成功
        // 比较本地文件和下载的头文件中的数据大小, 就说明下载成功
        // 此处还要做文件重复校验.
        if (self.dataTask.state == 3 ) { // 任务完成
            [TGFileTool moveFile:self.downloadingPath toPath:self.downloadedPath];
            self.state = TGDownloadStatePauseSucced;
        }
    } else {
        
        if (error.code == -999) {
            self.state = TGDownloadStatePause;
        } else {
            self.state = TGDownloadStatePauseFailed;
        }
        
        NSLog(@"本次下载有问题, error code %zd, --reason %@", error.code, error.localizedDescription);
    }
    
    [self.outputStream close];
}

#pragma mark - Setter & Getter
- (NSURLSession *)session {
    if (!_session) {
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        // 使用一个配置文件配置, 并放在主队列中进行管理
        _session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    }
    return _session;
}

// 进度改变时 及时通知外界
- (void)setProgress:(float)progress {
    _progress = progress;
    if (self.progressChange) {
        self.progressChange(progress);
    }
}

- (void)setState:(TGDownloadState)state {
    if (_state == state) {
        return;
    }
    _state = state;
    
    if (self.stateChange) {
        self.stateChange(_state);
    }
    
    if (self.state == TGDownloadStatePauseSucced && self.successBlock) {
        self.successBlock(self.downloadedPath);
    }
    
    if (self.state == TGDownloadStatePauseFailed && self.faildBlock) {
        self.faildBlock();
    }
}

@end
