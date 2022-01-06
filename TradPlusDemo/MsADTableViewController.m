//
//  MsADTableViewController.m
//  TradPlusDemo
//
//  Created by ms-mac on 2017/1/9.
//  Copyright © 2017年 TradPlus. All rights reserved.
//

#import "MsADTableViewController.h"
#import "BannerViewController.h"
#import "NativeViewController.h"
#import "RewardedVideoViewController.h"
#import "InterstitialViewController.h"
#import "NativeHTViewController.h"
#import "OfferwallViewController.h"
#import "TradPlusAdNativeViewController.h"
#import "TradPlusAdNativeBannerViewController.h"
#import "TradPlusAdNativeSplashViewController.h"
#import "TradPlusAdBannerViewController.h"
#import "TradPlusAdInterstitialViewController.h"
#import "TradPlusAdRewardedViewController.h"
#import "TradPlusAdSplashViewController.h"
#import "TradPlusAdNativePasterViewController.h"

@interface MsADTableViewController ()

@property (nonatomic,strong)NSArray *titleArray;
@property (nonatomic,strong)NSArray *titleList;
@end

@implementation MsADTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorColor = [UIColor colorWithRed:0.31 green:0.31 blue:0.31 alpha:1];
    self.tableView.rowHeight = 50;
    self.tableView.sectionHeaderHeight = 30;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    //self.title = @"Ads";
    self.tableView.accessibilityLabel = @"Ad Table View";
    CGRect rect = [UIScreen mainScreen].bounds;
    rect.size.height = 20;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:rect];
    //5.x
    self.titleList = @[@"横幅",@"插屏",@"激励视频",@"积分墙",@"高级原生",@"高级原生(并发拉取多个素材)"];
    
    self.titleArray = @[@"高级原生",@"原生开屏",@"原生横幅",@"横幅",@"插屏",@"激励视频",@"开屏",@"原生视频贴片"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0)
    {
        return self.titleArray.count;
    }
    else
    {
        return self.titleList.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    if(indexPath.section == 0
       && indexPath.row < self.titleArray.count)
    {
        cell.textLabel.text = self.titleArray[indexPath.row];
    }
    else if(indexPath.section == 1
            && indexPath.row < self.titleList.count)
    {
        cell.textLabel.text = self.titleList[indexPath.row];
    }
    cell.textLabel.textColor = [UIColor colorWithRed:0.42 green:0.66 blue:0.85 alpha:1];
    cell.detailTextLabel.textColor = [UIColor colorWithRed:0.86 green:0.86 blue:0.86 alpha:1];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(section == 0)
    {
        return @"------ ADType ------";
    }
    else
    {
        return @"------ 5.x ADType ------";
    }
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *detailViewController = nil;
    if(indexPath.section == 0)
    {
        switch (indexPath.row)
        {
            case 0://高级原生
            {
                detailViewController = [[TradPlusAdNativeViewController alloc] initWithNibName:@"TradPlusAdNativeViewController" bundle:nil];
                break;
            }
            case 1://原生开屏
            {
                detailViewController = [[TradPlusAdNativeSplashViewController alloc] initWithNibName:@"TradPlusAdNativeSplashViewController" bundle:nil];
                break;
            }
            case 2://原生开屏
            {
                detailViewController = [[TradPlusAdNativeBannerViewController alloc] initWithNibName:@"TradPlusAdNativeBannerViewController" bundle:nil];
                break;
            }
            case 3://横幅
            {
                detailViewController = [[TradPlusAdBannerViewController alloc] initWithNibName:@"TradPlusAdBannerViewController" bundle:nil];
                break;
            }
            case 4://插屏
            {
                detailViewController = [[TradPlusAdInterstitialViewController alloc] initWithNibName:@"TradPlusAdInterstitialViewController" bundle:nil];
                break;
            }
            case 5://激励视频
            {
                detailViewController = [[TradPlusAdRewardedViewController alloc] initWithNibName:@"TradPlusAdRewardedViewController" bundle:nil];
                break;
            }
            case 6://开屏
            {
                detailViewController = [[TradPlusAdSplashViewController alloc] initWithNibName:@"TradPlusAdSplashViewController" bundle:nil];
                break;
            }
            case 7://原生视频贴片 v6.8.0新增
            {
                detailViewController = [[TradPlusAdNativePasterViewController alloc] initWithNibName:@"TradPlusAdNativePasterViewController" bundle:nil];
                break;
            }
        }
    }
    else//5.x
    {
        switch (indexPath.row)
        {
            case 0://横幅
            {
                detailViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"b"];
                break;
            }
            case 1://插屏
            {
                detailViewController = [[InterstitialViewController alloc] initWithNibName:@"InterstitialViewController" bundle:nil];
                break;
            }
            case 2://激励视频
            {
                detailViewController = [[RewardedVideoViewController alloc] initWithNibName:@"RewardedVideoViewController" bundle:nil];
                break;
            }
            case 3://积分墙
            {
                detailViewController = [[OfferwallViewController alloc] initWithNibName:@"OfferwallViewController" bundle:nil];
                break;
            }
            case 4://高级原生
            {
                detailViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"n"];
                ((NativeViewController *)detailViewController).nativeADType = MsNativeADTypeAdvanced;
                break;
            }
            case 5://高级原生(并发拉取多个素材)
            {
                detailViewController = [[NativeHTViewController alloc] initWithNibName:@"NativeHTViewController" bundle:nil];
                break;
            }
        }
    }
    if(detailViewController != nil)
    {
        detailViewController.modalPresentationStyle = UIModalPresentationFullScreen;
        [self.navigationController pushViewController:detailViewController animated:YES];
    }
}


@end
