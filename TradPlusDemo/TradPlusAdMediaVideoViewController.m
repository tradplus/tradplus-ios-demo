//
//  TradPlusAdMediaVideoViewController.m
//  TradPlusDemo
//
//  Created by xuejun on 2023/3/2.
//  Copyright © 2023 tradplus. All rights reserved.
//

#import "TradPlusAdMediaVideoViewController.h"
#import <TradPlusAds/TradPlusAds.h>
#import "MediaVideoManager.h"
#import "TradPlusAdPreloadMediaVideoViewController.h"

@interface TradPlusAdMediaVideoViewController ()<TradPlusADMediaVideoDelegate>

@property (nonatomic,weak)IBOutlet UIView* bgView;
@property (nonatomic,weak)IBOutlet UILabel *infoLabel;
@property (nonatomic,strong)TradPlusAdMediaVideo *mediaVideo;
@property (nonatomic,strong)TradPlusMediaVideoAdObject *mediaVideoAdObject;
@end

@implementation TradPlusAdMediaVideoViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if(self.mediaVideoAdObject != nil)
    {
        [self.mediaVideoAdObject resume];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if(self.mediaVideoAdObject != nil)
    {
        [self.mediaVideoAdObject pause];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.mediaVideo = [[TradPlusAdMediaVideo alloc] init];
    [self.mediaVideo setAdUnitID:@"192A06B2C2923E7EEB653ADD823D4680"];
    self.mediaVideo.delegate = self;
}

- (IBAction)loadAct:(id)sender
{
    //绑定容器并加载
    self.infoLabel.text = @"加载中...";
    [self.mediaVideo loadAdWithRootViewController:self mute:NO];
}

- (IBAction)showAct:(id)sender
{
    self.infoLabel.text = @"";
    if([self.mediaVideo isAdReady])
    {
        //获取加载完成的 mediaVideoAdObject 对象
        self.mediaVideoAdObject = [self.mediaVideo getReadyMediaVideoObject];
        //展示广告
        if(self.mediaVideoAdObject.adView != nil)
        {
            self.mediaVideoAdObject.adView.hidden = NO;
            self.mediaVideoAdObject.adView.frame = self.bgView.bounds;
            [self.bgView addSubview:self.mediaVideoAdObject.adView];
            [self.mediaVideoAdObject startWithSceneId:nil];
        }
    }
}

//暂停
- (IBAction)pauseAct:(id)sender
{
    if(self.mediaVideoAdObject != nil)
    {
        [self.mediaVideoAdObject pause];
    }
}

//继续
- (IBAction)resumeAct:(id)sender
{
    if(self.mediaVideoAdObject != nil)
    {
        [self.mediaVideoAdObject resume];
    }
}

//销毁
- (IBAction)destoryAct:(id)sender
{
    if(self.mediaVideoAdObject != nil)
    {
        [self.mediaVideoAdObject destory];
    }
}

- (IBAction)preloadAct:(id)sender
{
    __weak typeof(self) weakSelf = self;
    [MediaVideoManager sharedInstance].loadFinish = ^{
        [weakSelf nextAct];
    };
    //预载容器需要添加到屏幕上才能进行加载
    [[MediaVideoManager sharedInstance].mediaVideo loadAdWithRootViewController:self mute:NO];
}

- (void)nextAct
{
    UIViewController *viewController = [[TradPlusAdPreloadMediaVideoViewController alloc] initWithNibName:@"TradPlusAdPreloadMediaVideoViewController" bundle:nil];
    [self.navigationController pushViewController:viewController animated:YES];
}

#pragma mark - TradPlusADMediaVideoDelegate

///AD加载完成 首个广告源加载成功时回调 一次加载流程只会回调一次
- (void)tpMediaVideoAdLoaded:(NSDictionary *)adInfo
{
    self.infoLabel.text = @"加载成功";
    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
}

///AD加载失败
///tpMediaVideoAdOneLayerLoad:didFailWithError：返回三方源的错误信息
- (void)tpMediaVideoAdLoadFailWithError:(NSError *)error
{
    self.infoLabel.text = @"加载失败";
    NSLog(@"%s error:%@", __FUNCTION__ ,error);
}

///AD播放开始
- (void)tpMediaVideoAdStart:(NSDictionary *)adInfo
{
    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
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
