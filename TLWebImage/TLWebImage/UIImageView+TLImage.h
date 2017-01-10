//
//  UIImageView+TLImage.h
//  TLWebImage
//
//  Created by Tony on 2017/1/9.
//  Copyright © 2017年 Tony. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (TLImage)

- (void)tl_setImageWithURL:(NSURL *) url;
- (void)tl_setImageWithURL:(NSURL *)url Placeholder:(UIImage *)placeholder;

@end
