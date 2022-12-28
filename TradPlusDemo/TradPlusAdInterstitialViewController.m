//
//  TradPlusAdInterstitialViewController.m
//  TradPlusDemo
//
//  Created by xuejun on 2021/9/2.
//  Copyright © 2021 tradplus. All rights reserved.
//

#import "TradPlusAdInterstitialViewController.h"
#import <TradPlusAds/TradPlusAdInterstitial.h>
#import <TradPlusAds/TradPlus.h>

@interface TradPlusAdInterstitialViewController ()<TradPlusADInterstitialDelegate>
{
    
}

@property (nonatomic,strong)TradPlusAdInterstitial *interstitial;
@property (nonatomic,weak)IBOutlet UILabel *logLabel;
@property (nonatomic,weak)IBOutlet UIView *adView;
@end

@implementation TradPlusAdInterstitialViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.interstitial = [[TradPlusAdInterstitial alloc] init];
    self.interstitial.delegate = self;
    [self.interstitial setAdUnitID:@"063265866B93A4C6F93D1DDF7BF7329B"];
    self.logLabel.text = @"加载中...";
}

- (IBAction)loadAct:(id)sender
{
    //加载
    self.logLabel.text = @"开始加载";
    [self.interstitial loadAd];
}

- (IBAction)showAct:(id)sender
{
    self.logLabel.text = @"";
    //展示前设置自定义透传信息
    NSInteger time = [[NSDate date] timeIntervalSince1970];
    self.interstitial.customAdInfo = @{@"act":@"Show",@"time":@(time)};
    [self.interstitial showAdWithSceneId:nil];
}


#pragma mark - TradPlusADInterstitialDelegate


- (void)tpInterstitialAdLoaded:(NSDictionary *)adInfo
{
    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
    self.logLabel.text = @"加载成功";
}
///AD加载失败
- (void)tpInterstitialAdLoadFailWithError:(NSError *)error
{
    NSLog(@"%s \n%@", __FUNCTION__ ,error);
    self.logLabel.text = [NSString stringWithFormat:@"加载错误：%ld",(long)error.code];
}
///AD展现
- (void)tpInterstitialAdImpression:(NSDictionary *)adInfo
{
    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
}
///AD展现失败
- (void)tpInterstitialAdShow:(NSDictionary *)adInfo didFailWithError:(NSError *)error
{
    NSLog(@"%s \n%@ %@", __FUNCTION__ ,adInfo,error);
}
///AD被点击
- (void)tpInterstitialAdClicked:(NSDictionary *)adInfo
{
    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
}
///AD关闭
- (void)tpInterstitialAdDismissed:(NSDictionary *)adInfo
{
    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
    self.logLabel.text = @"";
}
///bidding开始
- (void)tpInterstitialAdBidStart:(NSDictionary *)adInfo
{
    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
}
///bidding结束
- (void)tpInterstitialAdBidEnd:(NSDictionary *)adInfo error:(NSError *)error
{
    NSLog(@"%s \n%@ error :%@", __FUNCTION__ ,adInfo,error);
}

///v7.6.0+ 开始加载流程
- (void)tpInterstitialAdStartLoad:(NSDictionary *)adInfo
{
    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
}

///当每个广告源开始加载时会都会回调一次。
///v7.6.0+新增。替代原回调接口：tpInterstitialAdLoadStart:(NSDictionary *)adInfo;
- (void)tpInterstitialAdOneLayerStartLoad:(NSDictionary *)adInfo
{
    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
}

//多缓存情况下，当每个广告源加载成功后会都会回调一次。
- (void)tpInterstitialAdOneLayerLoaded:(NSDictionary *)adInfo
{
    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
}
//多缓存情况下，当每个广告源加载失败后会都会回调一次。
- (void)tpInterstitialAdOneLayerLoad:(NSDictionary *)adInfo didFailWithError:(NSError *)error
{
    NSLog(@"%s \n%@ %@", __FUNCTION__ ,adInfo , error);
}
///加载流程全部结束
- (void)tpInterstitialAdAllLoaded:(BOOL)success
{
    NSLog(@"%s \n%@", __FUNCTION__ ,@(success));
}
///开始播放
- (void)tpInterstitialAdPlayStart:(NSDictionary *)adInfo
{
    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
}
///播放结束
- (void)tpInterstitialAdPlayEnd:(NSDictionary *)adInfo
{
    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
}
@end
