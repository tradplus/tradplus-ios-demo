//
//  CustomBannerAdapter.m
//  TradPlusDemo
//
//  Created by xuejun on 2021/8/25.
//  Copyright © 2021 TradPlus. All rights reserved.
//

#import "CustomBannerAdapter.h"
#import <TradPlusAds/TradPlusAdWaterfallItem.h>
#import <GoogleMobileAds/GoogleMobileAds.h>
#import <TradPlusAds/MSConsentManager.h>

@interface CustomBannerAdapter ()<GADBannerViewDelegate>

@property (nonatomic,strong)GADBannerView *bannerView;
@end

@implementation CustomBannerAdapter

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
    
    GADAdSize adSize = GADAdSizeBanner;
    self.bannerView = [[GADBannerView alloc] initWithAdSize:adSize];
    self.bannerView.adUnitID = placementId;
    self.bannerView.rootViewController = self.waterfallItem.bannerRootViewController;
    self.bannerView.delegate = self;
    
    GADRequest *request = [GADRequest request];
    //设置GDPR
    if (![MSConsentManager sharedManager].canCollectPersonalInfo)
    {
        GADExtras *extras = [[GADExtras alloc] init];
        extras.additionalParameters = @{@"npa": @"1"};
        [request registerAdNetworkExtras:extras];
    }
    //加载广告
    [self.bannerView loadRequest:request];
}

//此方法用于返回是否过期状态
- (BOOL)isReady
{
    return (self.bannerView != nil);
}

//返回加载完成后的横幅对象
- (id)getCustomObject
{
    return self.bannerView;
}

#pragma mark - GADBannerViewDelegate

- (void)bannerViewDidReceiveAd:(nonnull GADBannerView *)bannerView
{
    //加载完成
    [self AdLoadFinsh];
}

- (void)bannerView:(nonnull GADBannerView *)bannerView
    didFailToReceiveAdWithError:(nonnull NSError *)error
{
    //加载失败
    [self AdLoadFailWithError:error];
}

- (void)bannerViewDidRecordImpression:(nonnull GADBannerView *)bannerView
{
    //广告展示
    [self AdShow];
}

- (void)bannerViewDidRecordClick:(nonnull GADBannerView *)bannerView
{
    //广告点击
    [self AdClick];
}
@end
