//
//  ImageFetcher.h
//  TLWebImage
//
//  Created by Tony on 2017/1/9.
//  Copyright © 2017年 Tony. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ImageFetcher : NSObject

+ (id)sharedInstance;

- (UIImage *)imageWithURL:(NSURL *)url;

@end
