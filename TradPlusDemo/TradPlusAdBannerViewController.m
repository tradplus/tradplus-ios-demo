//
//  TradPlusAdBannerViewController.m
//  TradPlusDemo
//
//  Created by xuejun on 2021/9/2.
//  Copyright © 2021 tradplus. All rights reserved.
//

#import "TradPlusAdBannerViewController.h"
#import <TradPlusAds/TradPlusAdBanner.h>
#import "NativeBannerTemplate.h"

@interface TradPlusAdBannerViewController ()<TradPlusADBannerDelegate>
{
    BOOL isFirst;
}

@property (nonatomic,strong)TradPlusAdBanner *banner;
@property (nonatomic,weak)IBOutlet UILabel *logLabel;
@property (nonatomic,weak)IBOutlet UIView *adView;
@end

@implementation TradPlusAdBannerViewController

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
        self.banner = [[TradPlusAdBanner alloc] init];
        [self.banner setAdUnitID:@"6008C47DF1201CC875F2044E88FCD287"];
        self.banner.frame = self.adView.bounds;
        self.banner.delegate = self;
        [self.adView addSubview:self.banner];
        //关闭自动显示
//        self.banner.autoShow = NO;
        
//        //v8.4.0+ banner支持原生广告混用,可通过此API设置原生的自定义模版，不设置时会使用默认模版
//        self.banner.customRenderingViewClass = [NativeBannerTemplate class];
        
//        //自定义View设置方式
//        NativeBannerTemplate *adView = [[NSBundle mainBundle] loadNibNamed:@"NativeBannerTemplate" owner:self options:nil].lastObject;
//        adView.frame = self.adView.bounds;
//        TradPlusNativeRenderer *nativeRenderer = [[TradPlusNativeRenderer alloc] init];
//        [nativeRenderer setTitleLable:adView.titleLabel canClick:YES];
//        [nativeRenderer setTextLable:adView.textLabel canClick:YES];
//        [nativeRenderer setCtaLable:adView.ctaLabel canClick:YES];
//        [nativeRenderer setIconView:adView.iconImageView canClick:YES];
//        [nativeRenderer setAdChoiceImageView:adView.adChoiceImageView canClick:YES];
//        [nativeRenderer setAdView:adView canClick:YES];
//        //v8.4.0+ banner支持原生广告混用，可通过此API设置原生的自定义Renderer，不设置时会使用默认模版
//        self.banner.customRenderer = nativeRenderer;
        
    }
}

- (IBAction)loadAct:(id)sender
{
    //加载
    self.logLabel.text = @"开始加载";
    [self.banner loadAdWithSceneId:nil];
}

- (IBAction)showAct:(id)sender
{
    self.logLabel.text = @"";
    //展示前设置自定义透传信息
    NSInteger time = [[NSDate date] timeIntervalSince1970];
    self.banner.customAdInfo = @{@"act":@"Show",@"time":@(time)};
    [self.banner showWithSceneId:nil];
}


#pragma mark - TradPlusADBannerDelegate

- (UIViewController *)viewControllerForPresentingModalView
{
    return self;
}
///AD加载完成
- (void)tpBannerAdLoaded:(NSDictionary *)adInfo
{
    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
    self.logLabel.text = @"加载成功";
}
///AD加载失败
- (void)tpBannerAdLoadFailWithError:(NSError *)error
{
    NSLog(@"%s \n%@", __FUNCTION__ ,error);
    self.logLabel.text = [NSString stringWithFormat:@"加载错误：%ld",(long)error.code];
}
///AD展现
- (void)tpBannerAdImpression:(NSDictionary *)adInfo
{
    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
}
///AD展现失败
- (void)tpBannerAdShow:(NSDictionary *)adInfo didFailWithError:(NSError *)error
{
    NSLog(@"%s \n%@ %@", __FUNCTION__ ,adInfo,error);
    self.logLabel.text = [NSString stringWithFormat:@"展现失败：%ld",(long)error.code];
}
///AD被点击
- (void)tpBannerAdClicked:(NSDictionary *)adInfo
{
    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
}
///bidding开始
- (void)tpBannerAdBidStart:(NSDictionary *)adInfo
{
    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
}
///bidding结束
- (void)tpBannerAdBidEnd:(NSDictionary *)adInfo error:(NSError *)error
{
    NSLog(@"%s \n%@ error :%@", __FUNCTION__ ,adInfo,error);
}

///v7.6.0+新增 开始加载流程
- (void)tpBannerAdStartLoad:(NSDictionary *)adInfo
{
    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
}

///当每个广告源开始加载时会都会回调一次。
///v7.6.0+新增。替代原回调接口：tpBannerAdLoadStart:(NSDictionary *)adInfo;
- (void)tpBannerAdOneLayerStartLoad:(NSDictionary *)adInfo
{
    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
}

//多缓存情况下，当每个广告源加载成功后会都会回调一次。
- (void)tpBannerAdOneLayerLoaded:(NSDictionary *)adInfo
{
    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
}
//多缓存情况下，当每个广告源加载失败后会都会回调一次。
- (void)tpBannerAdOneLayerLoad:(NSDictionary *)adInfo didFailWithError:(NSError *)error
{
    NSLog(@"%s \n%@ %@", __FUNCTION__ ,adInfo , error);
}
///加载流程全部结束
- (void)tpBannerAdAllLoaded:(BOOL)success
{
    NSLog(@"%s \n%@", __FUNCTION__ ,@(success));
}
//用户主动关闭是时的回调 GDTMOB Pangle(需要自行处理)
- (void)tpBannerAdClose:(NSDictionary *)adInfo
{
    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
}
@end
