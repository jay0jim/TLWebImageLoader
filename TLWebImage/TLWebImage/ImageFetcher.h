//
//  ImageFetcher.h
//  TLWebImage
//
//  Created by Tony on 2017/1/9.
//  Copyright © 2017年 Tony. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^ImageFetcherBlockComplete)(id object);

@interface ImageFetcher : NSObject

+ (id)sharedInstance;

- (void)fetchImageWithURL:(NSURL *) url
         PlaceholderImage:(UIImage *) placeholder
        CompletionHandler:(ImageFetcherBlockComplete) complete;

@end
