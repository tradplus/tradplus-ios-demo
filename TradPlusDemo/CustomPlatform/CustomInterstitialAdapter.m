//
//  CustomInterstitialAdapter.m
//  TradPlusDemo
//
//  Created by xuejun on 2021/9/6.
//  Copyright © 2021 TradPlus. All rights reserved.
//

#import "CustomInterstitialAdapter.h"
#import <TradPlusAds/TradPlusAdWaterfallItem.h>
#import <GoogleMobileAds/GoogleMobileAds.h>
#import <TradPlusAds/MSConsentManager.h>

@interface CustomInterstitialAdapter ()<GADFullScreenContentDelegate>

@property (nonatomic,strong)GADInterstitialAd *interstitialAd;
@end

@implementation CustomInterstitialAdapter

//初始化自定义平台，设置平台参数（海外平台的隐私设置）加载广告
- (void)loadAdWithWaterfallItem:(TradPlusAdWaterfallItem *)item
{
    //通过 item.config 获取后台配置信息
    NSString *placementId = item.config[@"placementId"];
    if(placementId == nil)
    {
        //配置错误
        [self AdConfigError];
        return;
    }
    GADRequest *request = [GADRequest request];
    //设置GDPR
    if (![MSConsentManager sharedManager].canCollectPersonalInfo)
    {
        GADExtras *extras = [[GADExtras alloc] init];
        extras.additionalParameters = @{@"npa": @"1"};
        [request registerAdNetworkExtras:extras];
    }
    __weak typeof(self) weakSelf = self;
    [GADInterstitialAd loadWithAdUnitID:placementId request:request completionHandler:^(GADInterstitialAd * _Nullable interstitialAd, NSError * _Nullable error) {
        if(error == nil)
        {
            weakSelf.interstitialAd = interstitialAd;
            //加载成功
            [weakSelf AdLoadFinsh];
        }
        else
        {
            //加载失败
            [weakSelf AdLoadFailWithError:error];
        }
    }];
}

//展示广告
- (void)showAdFromRootViewController:(UIViewController *)rootViewController
{
    NSError *error;
    if([self.interstitialAd canPresentFromRootViewController:rootViewController error:&error])
    {
        self.interstitialAd.fullScreenContentDelegate = self;
        [self.interstitialAd presentFromRootViewController:rootViewController];
    }
    else
    {
        //展示失败
        [self AdShowFailWithError:error];
    }
}

//此方法用于返回是否过期状态
- (BOOL)isReady
{
    return (self.interstitialAd != nil);
}

#pragma mark - GADFullScreenContentDelegate
- (void)adDidRecordImpression:(nonnull id<GADFullScreenPresentingAd>)ad
{
    //广告展示
    [self AdShow];
}

- (void)adDidRecordClick:(nonnull id<GADFullScreenPresentingAd>)ad
{
    //广告点击
    [self AdClick];
}

- (void)ad:(nonnull id<GADFullScreenPresentingAd>)ad
    didFailToPresentFullScreenContentWithError:(nonnull NSError *)error
{
    //广告展示失败
    [self AdShowFailWithError:error];
}

- (void)adDidDismissFullScreenContent:(nonnull id<GADFullScreenPresentingAd>)ad
{
    //广告关闭
    [self AdClose];
}

- (void)adDidPresentFullScreenContent:(nonnull id<GADFullScreenPresentingAd>)ad
{
}

- (void)adWillDismissFullScreenContent:(nonnull id<GADFullScreenPresentingAd>)ad
{
    
}
@end
