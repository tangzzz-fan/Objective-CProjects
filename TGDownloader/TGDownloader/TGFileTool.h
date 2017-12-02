//
//  TGFileTool.h
//  TGDownloader
//
//  Created by MacPro on 2017/12/2.
//  Copyright © 2017年 Centaline. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TGFileTool : NSObject
/** 文件是否存在 */
+ (BOOL)fileExists:(NSString *)filePath;
/** 检查文件大小 */
+ (long long)fileSize:(NSString *)filePath;

/** 移动文件 */
+ (void)moveFile:(NSString *)fromPath toPath:(NSString *)toPath;
/** 删除文件 */
+ (void)removeFile:(NSString *)filePath;
@end
