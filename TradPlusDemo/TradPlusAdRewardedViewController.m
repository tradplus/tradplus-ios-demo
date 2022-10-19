//
//  TradPlusAdRewardedViewController.m
//  TradPlusDemo
//
//  Created by xuejun on 2021/9/2.
//  Copyright © 2021 tradplus. All rights reserved.
//

#import "TradPlusAdRewardedViewController.h"
#import <TradPlusAds/TradPlusAdRewarded.h>

@interface TradPlusAdRewardedViewController ()<TradPlusADRewardedDelegate,TradPlusADRewardedPlayAgainDelegate>
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
    //v7.8.0新增
    self.rewardedVideoAd.playAgainDelegate = self;
    [self.rewardedVideoAd setAdUnitID:@"160AFCDF01DDA48CCE0DBDBE69C8C669"];
    self.logLabel.text = @"加载中...";
    //设置是否需要自动加载
//    [self.rewardedVideoAd setAdUnitID:@"063265866B93A4C6F93D1DDF7BF7329B" isAutoLoad:BOOL]
}

- (IBAction)loadAct:(id)sender
{
    //加载
    self.logLabel.text = @"开始加载";
    [self.rewardedVideoAd loadAd];
}

- (IBAction)showAct:(id)sender
{
    self.logLabel.text = @"";
    //展示前设置自定义透传信息
    NSInteger time = [[NSDate date] timeIntervalSince1970];
    self.rewardedVideoAd.customAdInfo = @{@"act":@"Show",@"time":@(time)};
    [self.rewardedVideoAd showAdWithSceneId:nil];
}


#pragma mark - TradPlusADRewardedDelegate

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
- (void)tpRewardedAdBidEnd:(NSDictionary *)adInfo error:(NSError *)error
{
    NSLog(@"%s \n%@ error :%@", __FUNCTION__ ,adInfo,error);
}
///v7.6.0+新增 开始加载流程
- (void)tpRewardedAdStartLoad:(NSDictionary *)adInfo
{
    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
}

///当每个广告源开始加载时会都会回调一次。
///v7.6.0+新增。替代原回调接口：tpRewardedAdLoadStart:(NSDictionary *)adInfo;
- (void)tpRewardedAdOneLayerStartLoad:(NSDictionary *)adInfo
{
    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
}

//当每个广告源加载成功后会都会回调一次。
- (void)tpRewardedAdOneLayerLoaded:(NSDictionary *)adInfo
{
    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
}
//当每个广告源加载失败后会都会回调一次。
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


#pragma mark - TradPlusADRewardedPlayAgainDelegate

///AD展现
- (void)tpRewardedAdPlayAgainImpression:(NSDictionary *)adInfo
{
    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
}

///AD展现失败
- (void)tpRewardedAdPlayAgainShow:(NSDictionary *)adInfo didFailWithError:(NSError *)error
{
    NSLog(@"%s \n%@ error:%@", __FUNCTION__ ,adInfo,error);
}

///AD被点击
- (void)tpRewardedAdPlayAgainClicked:(NSDictionary *)adInfo
{
    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
}

///完成奖励
- (void)tpRewardedAdPlayAgainReward:(NSDictionary *)adInfo
{
    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
}

///开始播放
- (void)tpRewardedAdPlayAgainPlayStart:(NSDictionary *)adInfo
{
    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
}

///播放结束
- (void)tpRewardedAdPlayAgainPlayEnd:(NSDictionary *)adInfo
{
    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
}
@end
