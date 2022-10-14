//
//  AppDelegate.m
//  fluteSDKSample
//
//  Created by ms-mac on 2017/3/23.
//  Copyright © 2017年 TradPlus. All rights reserved.
//

#import "AppDelegate.h"
#import <TradPlusAds/TradPlus.h>
#import <TradPlusAds/TradPlusAdSplash.h>
#import <TradPlusAds/MSLogging.h>
#import <TradPlusAds/MsCommon.h>
#import <AppTrackingTransparency/AppTrackingTransparency.h>


@interface AppDelegate ()<TradPlusADSplashDelegate>

@property (nonatomic, strong) TradPlusAdSplash *splashAd;
@property (nonatomic, assign)BOOL isFirstSplashAd;
@property (nonatomic, assign)BOOL showSplash;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [TradPlus initSDK:@"75AA158112F1EFA29169E26AC63AFF94" completionBlock:^(NSError * _Nonnull error) {
        if (!error)
        {
            //mFluteSDKInited = YES;
            MSLogInfo(@"flute sdk init success!");
        }
    }];
    self.isFirstSplashAd = YES;
    [self initSplashAd];
    [self loadSplashAd];
    return YES;
}

- (void)initSplashAd
{
    self.splashAd = [[TradPlusAdSplash alloc] init];
    self.splashAd.delegate = self;
    [self.splashAd setAdUnitID:@"E5BC6369FC7D96FD47612B279BC5AAE0"];
}

- (void)loadSplashAd
{
    if(self.showSplash)
    {
        [self.splashAd loadAdWithWindow:self.window bottomView:nil];
    }
}

- (void)showSplashAd
{
    if(self.showSplash)
    {
        if(self.splashAd.isAdReady)
        {
            [self.splashAd show];
        }
    }
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    if (@available(iOS 14.5, *)) {
        [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus status) {
        }];
     }
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [self showSplashAd];
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


#pragma mark - TradPlusADSplashDelegate

///AD加载完成
- (void)tpSplashAdLoaded:(NSDictionary *)adInfo
{
    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
    if(self.isFirstSplashAd)
    {
        self.isFirstSplashAd = NO;
        [self showSplashAd];
    }
}
///AD加载失败
- (void)tpSplashAdLoadFailWithError:(NSError *)error
{
    NSLog(@"%s \n%@", __FUNCTION__ ,error);
    
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
    //关闭后提前加载缓存
    [self loadSplashAd];
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
