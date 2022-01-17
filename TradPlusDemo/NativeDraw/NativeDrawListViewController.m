//
//  NativeDrawListViewController.m
//  fluteSDKSample
//
//  Created by xuejun on 2021/12/30.
//  Copyright © 2021 TradPlus. All rights reserved.
//

#import "NativeDrawListViewController.h"

@interface NativeDrawListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,weak)IBOutlet UITableView *myTableView;
@end

@implementation NativeDrawListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.drawList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UIScreen mainScreen].bounds.size.height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithFrame:[UIScreen mainScreen].bounds];
    UIView *adView = self.drawList[indexPath.row];
    adView.frame = [UIScreen mainScreen].bounds;
    [cell.contentView addSubview:adView];
    return cell;
}

@end
