//
//  TradPlusAdSplashViewController.m
//  TradPlusDemo
//
//  Created by xuejun on 2021/9/2.
//  Copyright © 2021 tradplus. All rights reserved.
//

#import "TradPlusAdSplashViewController.h"
#import <TradPlusAds/TradPlusAdSplash.h>

@interface TradPlusAdSplashViewController ()<TradPlusADSplashDelegate>
{
    
}

@property (nonatomic, strong) TradPlusAdSplash *splashAd;
@property (nonatomic,weak)IBOutlet UILabel *logLabel;
@property (nonatomic,weak)IBOutlet UIView *adView;
@end

@implementation TradPlusAdSplashViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.splashAd = [[TradPlusAdSplash alloc] init];
    self.splashAd.delegate = self;
    [self.splashAd setAdUnitID:@"E5BC6369FC7D96FD47612B279BC5AAE0"];
}

- (IBAction)loadAct:(id)sender
{
    //加载
    self.logLabel.text = @"开始加载";
    [self.splashAd loadAdWithWindow:[UIApplication sharedApplication].keyWindow bottomView:nil];
}

- (IBAction)showAct:(id)sender
{
    [self.splashAd show];
}


#pragma mark - TradPlusADNativeBannerDelegate

///AD加载完成
- (void)tpSplashAdLoaded:(NSDictionary *)adInfo
{
    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
    self.logLabel.text = @"加载成功";
}
///AD加载失败
- (void)tpSplashAdLoadFailWithError:(NSError *)error
{
    NSLog(@"%s \n%@", __FUNCTION__ ,error);
    self.logLabel.text = [NSString stringWithFormat:@"加载错误：%ld",(long)error.code];
}
///AD展现
- (void)tpSplashAdImpression:(NSDictionary *)adInfo
{
    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
}
///AD展现失败
- (void)tpSplashAdShow:(NSDictionary *)adInfo didFailWithError:(NSError *)error
{
    NSLog(@"%s \n%@ %@", __FUNCTION__ ,adInfo,error);
}
///AD被点击
- (void)tpSplashAdClicked:(NSDictionary *)adInfo
{
    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
}
///AD关闭
- (void)tpSplashAdDismissed:(NSDictionary *)adInfo
{
    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
    self.logLabel.text = @"";
}
///bidding开始
- (void)tpSplashAdBidStart:(NSDictionary *)adInfo
{
    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
}
///bidding结束
- (void)tpSplashAdBidEnd:(NSDictionary *)adInfo success:(BOOL)success
{
    NSLog(@"%s \n%@ success :%@", __FUNCTION__ ,adInfo,@(success));
}
///开始加载
- (void)tpSplashAdLoadStart:(NSDictionary *)adInfo
{
    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
}
//多缓存情况下，当每个广告源加载成功后会都会回调一次。
- (void)tpSplashAdOneLayerLoaded:(NSDictionary *)adInfo
{
    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
}
//多缓存情况下，当每个广告源加载失败后会都会回调一次。
- (void)tpSplashAdOneLayerLoad:(NSDictionary *)adInfo didFailWithError:(NSError *)error
{
    NSLog(@"%s \n%@ %@", __FUNCTION__ ,adInfo , error);
}
///加载流程全部结束
- (void)tpSplashAdAllLoaded:(BOOL)success
{
    NSLog(@"%s \n%@", __FUNCTION__ ,@(success));
}
@end