//
//  TradPlusAdSplashViewController.m
//  TradPlusDemo
//
//  Created by xuejun on 2021/9/2.
//  Copyright © 2021 tradplus. All rights reserved.
//

#import "TradPlusAdSplashViewController.h"
#import <TradPlusAds/TradPlusAdSplash.h>
#import "TPNativeTemplate.h"

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
    [self.splashAd setAdUnitID:@"7075DD1F6D9A184E40C6821CE2AD4488"];
    //设置
//    UIImage *image = [UIImage imageNamed:@"icon"];
//    self.splashAd.dicCustomValue = @{@"pangleGlobal_appIcon":image};
}

- (IBAction)loadAct:(id)sender
{
    //加载
    self.logLabel.text = @"开始加载";
    [self.splashAd loadAdWithWindow:[UIApplication sharedApplication].keyWindow bottomView:nil];
}

- (IBAction)showAct:(id)sender
{
    self.logLabel.text = @"";
    //展示前设置自定义透传信息
    NSInteger time = [[NSDate date] timeIntervalSince1970];
    self.splashAd.customAdInfo = @{@"act":@"Show",@"time":@(time)};
    [self.splashAd show];
    
//    //v8.4.0+ 开屏支持原生广告混用,可通过此API设置原生的自定义模版，不设置时会使用默认模版
//    [self.splashAd showWithRenderingViewClass:[TPNativeTemplate class]];
    
//    //自定义view方式
//    TPNativeTemplate *adView = [[NSBundle mainBundle] loadNibNamed:@"TPNativeTemplate" owner:self options:nil].lastObject;
//    adView.frame = [UIScreen mainScreen].bounds;
//    [adView layoutIfNeeded];
//    TradPlusNativeRenderer *nativeRenderer = [[TradPlusNativeRenderer alloc] init];
//    [nativeRenderer setTitleLable:adView.titleLabel canClick:YES];
//    [nativeRenderer setTextLable:adView.textLabel canClick:YES];
//    [nativeRenderer setCtaLable:adView.ctaLabel canClick:YES];
//    [nativeRenderer setIconView:adView.iconImageView canClick:YES];
//    [nativeRenderer setMainImageView:adView.mainImageView canClick:YES];
//    [nativeRenderer setAdChoiceImageView:adView.adChoiceImageView canClick:YES];
//    [nativeRenderer setAdView:adView canClick:YES];
//    //v8.4.0+ 开屏支持原生广告混用，可通过此API设置原生的自定义Renderer，不设置时会使用默认模版
//    [self.splashAd showWithRenderer:nativeRenderer];
}


#pragma mark - TradPlusADSplashDelegate

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
- (void)tpSplashAdBidEnd:(NSDictionary *)adInfo error:(NSError *)error
{
    NSLog(@"%s \n%@ error :%@", __FUNCTION__ ,adInfo,error);
}

///v7.6.0+新增 开始加载流程
- (void)tpSplashAdStartLoad:(NSDictionary *)adInfo
{
    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
}

///当每个广告源开始加载时会都会回调一次。
///v7.6.0+新增。替代原回调接口：tpSplashAdLoadStart:(NSDictionary *)adInfo;
- (void)tpSplashAdOneLayerStartLoad:(NSDictionary *)adInfo
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

//v8.1.0+新增 跳过
- (void)tpSplashAdSkip:(NSDictionary *)adInfo
{
    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
}
//v8.1.0+新增 点睛开始
- (void)tpSplashAdZoomOutViewShow:(NSDictionary *)adInfo
{
    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
}
//v8.1.0+新增 点睛关闭
- (void)tpSplashAdZoomOutViewClose:(NSDictionary *)adInfo
{
    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
}
@end
