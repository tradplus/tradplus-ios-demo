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

@interface MsADTableViewController ()

@end

@implementation MsADTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:0.21 green:0.21 blue:0.21 alpha:1];
    self.tableView.separatorColor = [UIColor colorWithRed:0.31 green:0.31 blue:0.31 alpha:1];
    self.tableView.rowHeight = 50;
    self.tableView.sectionHeaderHeight = 30;
    
    //self.title = @"Ads";
    self.tableView.accessibilityLabel = @"Ad Table View";
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
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"横幅";
            break;
        case 1:
            cell.textLabel.text = @"高级原生";
            break;
        case 2:
            cell.textLabel.text = @"高级原生(并发拉取多个素材)";
            break;
        case 3:
            cell.textLabel.text = @"插屏";
            break;
        case 4:
            cell.textLabel.text = @"激励视频";
            break;
        case 5:
            cell.textLabel.text = @"积分墙";
            break;
        default:
            break;
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
    UIViewController *detailViewController = nil;
    switch (indexPath.section) {
        case 0:
            switch (indexPath.row) {
                case 0:
                    detailViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"b"];
                    detailViewController.modalPresentationStyle = UIModalPresentationFullScreen;
                    [self.navigationController pushViewController:detailViewController animated:YES];
                    break;
                case 1:
                    detailViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"n"];
                    ((NativeViewController *)detailViewController).nativeADType = MsNativeADTypeAdvanced;
                    detailViewController.modalPresentationStyle = UIModalPresentationFullScreen;
                    [self.navigationController pushViewController:detailViewController animated:YES];
                    break;
                case 2:
                    detailViewController = [[NativeHTViewController alloc] initWithNibName:@"NativeHTViewController" bundle:nil];
                    detailViewController.modalPresentationStyle = UIModalPresentationFullScreen;
                    [self presentViewController:detailViewController animated:YES completion:nil];
                    break;
                case 3:
                {
                    detailViewController = [[InterstitialViewController alloc] initWithNibName:@"InterstitialViewController" bundle:nil];
                    detailViewController.modalPresentationStyle = UIModalPresentationFullScreen;
                    [self presentViewController:detailViewController animated:YES completion:nil];
                }
                    break;
                case 4:
                {
                    detailViewController = [[RewardedVideoViewController alloc] initWithNibName:@"RewardedVideoViewController" bundle:nil];
                    detailViewController.modalPresentationStyle = UIModalPresentationFullScreen;
                    [self presentViewController:detailViewController animated:YES completion:nil];
                }
                    break;
                case 5:
                {
                    detailViewController = [[OfferwallViewController alloc] initWithNibName:@"OfferwallViewController" bundle:nil];
                    detailViewController.modalPresentationStyle = UIModalPresentationFullScreen;
                    [self presentViewController:detailViewController animated:YES completion:nil];
                }
                    break;
                default:
                    break;
            }
            break;
           
        default:
            break;
    }
}


@end
