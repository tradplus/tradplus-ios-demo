//
//  CustomNativeAdapter.m
//  TradPlusDemo
//
//  Created by xuejun on 2021/7/27.
//  Copyright © 2021 TradPlus. All rights reserved.
//

#import "CustomAdMobNativeAdapter.h"
#import <GoogleMobileAds/GoogleMobileAds.h>
#import <TradPlusAds/TradPlusAdWaterfallItem.h>
#import <TradPlusAds/MSConsentManager.h>

@interface CustomAdMobNativeAdapter()<GADAdLoaderDelegate,GADNativeAdLoaderDelegate,GADNativeAdDelegate>

@property (nonatomic,strong)GADAdLoader *adLoader;
@property (nonatomic,strong)GADNativeAd *nativeAd;
@property (nonatomic,strong)GADMediaView *mediaView;
@end

@implementation CustomAdMobNativeAdapter

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
    
    //设置ccpa
    int ccpa = (int)[[NSUserDefaults standardUserDefaults] integerForKey:gTPCCPAStorageKey];
    if (ccpa != 0)
        [NSUserDefaults.standardUserDefaults setBool:ccpa == 2 forKey:@"gad_rdp"];
    
    //设置coppa
    int coppa = (int)[[NSUserDefaults standardUserDefaults] integerForKey:gTPCOPPAStorageKey];
    if (coppa != 0)
        [GADMobileAds sharedInstance].requestConfiguration.tagForChildDirectedTreatment = @(coppa == 2);
    
    GADRequest *request = [GADRequest request];
    
    //设置GDPR
    if (![MSConsentManager sharedManager].canCollectPersonalInfo)
    {
        GADExtras *extras = [[GADExtras alloc] init];
        extras.additionalParameters = @{@"npa": @"1"};
        [request registerAdNetworkExtras:extras];
    }
    
    GADNativeAdImageAdLoaderOptions *nativeAdImageLoaderOptions =
          [[GADNativeAdImageAdLoaderOptions alloc] init];
    nativeAdImageLoaderOptions.shouldRequestMultipleImages = NO;
        
    GADNativeAdMediaAdLoaderOptions *nativeAdMediaAdLoaderOptions =
        [[GADNativeAdMediaAdLoaderOptions alloc] init];
    nativeAdMediaAdLoaderOptions.mediaAspectRatio = GADMediaAspectRatioAny;
    
    GADNativeAdViewAdOptions *nativeAdViewAdOptions = [[GADNativeAdViewAdOptions alloc] init];
    GADAdChoicesPosition pos = GADAdChoicesPositionTopRightCorner;
    nativeAdViewAdOptions.preferredAdChoicesPosition = pos;

    self.adLoader =
          [[GADAdLoader alloc] initWithAdUnitID:placementId
                             rootViewController:nil
                                        adTypes:@[ GADAdLoaderAdTypeNative ]
                                        options:@[ nativeAdImageLoaderOptions, nativeAdViewAdOptions, nativeAdMediaAdLoaderOptions ]];
    self.adLoader.delegate = self;
      
    [self.adLoader loadRequest:request];
}

//此方法用于返回是否过期状态
- (BOOL)isReady
{
    return (self.nativeAd != nil);
}

//自渲染类型，在渲染完成后在此方法中进行三方注册操作
//模版类型，不要实现此方法
- (UIView *)endRender:(NSDictionary *)viewInfo clickView:(NSArray *)array
{
    //按AdMob规则需要使用 GADNativeAdView 进行注册及展示
    GADNativeAdView *nativeAdView = [[GADNativeAdView alloc] init];
    nativeAdView.nativeAd = self.nativeAd;
    //广告视图
    if([viewInfo valueForKey:kTPRendererAdView])
    {
        UIView *view = viewInfo[kTPRendererAdView];
        nativeAdView.frame = view.bounds;
        [nativeAdView addSubview:view];
    }
    //广告标题
    if([viewInfo valueForKey:kTPRendererTitleLable])
    {
        UIView *view = viewInfo[kTPRendererTitleLable];
        nativeAdView.headlineView = view;
    }
    //广告描述
    if([viewInfo valueForKey:kTPRendererTextLable])
    {
        UIView *view = viewInfo[kTPRendererTextLable];
        nativeAdView.bodyView = view;
    }
    //广告按钮
    if([viewInfo valueForKey:kTPRendererCtaLabel])
    {
        UIView *view = viewInfo[kTPRendererCtaLabel];
        nativeAdView.callToActionView = view;
    }
    //广告图标
    if([viewInfo valueForKey:kTPRendererIconView])
    {
        UIView *view = viewInfo[kTPRendererIconView];
        nativeAdView.iconView = view;
    }
    //三方主视图
    if(self.mediaView != nil)
    {
        nativeAdView.mediaView = self.mediaView;
    }
    //返回Admob的GADNativeAdView
    return nativeAdView;
}

#pragma mark - GADAdLoaderDelegate
- (void)adLoader:(nonnull GADAdLoader *)adLoader
    didFailToReceiveAdWithError:(nonnull NSError *)error
{
    //加载失败
    [self AdLoadFailWithError:error];
}

#pragma mark - GADNativeAdLoaderDelegate
- (void)adLoader:(nonnull GADAdLoader *)adLoader didReceiveNativeAd:(nonnull GADNativeAd *)nativeAd
{
    //加载成功流程
    self.nativeAd = nativeAd;
    self.nativeAd.delegate = self;
    //新建 TradPlusAdRes 并进行资源绑定
    TradPlusAdRes *res = [[TradPlusAdRes alloc] init];
    res.title = self.nativeAd.headline;
    res.body = self.nativeAd.body;
    res.ctaText = self.nativeAd.callToAction;
    if(self.nativeAd.icon != nil)
    {
        res.iconImage = self.nativeAd.icon.image;
    }
    self.mediaView = [[GADMediaView alloc] init];
    self.mediaView.mediaContent = self.nativeAd.mediaContent;
    res.mediaView = self.mediaView;
    //模版类型只需要绑定 res.adView 
    //完成绑定，设置Res。用于TP SDK的原生界面渲染
    self.waterfallItem.adRes = res;
    //加载成功
    [self AdLoadFinsh];
}

#pragma mark - GADNativeAdDelegate

- (void)nativeAdDidRecordImpression:(nonnull GADNativeAd *)nativeAd;
{
    //广告展示
    [self AdShow];
}

- (void)nativeAdDidRecordClick:(nonnull GADNativeAd *)nativeAd
{
    //广告点击
    [self AdClick];
}
@end
