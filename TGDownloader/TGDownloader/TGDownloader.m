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




@end
@implementation TGDownloader
- (void)downloader:(NSURL *)url {
    // 文件的下载: 下载时, 放在 temp 中, 下载完成了放在 cache 中,
    NSString *fileName = url.lastPathComponent;
    
    self.downloadedPath = [kCachePath stringByAppendingString:fileName];
    self.downloadingPath = [kCachePath stringByAppendingString:fileName];
    
    // 检查本地的数据是否存在, 如果存在相同文件名, 就比较文件数据的大小, 将消息告诉外界
    if ([TGFileTool fileExists:self.downloadedPath]) {
        // 下载完成, 不再重复下载
        NSLog(@"下载完成");
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
    NSURLSessionTask *dataTask = [self.session dataTaskWithRequest:request];
    [dataTask resume];
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


#pragma mark - NSUrlSessionDataDelegate
/** 第一次接收到服务器响应调用, 返回交互的头文件信息, 没有资源文件
 *  根据返回的信息决定是否继续请求, 还是取消本次请求
 */

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSHTTPURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler {
    
    NSLog(@"返回的 response %@", response);
    
    _totalSize = [response.allHeaderFields[@"Content-Length"] longLongValue];
    NSString *contentRangrStr = response.allHeaderFields[@"Content-Range"];
    if (contentRangrStr.length != 0) {
        _totalSize = [[contentRangrStr componentsSeparatedByString:@"/"].lastObject longLongValue];
    }
    
    
    if (_tempSize == _totalSize) {
        // 移动到下载文件夹
        NSLog(@"文件已下载完成");
        [TGFileTool moveFile:self.downloadingPath toPath:self.downloadedPath];
        // 取消本次请求
        completionHandler(NSURLSessionResponseCancel);
        return;
    }
    
    if (_totalSize < _tempSize) {
        NSLog(@"清除本地缓存, 从新下载");
        [TGFileTool removeFile:self.downloadingPath];
        [self downloader:response.URL];
        completionHandler(NSURLSessionResponseCancel);
        return;
    }
    
    NSLog(@"继续接受数据");
    self.outputStream = [NSOutputStream outputStreamToFileAtPath:self.downloadingPath append:YES];
    [self.outputStream open];
    completionHandler(NSURLSessionResponseAllow);
    
    
}

/** 正式开始接收数据 */
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data {
    [self.outputStream write:data.bytes maxLength:data.length];
    NSLog(@"接受后续数据");
}

/** 请求完成时调用 此时的请求状态未知 */
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    NSLog(@"请求完成");
    if (!error) {
        // 不一定就是下载成功, 此只为 task 请求成功
        // 比较本地文件和下载的头文件中的数据大小, 就说明下载成功
    } else {
        NSLog(@"本次下载有问题, 在网络数据和本地数据之间的大小问题上");
    }
    
    [self.outputStream close];
}
@end
