//
//  MediaVideoManager.m
//  TradPlusDemo
//
//  Created by xuejun on 2023/3/2.
//  Copyright © 2023 tradplus. All rights reserved.
//

#import "MediaVideoManager.h"

@interface MediaVideoManager()<TradPlusADMediaVideoDelegate>

@property (nonatomic,strong)TradPlusAdMediaVideo *mediaVideo;
@end

@implementation MediaVideoManager

+(MediaVideoManager *)sharedInstance
{
    static MediaVideoManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[MediaVideoManager alloc] init];
    });
    return manager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.mediaVideo = [[TradPlusAdMediaVideo alloc] init];
        [self.mediaVideo setAdUnitID:@"77FDC4373C4B39A0D8F820E31B9069DB"];
        self.mediaVideo.delegate = self;
    }
    return self;
}

#pragma mark - TradPlusADMediaVideoDelegate

///AD加载完成 首个广告源加载成功时回调 一次加载流程只会回调一次
- (void)tpMediaVideoAdLoaded:(NSDictionary *)adInfo
{
    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
    if(self.loadFinish)
    {
        self.loadFinish();
    }
}

///AD加载失败
///tpMediaVideoAdOneLayerLoad:didFailWithError：返回三方源的错误信息
- (void)tpMediaVideoAdLoadFailWithError:(NSError *)error
{
    NSLog(@"%s error:%@", __FUNCTION__ ,error);
}

///AD播放开始
- (void)tpMediaVideoAdStart:(NSDictionary *)adInfo
{
    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
    if(self.starPlay)
    {
        self.starPlay();
    }
}

///AD播放失败
- (void)tpMediaVideoAdError:(NSDictionary *)adInfo error:(NSError *)error
{
    NSLog(@"%s \n%@ error:%@", __FUNCTION__ ,adInfo,error);
}

///AD被点击
- (void)tpMediaVideoAdClicked:(NSDictionary *)adInfo
{
    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
}

///播放结束
- (void)tpMediaVideoAdEnd:(NSDictionary *)adInfo
{
    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
    if(self.playFinish)
    {
        self.playFinish();
    }
}

///开始加载流程
- (void)tpMediaVideoAdStartLoad:(NSDictionary *)adInfo
{
    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
}

///当每个广告源开始加载时会都会回调一次。
- (void)tpMediaVideoAdOneLayerStartLoad:(NSDictionary *)adInfo
{
    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
}

///调用load之后如果收到此回调，说明广告位仍处于加载状态，无法触发新的一轮广告加载。
- (void)tpMediaVideoAdIsLoading:(NSDictionary *)adInfo
{
    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
}

///当每个广告源加载成功后会都会回调一次。
- (void)tpMediaVideoAdOneLayerLoaded:(NSDictionary *)adInfo
{
    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
}

///当每个广告源加载失败后会都会回调一次，返回三方源的错误信息
- (void)tpMediaVideoAdOneLayerLoad:(NSDictionary *)adInfo didFailWithError:(NSError *)error
{
    NSLog(@"%s \n%@ error:%@", __FUNCTION__ ,adInfo,error);
}

///加载流程全部结束
- (void)tpMediaVideoAdAllLoaded:(BOOL)success
{
    NSLog(@"%s %@", __FUNCTION__ ,@(success));
}

///广告的播放进度
- (void)tpMediaVideoAdDidProgress:(NSDictionary *)adInfo mediaTime:(NSTimeInterval)mediaTime totalTime:(NSTimeInterval)totalTime
{
    NSLog(@"%s mediaTime:%@ totalTime:%@", __FUNCTION__ ,@(mediaTime),@(totalTime));
}

///暂停播放
- (void)tpMediaVideoAdPause:(NSDictionary *)adInfo
{
    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
}

///继续播放
- (void)tpMediaVideoAdResume:(NSDictionary *)adInfo
{
    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
}

///跳过
- (void)tpMediaVideoAdSkiped:(NSDictionary *)adInfo
{
    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
}

///点击
- (void)tpMediaVideoAdTapped:(NSDictionary *)adInfo
{
    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
}
@end
