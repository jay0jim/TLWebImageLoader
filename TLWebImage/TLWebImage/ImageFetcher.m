//
//  ImageFetcher.m
//  TLWebImage
//
//  Created by Tony on 2017/1/9.
//  Copyright © 2017年 Tony. All rights reserved.
//

#import "ImageFetcher.h"

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
}

- (UIImage *)imageWithURL:(NSURL *)url {
    NSString *urlString = [url absoluteString];
    // 先从cache中寻找有无对应url的图片缓存
    UIImage *image = [_cache objectForKey:urlString];
    if (image == nil) {
        // 如果cache中不存在，则从本地沙盒中寻找
        NSString *imagePath = [_filePath stringByAppendingPathComponent:urlString];
        image = [UIImage imageWithContentsOfFile:imagePath];
        
        if (image == nil) {
            // 如果本地沙盒也不存在，则从网络上下载，并保存到本地沙盒和cache中
#warning TODO
        }
        
    }
    return image;
}

@end












