//
//  MyTableViewCell.m
//  TLWebImage
//
//  Created by Tony on 2017/1/9.
//  Copyright © 2017年 Tony. All rights reserved.
//

#import "MyTableViewCell.h"

#define kCellHeight [UIScreen mainScreen].bounds.size.height
#define kCellWidth  [UIScreen mainScreen].bounds.size.width

@interface MyTableViewCell ()

@property (nonatomic) UIImageView *TLImageView;
@property (nonatomic) UIActivityIndicatorView *indicatorView;

@property (nonatomic, assign) BOOL hasLoadedImage;

@end

@implementation MyTableViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setNeedsLayout];
        [self setNeedsDisplay];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setNeedsLayout];
    [self setNeedsDisplay];
}

- (void)layoutSubviews {
    [self initial];
}

- (void)initial {
    // 初始化imageView，设定布局
    CGFloat cellHeight = self.frame.size.height;
    _TLImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, cellHeight - 20, cellHeight - 20)];
    NSString *placeholderName = [[NSBundle mainBundle] pathForResource:@"placeholder" ofType:@"jpg"];
    [_TLImageView setImage:[UIImage imageWithContentsOfFile:placeholderName]];
    [self addSubview:_TLImageView];
    
    _indicatorView = [[UIActivityIndicatorView alloc] init];
    _indicatorView.center = _TLImageView.center;
    _indicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    [self addSubview:_indicatorView];
#warning TODO
    self.hasLoadedImage = YES;
    
}

- (void)setHasLoadedImage:(BOOL)hasLoadedImage {
    if (hasLoadedImage) {
        [_indicatorView stopAnimating];
    } else {
        [_indicatorView startAnimating];
    }
}

#pragma mark - 设置图片
- (void)setDisplayImage:(UIImage *)image {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end











