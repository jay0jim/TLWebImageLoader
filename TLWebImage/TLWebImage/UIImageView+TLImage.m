//
//  UIImageView+TLImage.m
//  TLWebImage
//
//  Created by Tony on 2017/1/9.
//  Copyright © 2017年 Tony. All rights reserved.
//

#import "UIImageView+TLImage.h"
#import "ImageFetcher.h"

@implementation UIImageView (TLImage)

- (void)setImageWithURL:(NSURL *) url {
    ImageFetcher *fetcher = [ImageFetcher sharedInstance];
    [fetcher fetchImageWithURL:url CompletionHandler:^(id object) {
        self.image = (UIImage *)object;
    }];
}

@end
