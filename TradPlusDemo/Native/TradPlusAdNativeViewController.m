//
//  TradPlusAdNativeViewController.m
//  TradplusADDemo
//
//  Created by xuejun on 2021/8/11.
//

#import "TradPlusAdNativeViewController.h"
#import <TradPlusAds/TradPlusAdNative.h>
#import <TradPlusAds/MsCommon.h>
#import "TPNativeTemplate.h"
#import "AutoLayoutNativeTemplate.h"
#import "AutoLayoutNatvieRenderer.h"

@interface TradPlusAdNativeViewController ()<TradPlusADNativeDelegate>

@property (nonatomic,strong)TradPlusAdNative *nativeAd;
@property (nonatomic,weak)IBOutlet UILabel *logLabel;
@property (nonatomic,weak)IBOutlet UIView *adView;
@end

@implementation TradPlusAdNativeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.nativeAd = [[TradPlusAdNative alloc] init];
    self.nativeAd.delegate = self;
    [self.nativeAd setAdUnitID:@"E8D198EBD7FDC4F8A725066C82D707E1"];
    self.logLabel.text = @"加载中...";
    //设置是否需要自动加载
//    [self.nativeAd setAdUnitID:@"063265866B93A4C6F93D1DDF7BF7329B" isAutoLoad:BOOL]
    
    //资源下载完成后再通知load完成
//    self.nativeAd.finishDownload = YES;
    //设置模版类型的基础尺寸
//    [self.nativeAd setTemplateRenderSize:CGSizeMake(320, 200)];
}

- (IBAction)loadAct:(id)sender
{
    //加载
    self.logLabel.text = @"开始加载";
    [self.nativeAd loadAd];
}

- (IBAction)showAct:(id)sender
{
    self.logLabel.text = @"";
    //展示前设置自定义透传信息
    NSInteger time = [[NSDate date] timeIntervalSince1970];
    self.nativeAd.customAdInfo = @{@"act":@"Show",@"time":@(time)};
    //直接通过布局Class进行渲染
//    [self showWithRenderingViewClass];
    //通过自定义Renderer进行渲染
//    [self showWithRenderer];
    //自定义Renderer支持自动布局
    [self showWithAutoLayoutNatvie];
    
//    NSDictionary *adInfo = [self.nativeAd getReadyAdInfo];
//    //为空则说明没有广告
//    if(adInfo != nil)
//    {
        //可以通过以下两个字短判断是那个广告源
//        MSThirdNetwork thirdNetwork = (MSThirdNetwork)[adInfo[@"network_id"] integerValue];
//        NSString *adsource_name = adInfo[@"adsource_name"];
//        NSLog(@"%@ %u",adsource_name ,thirdNetwork);
//    }
    
}

//自动布局
- (void)showWithAutoLayoutNatvie
{
    TPNativeTemplate *adView = [[NSBundle mainBundle] loadNibNamed:@"AutoLayoutNativeTemplate" owner:self options:nil].lastObject;
    //AutoLayoutNatvieRenderer 中实现添加了自动布局相关代码
    AutoLayoutNatvieRenderer *nativeRenderer = [[AutoLayoutNatvieRenderer alloc] init];
    [nativeRenderer setTitleLable:adView.titleLabel canClick:YES];
    [nativeRenderer setTextLable:adView.textLabel canClick:YES];
    [nativeRenderer setCtaLable:adView.ctaLabel canClick:YES];
    [nativeRenderer setIconView:adView.iconImageView canClick:YES];
    [nativeRenderer setMainImageView:adView.mainImageView canClick:YES];
    [nativeRenderer setAdChoiceImageView:adView.adChoiceImageView canClick:YES];
    [nativeRenderer setAdView:adView canClick:YES];
    [self.nativeAd showADWithNativeRenderer:nativeRenderer subview:self.adView sceneId:nil];
}

//通过设置 RenderingViewClass 来渲染
- (void)showWithRenderingViewClass
{
    [self.nativeAd showADWithRenderingViewClass:[TPNativeTemplate class] subview:self.adView sceneId:nil];
}

//通过设置 NativeRenderer 来渲染
- (void)showWithRenderer
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
    [nativeRenderer setAdView:adView canClick:YES];
    [self.nativeAd showADWithNativeRenderer:nativeRenderer subview:self.adView sceneId:nil];
}

#pragma mark - TradPlusADNativeDelegate

///部分三方源需要设置rootviewController
- (UIViewController *)viewControllerForPresentingModalView
{
    return self;
}

///AD加载完成
- (void)tpNativeAdLoaded:(NSDictionary *)adInfo
{
    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
    self.logLabel.text = @"加载成功";
}

///AD加载失败
- (void)tpNativeAdLoadFailWithError:(NSError *)error
{
    NSLog(@"%s \n%@", __FUNCTION__ ,error);
    self.logLabel.text = [NSString stringWithFormat:@"加载错误：%ld",(long)error.code];
}

///v7.6.0+新增 开始加载流程
- (void)tpNativeAdStartLoad:(NSDictionary *)adInfo
{
    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
}

///当每个广告源开始加载时会都会回调一次。
///v7.6.0+新增。替代原回调接口：tpNativeAdLoadStart:(NSDictionary *)adInfo;
- (void)tpNativeAdOneLayerStartLoad:(NSDictionary *)adInfo
{
    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
}

//多缓存情况下，当每个广告源加载成功后会都会回调一次。
- (void)tpNativeAdOneLayerLoaded:(NSDictionary *)adInfo
{
    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
}

//多缓存情况下，当每个广告源加载失败后会都会回调一次。
- (void)tpNativeAdOneLayerLoad:(NSDictionary *)adInfo didFailWithError:(NSError *)error
{
    NSLog(@"%s \n%@ \n%@", __FUNCTION__ ,adInfo,error);
}

///加载流程全部结束
- (void)tpNativeAdAllLoaded:(BOOL)success
{
    NSLog(@"%s \n success %@", __FUNCTION__ ,@(success));
}
///AD展现
- (void)tpNativeAdImpression:(NSDictionary *)adInfo
{
    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
}
///AD展现失败
- (void)tpNativeAdShow:(NSDictionary *)adInfo didFailWithError:(NSError *)error
{
    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
    self.logLabel.text = [NSString stringWithFormat:@"展现失败：%ld",(long)error.code];
}

///AD被点击
- (void)tpNativeAdClicked:(NSDictionary *)adInfo
{
    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
}

///bidding开始
- (void)tpNativeAdBidStart:(NSDictionary *)adInfo
{
    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
}

///bidding结束
- (void)tpNativeAdBidEnd:(NSDictionary *)adInfo error:(NSError *)error
{
    NSLog(@"%s \n%@ \n error %@", __FUNCTION__ ,adInfo,error);
}

///AD被关闭 部分模版类型会返回相关回调
- (void)tpNativeAdClose:(NSDictionary *)adInfo
{
    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
}

///开始播放 v7.8.0+
- (void)tpNativeAdVideoPlayStart:(NSDictionary *)adInfo
{
    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
}

///播放结束 v7.8.0+
- (void)tpNativeAdVideoPlayEnd:(NSDictionary *)adInfo
{
    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
}
@end
