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
    _TLImageView.frame = CGRectMake(10, 10, 80, 80);
    [self addSubview:_TLImageView];
    
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
    
    _dataArray = [[NSMutableArray alloc] initWithArray:@[@"http://imgsrc.baidu.com/forum/pic/item/834128381f30e9245f25188b4c086e061c95f755.jpg", @"http://www.baidu.com/img/bdlogo.png", @"http://imgsrc.baidu.com/forum/pic/item/15c6a0ec08fa513ddb1ce8643d6d55fbb3fbd9a4.jpg", @"http://imgsrc.baidu.com/forum/pic/item/24a508fa513d2697a7658ce755fbb2fb4216d8a4.jpg", @"http://imgsrc.baidu.com/forum/pic/item/ef2af6246b600c3392c85a721a4c510fd8f9a1a4.jpg", @"http://imgsrc.baidu.com/forum/pic/item/30c68c5494eef01f5b879c7fe0fe9925bd317d46.jpg", @"http://imgsrc.baidu.com/forum/pic/item/4958728b4710b9125c527244c3fdfc0393452246.jpg", @"http://imgsrc.baidu.com/forum/pic/item/058239dbb6fd526678b8b8aeab18972bd5073646.jpg", @"http://imgsrc.baidu.com/forum/pic/item/887a8744ebf81a4c49bf6873d72a6059242da640.jpg", @"http://imgsrc.baidu.com/forum/pic/item/6fb11a4c510fd9f9cd9ad1d3252dd42a2934a440.jpg", @"http://imgsrc.baidu.com/forum/pic/item/beba3a87e950352aedeca1b25343fbf2b3118b40.jpg", @"http://imgsrc.baidu.com/forum/pic/item/d70afbf2b211931381ce7b0a65380cd790238d40.jpg", @"http://imgsrc.baidu.com/forum/pic/item/56520ef41bd5ad6e7f71e05081cb39dbb7fd3c4d.jpg", @"http://imgsrc.baidu.com/forum/pic/item/23a6ce1b9d16fdfaf4e64254b48f8c5495ee7b4f.jpg", @"http://imgsrc.baidu.com/forum/pic/item/d82934a85edf8db1a1a1f8de0923dd54574e7442.jpg", @"http://imgsrc.baidu.com/forum/pic/item/044319d8bc3eb13549483301a61ea8d3fc1f4442.jpg", @"http://imgsrc.baidu.com/forum/pic/item/9d91bc3eb13533faf9391794a8d3fd1f40345b42.jpg", @"http://imgsrc.baidu.com/forum/pic/item/3d5bc8fcc3cec3fd6bb123cfd688d43f86942742.jpg", @"http://imgsrc.baidu.com/forum/pic/item/160cd688d43f87943870cc94d21b0ef41ad53a42.jpg", @"http://imgsrc.baidu.com/forum/pic/item/208b7d1ed21b0ef4bb671ce4ddc451da80cb3e42.jpg", @"http://imgsrc.baidu.com/forum/pic/item/208b7d1ed21b0ef4bb671ce4ddc451da80cb3e42.jpg", @"http://imgsrc.baidu.com/forum/pic/item/504e35fae6cd7b892ee3be390f2442a7d8330e42.jpg", @"http://imgsrc.baidu.com/forum/pic/item/c6eed933c895d1431af9609973f082025baf0742.jpg", @"http://imgsrc.baidu.com/forum/pic/item/bf8e9f3df8dcd10035187c9b728b4710b8122f49.jpg", @"http://imgsrc.baidu.com/forum/pic/item/064b5aafa40f4bfb45541aee034f78f0f6361849.jpg", @"http://imgsrc.baidu.com/forum/pic/item/5549baa1cd11728bd5ac0898c8fcc3cec2fd2c54.jpg", @"http://imgsrc.baidu.com/forum/pic/item/598d51da81cb39db1041e3ecd0160924aa183054.jpg", @"http://imgsrc.baidu.com/forum/pic/item/737fafc379310a5575a55a4eb74543a983261054.jpg"]];
    
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











