//
//  ImageFetcher.h
//  TLWebImage
//
//  Created by Tony on 2017/1/9.
//  Copyright © 2017年 Tony. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^ImageFetcherBlockComplete)(UIImage *object, BOOL isDone);
typedef void(^ImageFetcherBlockProgress)(NSProgress *progress);

@interface ImageFetcher : NSObject

+ (id)sharedInstance;

- (NSURLSessionDownloadTask *)fetchImageWithURL:(NSURL *) url
         PlaceholderImage:(UIImage *) placeholder
                 Progress:(ImageFetcherBlockProgress) progress
        CompletionHandler:(ImageFetcherBlockComplete) complete;
- (void)clearLocalFile;

@end
