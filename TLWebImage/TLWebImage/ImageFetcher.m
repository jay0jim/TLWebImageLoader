//
//  ImageFetcher.m
//  TLWebImage
//
//  Created by Tony on 2017/1/9.
//  Copyright © 2017年 Tony. All rights reserved.
//

#import "ImageFetcher.h"

#import <AFNetworking.h>

@interface ImageFetcher ()

// 存放图片的cache对象
@property (nonatomic) NSCache *cache;

// 本地沙盒路径
@property (nonatomic) NSString *filePath;

@end

@implementation ImageFetcher

+ (id)sharedInstance {
    static ImageFetcher *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[ImageFetcher alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    if (self = [super init]) {
        [self initials];
    }
    return self;
}

- (void)initials {
    // 新建存放图片文件的文件夹
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *path = [docPath stringByAppendingPathComponent:@"images"];
    if (![fileManager fileExistsAtPath:path]) {
        [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    _filePath = path;
    
    // 设置cache最多保存100条内容和100M容量
    _cache.countLimit = 100;
    _cache.totalCostLimit = 100 * 1024 * 1024;
    
}

- (void)fetchImageWithURL:(NSURL *)url CompletionHandler:(ImageFetcherBlockComplete)complete{
    NSString *urlString = [url absoluteString];
    
    // 获取文件名
    NSString *fileName = [urlString lastPathComponent];
    
    // 先从cache中寻找有无对应url的图片缓存
    __block UIImage *image = [_cache objectForKey:fileName];
    
    if (image == nil) {
        // 如果cache中不存在，则从本地沙盒中寻找
        NSString *imagePath = [_filePath stringByAppendingPathComponent:fileName];
        image = [UIImage imageWithContentsOfFile:imagePath];
        
        if (image == nil) {
            // 如果本地沙盒也不存在，则从网络上下载，并保存到本地沙盒和cache中
            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
            
            NSURLRequest *request = [NSURLRequest requestWithURL:url];
            NSURLSessionDownloadTask *task = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
                
                // 下载进度
                
            } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
                
                NSString *savePath = [_filePath stringByAppendingPathComponent:response.suggestedFilename];
                return [NSURL URLWithString:savePath];
                
            } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
                
                // 图片已保存到本地沙盒，接下来在保存到cache
                image = [UIImage imageWithContentsOfFile:[filePath absoluteString]];
                [_cache setObject:image forKey:fileName];
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"ImageFetched" object:nil];
                
            }];
            [task resume];
            
            if (complete != nil) {
                complete(image);
            }
            
        } else {
            if (complete != nil) {
                complete(image);
            }
        }
        
    } else {
        if (complete != nil) {
            complete(image);
        }
    }
    
}

- (void)testMethod {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSURL *url = [NSURL URLWithString:@"http://www.baidu.com/img/bdlogo.png"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDownloadTask *task = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        
        
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        NSString *savePath = [_filePath stringByAppendingPathComponent:response.suggestedFilename];
        NSLog(@"%@", savePath);
        
        return [NSURL URLWithString:savePath];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
        // 图片已保存到本地沙盒，接下来在保存到cache
        
        
//        [_cache setObject:image forKey:urlString];
        
        if (!error) {
            NSLog(@"%@", filePath);
        }
        
    }];
    [task resume];
}

- (void)testMethod2 {
    NSURL *URL = [NSURL URLWithString:@"http://www.baidu.com/img/bdlogo.png"];
    
//    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    //AFN3.0+基于封住URLSession的句柄
    //    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    
    //请求
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    //下载Task操作
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        
        //        // @property int64_t totalUnitCount;  需要下载文件的总大小
        //        // @property int64_t completedUnitCount; 当前已经下载的大小
        //
        //        // 给Progress添加监听 KVO
        //        NSLog(@"%f",1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
        //        // 回到主队列刷新UI
        //        dispatch_async(dispatch_get_main_queue(), ^{
        //            self.progressView.progress = 1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount;
        //        });
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        //- block的返回值, 要求返回一个URL, 返回的这个URL就是文件的位置的路径
        
        //        NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString *path = [_filePath stringByAppendingPathComponent:response.suggestedFilename];
        NSLog(@"%@", path);
        return [NSURL fileURLWithPath:path];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        // filePath就是你下载文件的位置，你可以解压，也可以直接拿来使用
        
//        NSString *imgFilePath = [filePath path];// 将NSURL转成NSString
//        UIImage *img = [UIImage imageWithContentsOfFile:imgFilePath];
//        self.imageView.image = img;
        
    }];
    [downloadTask resume];
}

@end


























