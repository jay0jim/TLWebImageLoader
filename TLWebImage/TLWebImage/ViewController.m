//
//  ViewController.m
//  TLWebImage
//
//  Created by Tony on 2017/1/9.
//  Copyright © 2017年 Tony. All rights reserved.
//

#import "ViewController.h"

#import "MyTableViewCell.h"
#import "ImageFetcher.h"
#import "UIImageView+TLImage.h"

#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width

@interface ViewController ()
<UITableViewDelegate, UITableViewDataSource>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    tableView.delegate = self;
    tableView.dataSource = self;
//    [self.view addSubview:tableView];
    
    NSURL *url = [NSURL URLWithString:@"http://imgsrc.baidu.com/forum/pic/item/834128381f30e9245f25188b4c086e061c95f755.jpg"];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(30, 30, 200, 150)];
    [imageView setImageWithURL:url];
    [self.view addSubview:imageView];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyCell"];
    
    if (cell == nil) {
        cell = [[MyTableViewCell alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, tableView.rowHeight)];
        
    }
    
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end











