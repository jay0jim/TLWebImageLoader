//
//  ViewController.m
//  TLWebImage
//
//  Created by Tony on 2017/1/9.
//  Copyright © 2017年 Tony. All rights reserved.
//

#import "ViewController.h"

#import "ImageFetcher.h"
#import "UIImageView+TLImage.h"

#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width

// 自定义cell
@interface MyTableViewCell : UITableViewCell

@property (nonatomic) UIImageView *TLImageView;

@end

@implementation MyTableViewCell: UITableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initial];
    }
    return self;
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
    
}

@end

@interface ViewController ()
<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic) NSMutableArray *dataArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
    _dataArray = [[NSMutableArray alloc] initWithArray:@[@"http://imgsrc.baidu.com/forum/pic/item/834128381f30e9245f25188b4c086e061c95f755.jpg", @"http://www.baidu.com/img/bdlogo.png", @"http://imgsrc.baidu.com/forum/pic/item/15c6a0ec08fa513ddb1ce8643d6d55fbb3fbd9a4.jpg", @"http://imgsrc.baidu.com/forum/pic/item/24a508fa513d2697a7658ce755fbb2fb4216d8a4.jpg", @"http://imgsrc.baidu.com/forum/pic/item/ef2af6246b600c3392c85a721a4c510fd8f9a1a4.jpg", @"http://imgsrc.baidu.com/forum/pic/item/30c68c5494eef01f5b879c7fe0fe9925bd317d46.jpg", @"http://imgsrc.baidu.com/forum/pic/item/4958728b4710b9125c527244c3fdfc0393452246.jpg", @"http://imgsrc.baidu.com/forum/pic/item/058239dbb6fd526678b8b8aeab18972bd5073646.jpg", @"http://imgsrc.baidu.com/forum/pic/item/887a8744ebf81a4c49bf6873d72a6059242da640.jpg", @"http://imgsrc.baidu.com/forum/pic/item/6fb11a4c510fd9f9cd9ad1d3252dd42a2934a440.jpg", ]];
    
    for (int i = 0; i < 100; i++) {
        [_dataArray addObject:@"http://imgsrc.baidu.com/forum/pic/item/4958728b4710b9125c527244c3fdfc0393452246.jpg"];
    }
    
    UIBarButtonItem *clearButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Clear" style:UIBarButtonItemStylePlain target:self action:@selector(clearLocalFiles)];
    self.navigationItem.rightBarButtonItem = clearButtonItem;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyCell"];
    
    if (cell == nil) {
        cell = [[MyTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyCell"];
    }
    
    NSURL *url = [NSURL URLWithString:_dataArray[indexPath.row]];
    [cell.TLImageView tl_setImageWithURL:url Placeholder:nil];
    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyCell"];
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyCell"];
//    }
//    NSURL *url = [NSURL URLWithString:_dataArray[indexPath.row]];
//    [cell.imageView tl_setImageWithURL:url];
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

#pragma mark - Clear Files
- (void)clearLocalFiles {
    [[ImageFetcher sharedInstance] clearLocalFile];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end











