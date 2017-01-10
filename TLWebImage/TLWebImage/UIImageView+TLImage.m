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

- (void)tl_setImageWithURL:(NSURL *)url {
    [self tl_setImageWithURL:url Placeholder:nil];
}

- (void)tl_setImageWithURL:(NSURL *)url Placeholder:(UIImage *)placeholder {
    ImageFetcher *fetcher = [ImageFetcher sharedInstance];
    
    
    
    __weak typeof(self) weakSelf = self;
    [fetcher fetchImageWithURL:url PlaceholderImage:placeholder CompletionHandler:^(id object) {
        typeof(weakSelf) strongSelf = weakSelf;
        dispatch_async(dispatch_get_main_queue(), ^{
            strongSelf.image = (UIImage *)object;
            [strongSelf setNeedsLayout];
        });
    }];
}

@end
