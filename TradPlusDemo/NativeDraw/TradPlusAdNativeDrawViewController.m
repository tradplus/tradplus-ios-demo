//
//  TradPlusAdNativeDrawViewController.m
//  TradPlusDemo
//
//  Created by xuejun on 2022/1/17.
//  Copyright © 2022 tradplus. All rights reserved.
//

#import "TradPlusAdNativeDrawViewController.h"
#import <TradPlusAds/TradPlusAdNative.h>
#import "NativeDrawListViewController.h"
#import "NativeGDTDrawListViewController.h"

@interface TradPlusAdNativeDrawViewController ()<TradPlusADNativeDelegate>

@property (nonatomic,weak)IBOutlet UILabel *logLabel;
@property (nonatomic,strong)TradPlusAdNativeObject *nativeObject;
@property (nonatomic,strong)TradPlusAdNative *nativeAd;
@end

@implementation TradPlusAdNativeDrawViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.nativeAd = [[TradPlusAdNative alloc] init];
    [self.nativeAd setAdUnitID:@"0C7A52DD779529F567E62EA5D5B60A0D"];
    self.nativeAd.delegate = self;
}

- (IBAction)loadAct:(id)sender
{
    //加载
    self.logLabel.text = @"开始加载";
    [self.nativeAd loadAd];
}

- (IBAction)showAct:(id)sender
{
    self.nativeObject = [self.nativeAd getReadyNativeObject];
    if(self.nativeObject != nil)
    {
        self.logLabel.text = @"";
        if(self.nativeObject.adType == TPNativeADTYPE_Draw)
        {
            if(self.nativeObject.channel_id == NETWORK_GDTMOB)
            {
                //腾讯Draw信息流是自渲染 参考NativeGDTDrawListViewController
                NativeGDTDrawListViewController *drawListViewController = [[NativeGDTDrawListViewController alloc] initWithNibName:@"NativeGDTDrawListViewController" bundle:nil];
                drawListViewController.nativeObject = self.nativeObject;
                [self.navigationController pushViewController:drawListViewController animated:YES];
            }
            else
            {
                //其他广告源讯Draw信息流都是模版类型
                NativeDrawListViewController *drawListViewController = [[NativeDrawListViewController alloc] initWithNibName:@"NativeDrawListViewController" bundle:nil];
                drawListViewController.drawList = [self.nativeObject getDrawList];
                [self.navigationController pushViewController:drawListViewController animated:YES];
            }
            return;
        }
    }
    self.logLabel.text = @"没有可展示的广告";
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
- (void)tpNativeAdBidEnd:(NSDictionary *)adInfo error:(NSError *)error
{
    NSLog(@"%s \n%@ \n error %@", __FUNCTION__ ,adInfo,error);
}

///AD被关闭 部分模版类型会返回相关回调
- (void)tpNativeAdClose:(NSDictionary *)adInfo
{
    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
}

@end
