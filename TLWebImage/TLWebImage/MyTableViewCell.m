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

@property (nonatomic) UIActivityIndicatorView *indicatorView;

@property (nonatomic, assign) BOOL hasLoadedImage;

@end

@implementation MyTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initial];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
//    [self setNeedsLayout];
//    [self setNeedsDisplay];
    [self initial];
}

- (void)initial {
    // 初始化imageView，设定布局
    _TLImageView = [[UIImageView alloc] init];
    NSString *placeholderName = [[NSBundle mainBundle] pathForResource:@"placeholder" ofType:@"jpg"];
    [_TLImageView setImage:[UIImage imageWithContentsOfFile:placeholderName]];
    [_TLImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:_TLImageView];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[_TLImageView]-10-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_TLImageView)]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[_TLImageView]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_TLImageView)]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_TLImageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:_TLImageView attribute:NSLayoutAttributeHeight multiplier:1 constant:0]];
    
    _indicatorView = [[UIActivityIndicatorView alloc] init];
    _indicatorView.center = _TLImageView.center;
    _indicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
//    [self addSubview:_indicatorView];
    self.hasLoadedImage = NO;
    
}

- (void)setHasLoadedImage:(BOOL)hasLoadedImage {
    if (hasLoadedImage) {
        [_indicatorView stopAnimating];
    } else {
        [_indicatorView startAnimating];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end











