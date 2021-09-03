//
//  TradPlusAdNativeBannerViewController.m
//  TradPlusDemo
//
//  Created by xuejun on 2021/9/2.
//  Copyright © 2021 tradplus. All rights reserved.
//

#import "TradPlusAdNativeBannerViewController.h"
#import <TradPlusAds/TradPlusNativeBanner.h>
#import "NativeBannerTemplate.h"

@interface TradPlusAdNativeBannerViewController ()<TradPlusADNativeBannerDelegate>
{
    BOOL isFirst;
}

@property (nonatomic,strong)TradPlusNativeBanner *nativeBanner;
@property (nonatomic,weak)IBOutlet UILabel *logLabel;
@property (nonatomic,weak)IBOutlet UIView *adView;
@end

@implementation TradPlusAdNativeBannerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    isFirst = YES;
}

- (void)viewDidAppear:(BOOL)animated
{
    if(isFirst)
    {
        isFirst = NO;
        self.nativeBanner = [[TradPlusNativeBanner alloc] init];
        [self.nativeBanner setAdUnitID:@"155C125DB9289B5D17791AE0F8F1E92F"];
        self.nativeBanner.frame = self.adView.bounds;
        self.nativeBanner.delegate = self;
        [self.adView addSubview:self.nativeBanner];
        
        //指定模版方式需要 指定view方式 关闭自动显示
//        self.nativeBanner.autoShow = NO;
    }
}

- (IBAction)loadAct:(id)sender
{
    //加载
    self.logLabel.text = @"开始加载";
    [self.nativeBanner loadAdWithSceneId:nil];
}

- (IBAction)showAct:(id)sender
{
    [self.nativeBanner showWithSceneId:nil];
    
    //自定义模版方式 需要关闭自动显示
    //在load之前设置 self.nativeBanner.autoShow = NO;
//    [self.nativeBanner showWithRenderingViewClass:[NativeBannerTemplate class] sceneId:nil];
    
    //自定义view方式 需要关闭自动显示
    //在load之前设置 self.nativeBanner.autoShow = NO;
//    [self showWithRenderer];
}

//通过设置 NativeRenderer 来渲染
- (void)showWithRenderer
{
    //支持任何UIView 无需支持任何协议
    NativeBannerTemplate *adView = [[NSBundle mainBundle] loadNibNamed:@"NativeBannerTemplate" owner:self options:nil].lastObject;
    adView.frame = self.adView.bounds;
    TradPlusNativeRenderer *nativeRenderer = [[TradPlusNativeRenderer alloc] init];
    [nativeRenderer setTitleLable:adView.titleLabel canClick:YES];
    [nativeRenderer setTextLable:adView.textLabel canClick:YES];
    [nativeRenderer setCtaLable:adView.ctaLabel canClick:YES];
    [nativeRenderer setIconView:adView.iconImageView canClick:YES];
    [nativeRenderer setAdChoiceImageView:adView.adChoiceImageView canClick:YES];
    [nativeRenderer setAdView:adView canClick:YES];
    [self.nativeBanner showWithRenderer:nativeRenderer sceneId:nil];
}


#pragma mark - TradPlusADNativeBannerDelegate
- (UIViewController *)viewControllerForPresentingModalView
{
    return self;
}
///AD加载完成
- (void)tpNativeBannerAdDidLoaded:(NSDictionary *)adInfo
{
    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
    self.logLabel.text = @"加载成功";
}
///AD加载失败
- (void)tpNativeBannerAdLoadFailWithError:(NSError *)error
{
    NSLog(@"%s \n%@", __FUNCTION__ ,error);
    self.logLabel.text = [NSString stringWithFormat:@"加载错误：%ld",(long)error.code];
}
///AD展现
- (void)tpNativeBannerAdImpression:(NSDictionary *)adInfo
{
    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
}
///AD展现失败
- (void)tpNativeBannerAdShow:(NSDictionary *)adInfo didFailWithError:(NSError *)error
{
    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
    self.logLabel.text = [NSString stringWithFormat:@"展现失败：%ld",(long)error.code];
}
///AD被点击
- (void)tpNativeBannerAdClicked:(NSDictionary *)adInfo
{
    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
}

///bidding开始
- (void)tpNativeBannerAdBidStart:(NSDictionary *)adInfo
{
    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
}
///bidding结束
- (void)tpNativeBannerAdBidEnd:(NSDictionary *)adInfo success:(BOOL)success
{
    NSLog(@"%s \n%@ \n success %@", __FUNCTION__ ,adInfo,@(success));
}
///开始加载
- (void)tpNativeBannerAdLoadStart:(NSDictionary *)adInfo
{
    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
}
//多缓存情况下，当每个广告源加载成功后会都会回调一次。
- (void)tpNativeBannerAdOneLayerLoaded:(NSDictionary *)adInfo
{
    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
}
//多缓存情况下，当每个广告源加载失败后会都会回调一次。
- (void)tpNativeBannerAdOneLayerLoad:(NSDictionary *)adInfo didFailWithError:(NSError *)error
{
    NSLog(@"%s \n%@ \n%@", __FUNCTION__ ,adInfo,error);
}
///加载流程全部结束
- (void)tpNativeBannerAdAllLoaded:(BOOL)success
{
    NSLog(@"%s \n success %@", __FUNCTION__ ,@(success));
}
@end
