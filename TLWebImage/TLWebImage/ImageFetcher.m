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
    
    _cache = [[NSCache alloc] init];
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
                return [NSURL fileURLWithPath:savePath];
                
            } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
                
                // 图片已保存到本地沙盒，接下来在保存到cache
                NSString *filePathString = [filePath path];
                image = [UIImage imageWithContentsOfFile:filePathString];
                [_cache setObject:image forKey:fileName];
                
                if (complete != nil) {
                    complete(image);
                }
                
            }];
            [task resume];
            
        } else {
            // 把从本地沙盒读取到的图片放入cache中
            [_cache setObject:image forKey:fileName];
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
    
    NSURL *url = [NSURL URLWithString:@"http://imgsrc.baidu.com/forum/pic/item/ef2af6246b600c3392c85a721a4c510fd8f9a1a4.jpg"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
//        NSString *savePath = [_filePath stringByAppendingPathComponent:response.suggestedFilename];
//        NSLog(@"%@", savePath);
//        return [NSURL URLWithString:savePath];
        NSString *path = [_filePath stringByAppendingPathComponent:response.suggestedFilename];
        NSLog(@"%@", path);
        return [NSURL fileURLWithPath:path];
        
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
    }];
    [downloadTask resume];
}

- (void)testMethod2 {
    NSURL *URL = [NSURL URLWithString:@"http://imgsrc.baidu.com/forum/pic/item/ef2af6246b600c3392c85a721a4c510fd8f9a1a4.jpg"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    //请求
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    //下载Task操作
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        NSString *path = [_filePath stringByAppendingPathComponent:response.suggestedFilename];
        NSLog(@"%@", path);
        return [NSURL fileURLWithPath:path];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
        
    }];
    [downloadTask resume];
}

@end


























