#import "CustomBidBaiduInterstitialAdapter.h"
#import <TradPlusAds/MSLogging.h>
#import <TradPlusAds/MsCommon.h>
#import <TradPlusAds/TradPlusAdWaterfallItem.h>
#import <BaiduMobAdSDK/BaiduMobAdExpressInterstitial.h>
#import <BaiduMobAdSDK/BaiduMobAdExpressFullScreenVideo.h>

@interface CustomBidBaiduInterstitialAdapter ()<BaiduMobAdExpressFullScreenVideoDelegate>

@property (nonatomic,copy) NSString *appId;
@property (nonatomic,strong) BaiduMobAdExpressFullScreenVideo *expressFullscreenVideoAd;
@end

@implementation CustomBidBaiduInterstitialAdapter

#pragma mark - Extra
//根据event实现相关流程
- (BOOL)extraActWithEvent:(NSString *)event info:(NSDictionary *)config
{
    if([event isEqualToString:@"C2SBidding"])
    {
        //从三方SDK获取价格
        [self getECPMC2SBidding];
    }
    else if([event isEqualToString:@"LoadAdC2SBidding"])
    {
        //竞价成功后的加载流程
        [self loadAdC2SBidding];
    }
    else
    {
        return NO;
    }
    return YES;
}

#pragma mark - C2SBidding

//从三方SDK获取价格
- (void)getECPMC2SBidding
{
    [self loadAdWithWaterfallItem:self.waterfallItem];
}

//三方API确认广告是否有效
- (BOOL)isReady
{
    return self.expressFullscreenVideoAd.isReady;
}

//竞价成功后的加载流程
- (void)loadAdC2SBidding
{
    if([self isReady])
    {
        //由于在获取ECPM时已经成功加载广告，此时则直接返回加载成功
        [self AdLoadFinsh];
    }
    else
    {
        //广告无效时返回加载失败
        NSError *loadError = [NSError errorWithDomain:@"baidu.interstitial" code:404 userInfo:@{NSLocalizedDescriptionKey : @"C2S Interstitial not ready"}];
        [self AdLoadFailWithError:loadError];
    }
}

//获取ECPM成功
- (void)finishC2SBiddingWithEcpm:(NSString *)ecpmStr
{
    //三方版本号
    NSString *version = SDK_VERSION_IN_MSSP;
    if(version == nil)
    {
        version = @"";
    }
    if(ecpmStr == nil)
    {
        ecpmStr = @"0";
    }
    //通过接口向TradPlusSDK回传ecpm和三方版本号
    NSDictionary *dic = @{@"ecpm":ecpmStr,@"version":version};
    [self ADLoadExtraCallbackWithEvent:@"C2SBiddingFinish" info:dic];
}

//获取ECPM失败
- (void)failC2SBiddingWithErrorStr:(NSString *)errorStr
{
    NSDictionary *dic = @{@"error":errorStr};
    [self ADLoadExtraCallbackWithEvent:@"C2SBiddingFail" info:dic];
}

//通过三方SDK广告对象进行加载操作
- (void)loadAdWithWaterfallItem:(TradPlusAdWaterfallItem *)item
{
    self.appId = item.config[@"appId"];
    NSString *placementId = item.config[@"placementId"];
    if(placementId == nil || self.appId == nil)
    {
        [self AdConfigError];
        return;
    }
    self.expressFullscreenVideoAd = [[BaiduMobAdExpressFullScreenVideo alloc] init];
    self.expressFullscreenVideoAd.delegate = self;
    self.expressFullscreenVideoAd.AdUnitTag = placementId;
    self.expressFullscreenVideoAd.publisherId = self.appId;
    self.expressFullscreenVideoAd.adType = BaiduMobAdTypeFullScreenVideo;
    [self.expressFullscreenVideoAd load];
}

//展示插屏
- (void)showAdFromRootViewController:(UIViewController *)rootViewController
{
    [self.expressFullscreenVideoAd showFromViewController:rootViewController];
}

#pragma mark - BaiduMobAdInterstitialDelegate
- (NSString *)publisherId
{
    return self.appId;
}


#pragma mark - BaiduMobAdExpressFullScreenVideoDelegate

- (void)fullScreenVideoAdLoadFailCode:(NSString *)errCode message:(NSString *)message fullScreenAd:(BaiduMobAdExpressFullScreenVideo *)video
{
    //加载失败返回C2SBidding失败
    if(errCode == nil)
    {
        errCode = @"4001";
    }
    if(message == nil)
    {
        message = @"C2S Bidding Fail";
    }
    NSString *errorStr = [NSString stringWithFormat:@"errCode: %@, errMsg: %@", errCode, message];
    [self failC2SBiddingWithErrorStr:errorStr];
}

- (void)fullScreenVideoAdLoaded:(BaiduMobAdExpressFullScreenVideo *)video
{
    //加载成功并获取ECPM
    [self finishC2SBiddingWithEcpm:[video getECPMLevel]];
}

- (void)fullScreenVideoAdLoadFailed:(BaiduMobAdExpressFullScreenVideo *)video withError:(BaiduMobFailReason)reason
{
    //加载失败返回C2SBidding失败
    NSString *errorStr = [NSString stringWithFormat:@"C2S Bidding Fail code:%@",@(reason)];
    [self failC2SBiddingWithErrorStr:errorStr];
}

- (void)fullScreenVideoAdDidStarted:(BaiduMobAdExpressFullScreenVideo *)video
{
    //展示成功
    [self AdShow];
}

- (void)fullScreenVideoAdShowFailed:(BaiduMobAdExpressFullScreenVideo *)video withError:(BaiduMobFailReason)reason
{
    //展示失败
    NSString *strError = [NSString stringWithFormat:@"show fail, reason:%d", reason];
    NSError *error = [NSError errorWithDomain:@"Baidu" code:reason userInfo:@{NSLocalizedDescriptionKey: strError}];
    [self AdShowFailWithError:error];
}

- (void)fullScreenVideoAdDidClose:(BaiduMobAdExpressFullScreenVideo *)video withPlayingProgress:(CGFloat)progress
{
    //插屏关闭
    [self AdClose];
}

- (void)fullScreenVideoAdDidClick:(BaiduMobAdExpressFullScreenVideo *)video withPlayingProgress:(CGFloat)progress
{
    //插屏被点击
    [self AdClick];
}

- (void)fullScreenVideoAdLoadSuccess:(BaiduMobAdExpressFullScreenVideo *)video
{
    
}

- (void)fullScreenVideoAdDidPlayFinish:(BaiduMobAdExpressFullScreenVideo *)video
{
    
}

- (void)fullScreenVideoAdDidSkip:(BaiduMobAdExpressFullScreenVideo *)video withPlayingProgress:(CGFloat)progress
{
    
}
@end
