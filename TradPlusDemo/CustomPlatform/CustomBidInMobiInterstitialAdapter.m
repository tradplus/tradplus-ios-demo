

#import "CustomBidInMobiInterstitialAdapter.h"
#import <TradPlusAds/MSLogging.h>
#import <TradPlusAds/MsCommon.h>
#import <TradPlusAds/TradPlusAdWaterfallItem.h>
#import <InMobiSDK/InMobiSDK.h>

@interface CustomBidInMobiInterstitialAdapter ()<IMInterstitialDelegate>

@property (nonatomic,strong)IMInterstitial *interstitial;
@property (nonatomic,copy)NSString *placementId;
@end

@implementation CustomBidInMobiInterstitialAdapter

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
    NSString *account_id = self.waterfallItem.config[@"account_id"];
    self.placementId = self.waterfallItem.config[@"placementId"];
    if(account_id == nil || [account_id isKindOfClass:[NSNull class]] || self.placementId == nil)
    {
        MSLogTrace(@"InMobi init Config Error %@",self.waterfallItem.config);
        [self AdConfigError];
        return;
    }
    //先进行三方SDK的初始化，如已初始化则可以不调用
    __weak typeof(self) weakSelf = self;
    [IMSdk initWithAccountID:account_id andCompletionHandler:^(NSError * _Nullable error) {
        [weakSelf startC2SBidding];
    }];
}

//通过三方API获取ECPM
- (void)startC2SBidding
{
    self.interstitial = [[IMInterstitial alloc] initWithPlacementId:[self.placementId longLongValue]];
    self.interstitial.delegate = self;
    [self.interstitial.preloadManager preload];
}

//获取ECPM成功
- (void)finishC2SBiddingWithMetaInfo:(IMAdMetaInfo*)info
{
    //三方版本号
    NSString *version = [IMSdk getVersion];
    if(version == nil)
    {
        version = @"";
    }
    //通过接口向TradPlusSDK回传ecpm和三方版本号
    NSString *ecpmStr = [NSString stringWithFormat:@"%f",info.getBid];
    NSDictionary *dic = @{@"ecpm":ecpmStr,@"version":version};
    [self ADLoadExtraCallbackWithEvent:@"C2SBiddingFinish" info:dic];
}

//获取ECPM失败
- (void)failC2SBiddingWithErrorStr:(NSString *)errorStr
{
    NSDictionary *dic = @{@"error":errorStr};
    [self ADLoadExtraCallbackWithEvent:@"C2SBiddingFail" info:dic];
}

//通过三方API加载广告
- (void)loadAdC2SBidding
{
    [self.interstitial.preloadManager load];
}

//展示
- (void)showAdFromRootViewController:(UIViewController *)rootViewController
{
    [self.interstitial showFrom:rootViewController];
}

- (BOOL)isReady
{
    return (self.interstitial != nil && self.interstitial.isReady);
}

#pragma mark - IMInterstitialDelegate

-(void)interstitial:(IMInterstitial*)interstitial didReceiveWithMetaInfo:(IMAdMetaInfo*)metaInfo
{
    //ECPM获取成功
    [self finishC2SBiddingWithMetaInfo:metaInfo];
}


-(void)interstitial:(IMInterstitial*)interstitial didFailToReceiveWithError:(NSError*)error
{
    //ECPM获取失败
    NSString *errorStr = @"C2S Bidding Fail";
    if(error != nil)
    {
        errorStr = [NSString stringWithFormat:@"errCode: %ld, errMsg: %@", (long)error.code, error.localizedDescription];
    }
    [self failC2SBiddingWithErrorStr:errorStr];
}

-(void)interstitialDidFinishLoading:(IMInterstitial*)interstitial
{
    //加载成功
    [self AdLoadFinsh];
}

-(void)interstitial:(IMInterstitial*)interstitial didFailToLoadWithError:(IMRequestStatus *)error
{
    //加载失败
    [self AdLoadFailWithError:error];
}

-(void)interstitialDidDismiss:(IMInterstitial*)interstitial
{
    //广告关闭
    [self AdClose];
}

-(void)interstitialAdImpressed:(IMInterstitial*)interstitial
{
    //展示成功
    [self AdShow];
}

-(void)interstitial:(IMInterstitial*)interstitial didFailToPresentWithError:(IMRequestStatus*)error
{
    //展示失败
    [self AdShowFailWithError:error];
}

-(void)interstitial:(IMInterstitial*)interstitial didInteractWithParams:(NSDictionary*)params
{
    //点击
    [self AdClick];
}

-(void)interstitialDidPresent:(IMInterstitial*)interstitial
{
    
}


-(void)interstitial:(IMInterstitial*)interstitial gotSignals:(NSData*)signals
{
    
}

-(void)interstitial:(IMInterstitial*)interstitial failedToGetSignalsWithError:(IMRequestStatus*)status
{
    
}

-(void)interstitialWillPresent:(IMInterstitial*)interstitial
{
    
}

-(void)interstitialWillDismiss:(IMInterstitial*)interstitial
{
    
}

-(void)userWillLeaveApplicationFromInterstitial:(IMInterstitial*)interstitial
{
    
}
@end
