//
//  AppDelegate.m
//  fluteSDKSample
//
//  Created by ms-mac on 2017/3/23.
//  Copyright © 2017年 TradPlus. All rights reserved.
//

#import "AppDelegate.h"
#import <TradPlusAds/TradPlus.h>
#import <TradPlusAds/MSLogging.h>
#import <TradPlusAds/MsCommon.h>
#import <TradPlusAds/TPSplashAd.h>

@interface AppDelegate ()<TPSplashAdDelegate>
@property (nonatomic, strong) TPSplashAd *splashAd;

@end

@implementation AppDelegate

- (void)loadSplash
{
    if (!_splashAd)
    {
        _splashAd = [[TPSplashAd alloc] init];
        _splashAd.delegate = self;
        _splashAd.pangleBottomHeight = 110;
        [_splashAd setAdUnitID:@"E5BC6369FC7D96FD47612B279BC5AAE0"];
    }
    [_splashAd loadAd];
}

- (void)showSplash
{
    if (_splashAd && _splashAd.isAdReady)
    {
        CGRect frame = UIScreen.mainScreen.bounds;
        CGRect newframe = CGRectMake(0, frame.size.height - 110, frame.size.width, 110);
        UIView *view = [[UIView alloc] initWithFrame:newframe];
        view.backgroundColor = [UIColor blueColor];

        [_splashAd showSplashInWindow:[UIApplication sharedApplication].keyWindow withBottomView:view];
    }
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [TradPlus initSDK:@"TradPlus后台应用对应的appid" completionBlock:^(NSError * _Nonnull error) {
        if (!error)
        {
            //mFluteSDKInited = YES;
            MSLogInfo(@"flute sdk init success!");
        }
    }];

    [self loadSplash];
    return YES;
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
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark MsSplashViewDelegate
- (void)splashAdDidLoaded:(NSDictionary *)dicChannelInfo
{
    [self showSplash];
}
- (void)splashAd:(NSDictionary *)dicChannelInfo didFailedWithError:(NSError *)error
{
    
}
- (void)splashAdShown:(NSDictionary *)dicChannelInfo
{
    
}
- (void)splashAdFailToPlay:(NSDictionary *)dicChannelInfo error:(NSError *)error
{
    
}
- (void)splashAdClicked:(NSDictionary *)dicChannelInfo
{
    
}
- (void)splashAdDismissed:(NSDictionary *)dicChannelInfo
{
    
}

- (void)splashAdAllLoaded:(int)readyCount
{
    
}
- (void)splashAdOneLayerLoaded:(NSDictionary *)dicChannelInfo
{
    
}
- (void)splashAdOneLayer:(NSDictionary *)dicChannelInfo didFailWithError:(NSError *)error
{
    
}
- (void)splashAdBidStart:(NSDictionary *)dicChannelInfo
{
    
}
- (void)splashAdBidEnd:(NSDictionary *)dicChannelInfo
{
    
}
- (void)splashAdLoadStart:(NSDictionary *)dicChannelInfo
{
    
}
- (void)splashAdPlayStart:(NSDictionary *)dicChannelInfo
{
    
}
- (void)splashAdPlayEnd:(NSDictionary *)dicChannelInfo
{
    
}
@end
