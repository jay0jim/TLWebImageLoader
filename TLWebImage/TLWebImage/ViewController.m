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
#import "MyTableViewCell.h"

#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width

@interface ViewController ()
<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic) NSArray *dataArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
    _dataArray = @[@"http://imgsrc.baidu.com/forum/pic/item/834128381f30e9245f25188b4c086e061c95f755.jpg",
                   @"http://www.baidu.com/img/bdlogo.png",
                   @"http://imgsrc.baidu.com/forum/pic/item/15c6a0ec08fa513ddb1ce8643d6d55fbb3fbd9a4.jpg",
                   @"http://imgsrc.baidu.com/forum/pic/item/24a508fa513d2697a7658ce755fbb2fb4216d8a4.jpg",
                   @"http://imgsrc.baidu.com/forum/pic/item/ef2af6246b600c3392c85a721a4c510fd8f9a1a4.jpg",
                   @"http://imgsrc.baidu.com/forum/pic/item/30c68c5494eef01f5b879c7fe0fe9925bd317d46.jpg",
                   @"http://imgsrc.baidu.com/forum/pic/item/4958728b4710b9125c527244c3fdfc0393452246.jpg",
                   @"http://imgsrc.baidu.com/forum/pic/item/058239dbb6fd526678b8b8aeab18972bd5073646.jpg",
                   @"http://imgsrc.baidu.com/forum/pic/item/887a8744ebf81a4c49bf6873d72a6059242da640.jpg",
                   @"http://imgsrc.baidu.com/forum/pic/item/6fb11a4c510fd9f9cd9ad1d3252dd42a2934a440.jpg", ];
    
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
    [cell.TLImageView tl_setImageWithURL:url];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end











