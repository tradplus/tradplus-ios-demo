//
//  TradPlusAdRewardedViewController.m
//  TradPlusDemo
//
//  Created by xuejun on 2021/9/2.
//  Copyright © 2021 tradplus. All rights reserved.
//

#import "TradPlusAdRewardedViewController.h"
#import <TradPlusAds/TradPlusAdRewarded.h>

@interface TradPlusAdRewardedViewController ()<TradPlusADRewardedDelegate>
{
    
}

@property (nonatomic, strong) TradPlusAdRewarded *rewardedVideoAd;
@property (nonatomic,weak)IBOutlet UILabel *logLabel;
@property (nonatomic,weak)IBOutlet UIView *adView;
@end

@implementation TradPlusAdRewardedViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.rewardedVideoAd = [[TradPlusAdRewarded alloc] init];
    self.rewardedVideoAd.delegate = self;
    [self.rewardedVideoAd setAdUnitID:@"160AFCDF01DDA48CCE0DBDBE69C8C669"];
}

- (IBAction)loadAct:(id)sender
{
    //加载
    self.logLabel.text = @"开始加载";
    [self.rewardedVideoAd loadAd];
}

- (IBAction)showAct:(id)sender
{
    [self.rewardedVideoAd showAdFromRootViewController:self sceneId:nil];
}


#pragma mark - TradPlusADNativeBannerDelegate

///AD加载完成
- (void)tpRewardedAdLoaded:(NSDictionary *)adInfo
{
    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
    self.logLabel.text = @"加载成功";
}
///AD加载失败
- (void)tpRewardedAdLoadFailWithError:(NSError *)error
{
    NSLog(@"%s \n%@", __FUNCTION__ ,error);
    self.logLabel.text = [NSString stringWithFormat:@"加载错误：%ld",(long)error.code];
}
///AD展现
- (void)tpRewardedAdImpression:(NSDictionary *)adInfo
{
    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
}
///AD展现失败
- (void)tpRewardedAdShow:(NSDictionary *)adInfo didFailWithError:(NSError *)error
{
    NSLog(@"%s \n%@ %@", __FUNCTION__ ,adInfo,error);
}
///AD被点击
- (void)tpRewardedAdClicked:(NSDictionary *)adInfo
{
    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
}
///AD关闭
- (void)tpRewardedAdDismissed:(NSDictionary *)adInfo
{
    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
    self.logLabel.text = @"";
}
///完成奖励
- (void)tpRewardedAdReward:(NSDictionary *)adInfo
{
    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
}
///bidding开始
- (void)tpRewardedAdBidStart:(NSDictionary *)adInfo
{
    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
}
///bidding结束
- (void)tpRewardedAdBidEnd:(NSDictionary *)adInfo success:(BOOL)success
{
    NSLog(@"%s \n%@ success :%@", __FUNCTION__ ,adInfo,@(success));
}
///开始加载
- (void)tpRewardedAdLoadStart:(NSDictionary *)adInfo
{
    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
}
//多缓存情况下，当每个广告源加载成功后会都会回调一次。
- (void)tpRewardedAdOneLayerLoaded:(NSDictionary *)adInfo
{
    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
}
//多缓存情况下，当每个广告源加载失败后会都会回调一次。
- (void)tpRewardedAdOneLayerLoad:(NSDictionary *)adInfo didFailWithError:(NSError *)error
{
    NSLog(@"%s \n%@ %@", __FUNCTION__ ,adInfo , error);
}
///加载流程全部结束
- (void)tpRewardedAdAllLoaded:(BOOL)success
{
    NSLog(@"%s \n%@", __FUNCTION__ ,@(success));
}
///开始播放
- (void)tpRewardedAdPlayStart:(NSDictionary *)adInfo
{
    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
}
///播放结束
- (void)tpRewardedAdPlayEnd:(NSDictionary *)adInfo
{
    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
}
@end
