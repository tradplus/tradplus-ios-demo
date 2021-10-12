//
//  CustomSplashAdapter.m
//  TradPlusDemo
//
//  Created by xuejun on 2021/9/16.
//  Copyright © 2021 TradPlus. All rights reserved.
//

#import "CustomSplashAdapter.h"
#import <GoogleMobileAds/GoogleMobileAds.h>
#import <TradPlusAds/TradPlusAdWaterfallItem.h>
#import <TradPlusAds/MSConsentManager.h>

@interface CustomSplashAdapter ()<GADFullScreenContentDelegate>

@property (nonatomic,strong)GADAppOpenAd *appOpenAd;
@end

@implementation CustomSplashAdapter

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
    
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    
    __weak typeof(self) weakSelf = self;
    [GADAppOpenAd loadWithAdUnitID:placementId request:request orientation:orientation completionHandler:^(GADAppOpenAd * _Nullable appOpenAd, NSError * _Nullable error) {
        if(error == nil)
        {
            weakSelf.appOpenAd = appOpenAd;
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

//此方法用于返回是否过期状态
- (BOOL)isReady
{
    return (self.appOpenAd != nil);
}

//展示广告
- (void)showAdInWindow:(UIWindow *)window bottomView:(UIView *)bottomView
{
    UIViewController *rootViewController = window.rootViewController;
    NSError *error;
    if(rootViewController != nil && [self.appOpenAd canPresentFromRootViewController:rootViewController error:&error])
    {
        self.appOpenAd.fullScreenContentDelegate = self;
        [self.appOpenAd presentFromRootViewController:rootViewController];
    }
    else
    {
        //展示失败
        [self AdShowFailWithError:error];
    }
}

#pragma mark -GADFullScreenContentDelegate

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
