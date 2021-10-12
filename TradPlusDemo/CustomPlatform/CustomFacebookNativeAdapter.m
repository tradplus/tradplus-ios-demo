//
//  CustomFacebookNativeAdapter.m
//  TradPlusDemo
//
//  Created by xuejun on 2021/7/27.
//  Copyright © 2021 TradPlus. All rights reserved.
//

#import "CustomFacebookNativeAdapter.h"
#import <FBAudienceNetwork/FBAudienceNetwork.h>
#import <TradPlusAds/TradPlusAdWaterfallItem.h>

@interface CustomFacebookNativeAdapter()<FBNativeAdDelegate,FBNativeBannerAdDelegate>

@property (nonatomic,strong)FBNativeAd *nativeAd;
@property (nonatomic,strong)FBMediaView *mediaView;
@property (nonatomic,strong)FBMediaView *iconView;
@property (nonatomic,strong)FBAdOptionsView *adChoiceView;
@end

@implementation CustomFacebookNativeAdapter

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
    [FBAdSettings setDataProcessingOptions:@[@"LDU"] country:0 state:0];
    //设置coppa
    int coppa = (int)[[NSUserDefaults standardUserDefaults] integerForKey:gTPCOPPAStorageKey];
    if (coppa != 0)
    {
        [FBAdSettings setMixedAudience:coppa == 2];
    }
    self.nativeAd = [[FBNativeAd alloc] initWithPlacementID:placementId];
    self.nativeAd.delegate = self;
    [self.nativeAd loadAd];
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
    UIView *adView = viewInfo[kTPRendererAdView];
    //通过Facebook原生API注册
    [self.nativeAd registerViewForInteraction:adView
                                    mediaView:self.mediaView
                                     iconView:self.iconView
                               viewController:self.rootViewController
                               clickableViews:array];
    //按Facebook规则只需要进行注册操作，返回nil
    return nil;
}

#pragma mark - FBNativeAdDelegate
- (void)nativeAdDidLoad:(FBNativeAd *)nativeAd
{
    //加载成功流程
    if(self.nativeAd && self.nativeAd.isAdValid)
    {
        [self.nativeAd unregisterView];
    }
    self.nativeAd = nativeAd;
    //新建 TradPlusAdRes 并进行资源绑定
    TradPlusAdRes *res = [[TradPlusAdRes alloc] init];
    res.title = self.nativeAd.headline;
    res.body = self.nativeAd.bodyText;
    res.ctaText = self.nativeAd.callToAction;
    self.mediaView = [[FBMediaView alloc] init];
    res.mediaView = self.mediaView;
    self.iconView = [[FBMediaView alloc] init];
    res.iconView = self.iconView;
    self.adChoiceView = [[FBAdOptionsView alloc] init];
    self.adChoiceView.backgroundColor = [UIColor clearColor];
    self.adChoiceView.nativeAd = self.nativeAd;
    res.adChoiceView = self.adChoiceView;
    //模版类型只需要绑定 res.adView 
    //完成绑定，设置Res。用于TP SDK的原生界面渲染
    self.waterfallItem.adRes = res;
    //加载成功
    [self AdLoadFinsh];
}

- (void)nativeAd:(FBNativeAd *)nativeAd didFailWithError:(NSError *)error
{
    //加载失败
    [self AdLoadFailWithError:error];
}

- (void)nativeAdWillLogImpression:(FBNativeAd *)nativeAd
{
    //广告展示
    [self AdShow];
}

- (void)nativeAdDidClick:(FBNativeAd *)nativeAd
{
    //广告点击
    [self AdClick];
}
@end
