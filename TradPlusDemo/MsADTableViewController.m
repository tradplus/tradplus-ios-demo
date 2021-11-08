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

@interface MsADTableViewController ()

@property (nonatomic,strong)NSArray *titleArray;
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
    self.titleArray = @[@"横幅",@"高级原生",@"高级原生(并发拉取多个素材)",@"插屏",@"激励视频",@"积分墙",@"高级原生（6.4+）",@"原生开屏（6.4+）",@"原生横幅（6.4+）",@"横幅（6.4+）",@"插屏（6.4+）",@"激励视频（6.4+）",@"开屏（6.4+）"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    if(indexPath.row < self.titleArray.count)
    {
        cell.textLabel.text = self.titleArray[indexPath.row];
    }
    cell.textLabel.textColor = [UIColor colorWithRed:0.42 green:0.66 blue:0.85 alpha:1];
    cell.detailTextLabel.textColor = [UIColor colorWithRed:0.86 green:0.86 blue:0.86 alpha:1];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"------ ADType ------";
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
    {
        UIViewController *detailViewController = nil;
        switch (indexPath.row)
        {
            case 0://@"横幅"
            {
                detailViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"b"];
                break;
            }
            case 1://@"高级原生"
            {
                detailViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"n"];
                ((NativeViewController *)detailViewController).nativeADType = MsNativeADTypeAdvanced;
                break;
            }
            case 2://@"高级原生(并发拉取多个素材)"
            {
                detailViewController = [[NativeHTViewController alloc] initWithNibName:@"NativeHTViewController" bundle:nil];
                break;
            }
            case 3://@"插屏"
            {
                detailViewController = [[InterstitialViewController alloc] initWithNibName:@"InterstitialViewController" bundle:nil];
                break;
            }
            case 4://@"激励视频"
            {
                detailViewController = [[RewardedVideoViewController alloc] initWithNibName:@"RewardedVideoViewController" bundle:nil];
                break;
            }
            case 5://@"积分墙"
            {
                detailViewController = [[OfferwallViewController alloc] initWithNibName:@"OfferwallViewController" bundle:nil];
                break;
            }
            case 6://@"高级原生（6.0）"
            {
                detailViewController = [[TradPlusAdNativeViewController alloc] initWithNibName:@"TradPlusAdNativeViewController" bundle:nil];
                break;
            }
            case 7://@"原生开屏（6.1）"
            {
                detailViewController = [[TradPlusAdNativeSplashViewController alloc] initWithNibName:@"TradPlusAdNativeSplashViewController" bundle:nil];
                break;
            }
            case 8://@"原生开屏（6.1）"
            {
                detailViewController = [[TradPlusAdNativeBannerViewController alloc] initWithNibName:@"TradPlusAdNativeBannerViewController" bundle:nil];
                break;
            }
            case 9://@"横幅（6.4）"
            {
                detailViewController = [[TradPlusAdBannerViewController alloc] initWithNibName:@"TradPlusAdBannerViewController" bundle:nil];
                break;
            }
            case 10://@"插屏（6.4）"
            {
                detailViewController = [[TradPlusAdInterstitialViewController alloc] initWithNibName:@"TradPlusAdInterstitialViewController" bundle:nil];
                break;
            }
            case 11://@"激励视频（6.4）"
            {
                detailViewController = [[TradPlusAdRewardedViewController alloc] initWithNibName:@"TradPlusAdRewardedViewController" bundle:nil];
                break;
            }
            case 12://@"开屏（6.4）"
            {
                detailViewController = [[TradPlusAdSplashViewController alloc] initWithNibName:@"TradPlusAdSplashViewController" bundle:nil];
                break;
            }
        }
        if(detailViewController != nil)
        {
            detailViewController.modalPresentationStyle = UIModalPresentationFullScreen;
            [self.navigationController pushViewController:detailViewController animated:YES];
        }
    }
}


@end
