//
//  TradPlusAdNativeSplashViewController.m
//  TradPlusDemo
//
//  Created by xuejun on 2021/9/2.
//  Copyright © 2021 tradplus. All rights reserved.
//

#import "TradPlusAdNativeSplashViewController.h"
#import <TradPlusAds/TradPlusNativeSplash.h>
#import "TPNativeTemplate.h"

@interface TradPlusAdNativeSplashViewController ()<TradPlusADNativeSplashDelegate>

@property (nonatomic,strong)TradPlusNativeSplash *nativeSplash;
@property (nonatomic,weak)IBOutlet UILabel *logLabel;
@property (nonatomic,weak)IBOutlet UIView *adView;
@end

@implementation TradPlusAdNativeSplashViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.nativeSplash = [[TradPlusNativeSplash alloc] init];
    [self.nativeSplash setAdUnitID:@"D419D9382F530398374BA67E48A940C2"];
    self.nativeSplash.delegate = self;
}

- (IBAction)loadAct:(id)sender
{
    //加载
    self.logLabel.text = @"开始加载";
    [self.nativeSplash loadAd];
}

- (IBAction)showAct:(id)sender
{
    self.logLabel.text = @"";
    //展示前设置自定义透传信息
    NSInteger time = [[NSDate date] timeIntervalSince1970];
    self.nativeSplash.customAdInfo = @{@"act":@"Show",@"time":@(time)};
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [self.nativeSplash showInWindow:window];
    
    //自定义模版方式
//    [self.nativeSplash showWithRenderingViewClass:[TPNativeTemplate class] window:window];
    
    //自定义view方式
//    [self showWithRendererInWindow];
    
    
    //设置添加到指定view上 v6.4增加
//    [self.nativeSplash showInSubView:self.adView];
    
    //自定义模版方式
//    [self.nativeSplash showWithRenderingViewClass:[TPNativeTemplate class] subView:self.adView];
    
   //自定义view方式
//    [self showWithRendererInSubView];
}

//通过设置 NativeRenderer 来渲染 subView v6.4增加
- (void)showWithRendererInSubView
{
    //支持任何UIView 无需支持任何协议
    TPNativeTemplate *adView = [[NSBundle mainBundle] loadNibNamed:@"TPNativeTemplate" owner:self options:nil].lastObject;
    adView.frame = self.adView.bounds;
    [adView layoutIfNeeded];
    TradPlusNativeRenderer *nativeRenderer = [[TradPlusNativeRenderer alloc] init];
    [nativeRenderer setTitleLable:adView.titleLabel canClick:YES];
    [nativeRenderer setTextLable:adView.textLabel canClick:YES];
    [nativeRenderer setCtaLable:adView.ctaLabel canClick:YES];
    [nativeRenderer setIconView:adView.iconImageView canClick:YES];
    [nativeRenderer setMainImageView:adView.mainImageView canClick:YES];
    [nativeRenderer setAdChoiceImageView:adView.adChoiceImageView canClick:YES];
    [nativeRenderer setAdView:adView canClick:NO];
    [self.nativeSplash showWithRenderer:nativeRenderer subView:self.adView];
}

//通过设置 NativeRenderer 来渲染 InWindow
- (void)showWithRendererInWindow
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    //支持任何UIView 无需支持任何协议
    TPNativeTemplate *adView = [[NSBundle mainBundle] loadNibNamed:@"TPNativeTemplate" owner:self options:nil].lastObject;
    adView.frame = [UIScreen mainScreen].bounds;
    [adView layoutIfNeeded];
    TradPlusNativeRenderer *nativeRenderer = [[TradPlusNativeRenderer alloc] init];
    [nativeRenderer setTitleLable:adView.titleLabel canClick:YES];
    [nativeRenderer setTextLable:adView.textLabel canClick:YES];
    [nativeRenderer setCtaLable:adView.ctaLabel canClick:YES];
    [nativeRenderer setIconView:adView.iconImageView canClick:YES];
    [nativeRenderer setMainImageView:adView.mainImageView canClick:YES];
    [nativeRenderer setAdChoiceImageView:adView.adChoiceImageView canClick:YES];
    [nativeRenderer setAdView:adView canClick:YES];
    [self.nativeSplash showWithRenderer:nativeRenderer window:window];
}

#pragma mark - TradPlusADNativeSplashDelegate

- (UIViewController *)viewControllerForPresentingModalView
{
    return self;
}
///AD加载完成
- (void)tpNativeSplashAdDidLoaded:(NSDictionary *)adInfo
{
    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
    self.logLabel.text = @"加载成功";
}
///AD加载失败
- (void)tpNativeSplashAdLoadFailWithError:(NSError *)error
{
    NSLog(@"%s \n%@", __FUNCTION__ ,error);
    self.logLabel.text = [NSString stringWithFormat:@"加载错误：%ld",(long)error.code];
}
///AD展现
- (void)tpNativeSplashAdImpression:(NSDictionary *)adInfo
{
    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
}
///AD展现失败
- (void)tpNativeSplashAdShow:(NSDictionary *)adInfo didFailWithError:(NSError *)error
{
    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
    self.logLabel.text = [NSString stringWithFormat:@"展现失败：%ld",(long)error.code];
}
///AD被点击
- (void)tpNativeSplashAdClicked:(NSDictionary *)adInfo
{
    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
}
///关闭
- (void)tpNativeSplashAdClosed:(NSDictionary *)adInfo
{
    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
}

///bidding开始
- (void)tpNativeSplashAdBidStart:(NSDictionary *)adInfo
{
    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
}
///bidding结束
- (void)tpNativeSplashAdBidEnd:(NSDictionary *)adInfo error:(NSError *)error
{
    NSLog(@"%s \n%@ \n error %@", __FUNCTION__ ,adInfo,error);
}

///v7.6.0+新增 开始加载流程
- (void)tpNativeSplashAdStartLoad:(NSDictionary *)adInfo
{
    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
}

///当每个广告源开始加载时会都会回调一次。
///v7.6.0+新增。替代原回调接口：tpNativeSplashAdLoadStart:(NSDictionary *)adInfo;
- (void)tpNativeSplashAdOneLayerStartLoad:(NSDictionary *)adInfo
{
    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
}

//多缓存情况下，当每个广告源加载成功后会都会回调一次。
- (void)tpNativeSplashAdOneLayerLoaded:(NSDictionary *)adInfo
{
    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
}
//多缓存情况下，当每个广告源加载失败后会都会回调一次。
- (void)tpNativeSplashAdOneLayerLoad:(NSDictionary *)adInfo didFailWithError:(NSError *)error
{
    NSLog(@"%s \n%@ \n%@", __FUNCTION__ ,adInfo,error);
}
///加载流程全部结束
- (void)tpNativeSplashAdAllLoaded:(BOOL)success
{
    NSLog(@"%s \n success %@", __FUNCTION__ ,@(success));
}
///点击了跳过
- (void)tpNativeSplashAdClickSkip:(NSDictionary *)adInfo
{
    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
}
///跳过按钮显示
- (void)tpNativeSplashAdShowSkip:(NSDictionary *)adInfo
{
    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
}
///倒计时
- (void)tpNativeSplashAdCountDown:(NSDictionary *)adInfo progress:(NSInteger)progress
{
    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
}
@end
