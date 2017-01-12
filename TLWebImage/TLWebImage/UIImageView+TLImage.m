//
//  UIImageView+TLImage.m
//  TLWebImage
//
//  Created by Tony on 2017/1/9.
//  Copyright © 2017年 Tony. All rights reserved.
//

#import "UIImageView+TLImage.h"
#import "ImageFetcher.h"

#import <objc/runtime.h>

static char dicKey;

@implementation UIImageView (TLImage)

// objc-runtime methods
- (NSMutableDictionary *)taskDictionary {
    NSMutableDictionary *taskDic = objc_getAssociatedObject(self, &dicKey);
    if (taskDic) {
        return taskDic;
    }
    taskDic = [NSMutableDictionary dictionary];
    objc_setAssociatedObject(self, &dicKey, taskDic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return taskDic;
}

- (void)tl_setImageWithURL:(NSURL *)url {
    [self tl_setImageWithURL:url Placeholder:nil];
}

- (void)tl_setImageWithURL:(NSURL *)url Placeholder:(UIImage *)placeholder {
    
    // 停止当前ImageView的任务
    [self tl_cancelCurrentTask];
    
    // 菊花
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] init];
    indicator.center = self.center;
    indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    [self addSubview:indicator];
    [indicator startAnimating];
    
    ImageFetcher *fetcher = [ImageFetcher sharedInstance];
    
    __weak __typeof(self) weakSelf = self;
    id task = [fetcher fetchImageWithURL:url PlaceholderImage:placeholder Progress:^(NSProgress *progress) {
        
        
    } CompletionHandler:^(UIImage *object, BOOL isDone) {
    
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!weakSelf) return ;
            
            weakSelf.image = object;
            if (isDone) {
                [indicator stopAnimating];
            }
            [weakSelf setNeedsLayout];
            [weakSelf setNeedsDisplay];
        });
    }];

    // 把任务添加到字典中
    [self tl_setTask:task WithKey:@"task"];
    
}

- (void)tl_cancelCurrentTask {
    NSMutableDictionary *taskDic = [self taskDictionary];
    for (NSString *key in [taskDic allKeys]) {
        [self tl_cancelTaskWithKey:key];
    }
}

- (void)tl_cancelTaskWithKey:(NSString *)key {
    NSMutableDictionary *taskDic = [self taskDictionary];
    id task = [taskDic objectForKey:key];
    if ([task isKindOfClass:[NSURLSessionDownloadTask class]]) {
        [task cancel];
    }
    [taskDic removeObjectForKey:key];
}

- (void)tl_setTask:(NSURLSessionDownloadTask *)task WithKey:(NSString *)key {
    [self tl_cancelTaskWithKey:key];
    NSMutableDictionary *taskDic = [self taskDictionary];
    [taskDic setObject:task forKey:key];
}

@end












