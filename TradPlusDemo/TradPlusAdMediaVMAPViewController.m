//
//  TradPlusAdMediaVMAPViewController.m
//  TradPlusDemo
//
//  Created by xuejun on 2023/10/8.
//  Copyright © 2023 tradplus. All rights reserved.
//

#import "TradPlusAdMediaVMAPViewController.h"
#import <TradPlusAds/TradPlusAds.h>
#import <AVFoundation/AVFoundation.h>
#import "VideoPlayhead.h"

@interface TradPlusAdMediaVMAPViewController ()<TradPlusADMediaVideoDelegate>

@property (nonatomic,weak)IBOutlet UIView* bgView;
@property (nonatomic,weak)IBOutlet UILabel *infoLabel;
@property (nonatomic,strong)TradPlusAdMediaVideo *mediaVideo;
@property (nonatomic,strong)TradPlusMediaVideoAdObject *mediaVideoObject;

@property (nonatomic,strong) AVPlayer *contentPlayer;
@property (nonatomic,strong) AVPlayerItem *playerItem;
@property (nonatomic,strong) AVPlayerLayer *contentPlayerLayer;
@property (nonatomic,assign)BOOL didLayoutSubviews;
@property (nonatomic,strong)VideoPlayhead *videoPlayhead;
@end

@implementation TradPlusAdMediaVMAPViewController

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    if(!self.didLayoutSubviews)
    {
        self.didLayoutSubviews = YES;
        self.contentPlayerLayer.frame = self.bgView.layer.bounds;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playFinish:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"video" ofType:@"mp4"];
    NSURL *contentURL = [NSURL fileURLWithPath:path];
    self.playerItem = [[AVPlayerItem alloc] initWithURL:contentURL];
    self.contentPlayer = [AVPlayer playerWithPlayerItem:self.playerItem];
    self.contentPlayerLayer = [AVPlayerLayer playerLayerWithPlayer:self.contentPlayer];
    [self.bgView.layer addSublayer:self.contentPlayerLayer];
    
    self.mediaVideo = [[TradPlusAdMediaVideo alloc] init];
    self.mediaVideo.delegate = self;
    [self.mediaVideo setAdUnitID:@"1099F8439751CD1D9647C7D1942CDA3F"];
    //设置 videoPlayhead
    self.videoPlayhead = [[VideoPlayhead alloc] init];
    self.mediaVideo.contentPlayhead = self.videoPlayhead;
    self.videoPlayhead.contentPlayer = self.contentPlayer;
}


- (void)playFinish:(NSNotification *)notification
{
    AVPlayerItem *notificationItem = (AVPlayerItem *)notification.object;
    if (notificationItem != self.playerItem)
    {
        return;
    }
    self.infoLabel.text = @"视频播放结束";
    //播放完成后调用 contentComplete 用于展示后贴
    if(self.mediaVideoObject != nil)
    {
        [self.mediaVideoObject contentComplete];
    }
}

-(IBAction)loadAct:(id)sender
{
    self.infoLabel.text = @"加载中...";
    [self.mediaVideo loadAd:self.bgView viewController:self mute:NO];
}

#pragma mark - TradPlusADMediaVideoDelegate

///AD加载完成 首个广告源加载成功时回调 一次加载流程只会回调一次
- (void)tpMediaVideoAdLoaded:(NSDictionary *)adInfo
{
    self.infoLabel.text = @"加载成功并展示";
    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
    self.mediaVideoObject  = [self.mediaVideo getReadyMediaVideoObject];
    IMAAd *ad = self.mediaVideoObject.getCustomNetworkObj;
    if(ad != nil)
    {
        NSLog(@"ad.duration %@",@(ad.duration));
        NSLog(@"ad.adPodInfo.totalAds %@",@(ad.adPodInfo.totalAds));
    }
    IMAAdsManager *manager = self.mediaVideoObject.getAdsManager;
    if(manager != nil)
    {
        NSLog(@"manager.adCuePoints %@",manager.adCuePoints);
    }
}

- (void)tpMediaVideoAdStart:(NSDictionary *)adInfo
{
    self.infoLabel.text = @"";
}

///AD加载失败
///tpMediaVideoAdOneLayerLoad:didFailWithError：返回三方源的错误信息
- (void)tpMediaVideoAdLoadFailWithError:(NSError *)error
{
    self.infoLabel.text = @"加载失败";
    NSLog(@"%s error:%@", __FUNCTION__ ,error);
}

/// 10.0.0新增 返回IMA RequestContentPause事件
- (void)tpMediaVideoAdRequestContentPause:(NSDictionary *)adInfo
{
    if(self.contentPlayer != nil)
    {
        [self.contentPlayer pause];
    }
}

/// 10.0.0新增 返回IMA RequestContentPause事件
- (void)tpMediaVideoAdRequestContentResume:(NSDictionary *)adInfo
{
    if(self.contentPlayer != nil)
    {
        [self.contentPlayer play];
    }
}

///播放结束
- (void)tpMediaVideoAdEnd:(NSDictionary *)adInfo
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
}


/// 10.0.0新增 返回IMA kIMAAdEvent_AD_BREAK_READY事件
- (void)tpMediaVideoAdBreakReady:(NSDictionary *)adInfo
{
    //收到AdBreakReady后调用start来展示广告
    if(self.mediaVideoObject != nil)
    {
        [self.mediaVideoObject start];
    }
}

- (void)tpMediaVideoAdEvent:(id)event adInfo:(NSDictionary *)adInfo
{
    IMAAdEvent *adEvent = event;
    if(adEvent != nil)
    {
        NSLog(@"%@" ,adEvent.typeString);
        if(adEvent.type == kIMAAdEvent_LOADED)
        {
            IMAAd *ad = self.mediaVideoObject.getCustomNetworkObj;
            if(ad != nil)
            {
                NSLog(@"ad.duration %@",@(ad.duration));
                NSLog(@"ad.adPodInfo.totalAds %@",@(ad.adPodInfo.totalAds));
            }
        }
        else if(adEvent.type == kIMAAdEvent_AD_BREAK_READY)
        {
            //tpMediaVideoAdBreakReady 相关逻辑也可以直接在这边处理
        }
        else if(adEvent.type == kIMAAdEvent_AD_BREAK_FETCH_ERROR)
        {
            
        }
    }
}

///暂停播放
- (void)tpMediaVideoAdPause:(NSDictionary *)adInfo
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

///继续播放
- (void)tpMediaVideoAdResume:(NSDictionary *)adInfo
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

///跳过
- (void)tpMediaVideoAdSkiped:(NSDictionary *)adInfo
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

///点击
- (void)tpMediaVideoAdTapped:(NSDictionary *)adInfo
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

///广告的播放进度
- (void)tpMediaVideoAdDidProgress:(NSDictionary *)adInfo mediaTime:(NSTimeInterval)mediaTime totalTime:(NSTimeInterval)totalTime
{
    
}

@end
