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
    [self.nativeAd setAdUnitID:@"E8D198EBD7FDC4F8A725066C82D707E1"];
    self.nativeAd.delegate = self;
    //资源下载完成后再通知load完成
//    self.nativeAd.finishDownload = YES;
    //设置模版类型的基础尺寸
//    [self.nativeAd setTemplateRenderSize:CGSizeMake(320, 200)];
}

///部分三方源需要设置rootviewController smaato GDTMob kuaishou
- (UIViewController *)viewControllerForPresentingModalView
{
    return self;
}

- (IBAction)loadAct:(id)sender
{
    //加载
    self.logLabel.text = @"开始加载";
    [self.nativeAd loadAd];
}

- (IBAction)showAct:(id)sender
{
//    [self showWithRenderingViewClass];
    [self showWithRenderer];
    
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

///开始加载
- (void)tpNativeAdLoadStart:(NSDictionary *)adInfo
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
- (void)tpNativeAdBidEnd:(NSDictionary *)adInfo success:(BOOL)success
{
    NSLog(@"%s \n%@ \n success %@", __FUNCTION__ ,adInfo,@(success));
}

///AD被关闭 部分模版类型会返回相关回调
- (void)tpNativeAdClose:(NSDictionary *)adInfo
{
    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
}
@end
