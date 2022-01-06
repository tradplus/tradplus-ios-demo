//
//  RewardedVideoViewController.m
//  fluteSDKSample
//
//  Created by ms-mac on 2019/10/18.
//  Copyright © 2019 TradPlus. All rights reserved.
//

#import "RewardedVideoViewController.h"
#import <TradPlusAds/MsRewardedVideoAd.h>
#import <TradPlusAds/MsServerApi.h>

@interface RewardedVideoViewController ()<MsRewardedVideoAdDelegate>
@property (weak, nonatomic) IBOutlet UIButton *btnLoad;
@property (weak, nonatomic) IBOutlet UIButton *btnShow;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UITextView *textViewStatus;
@property (weak, nonatomic) IBOutlet UILabel *lblRewardInfo;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicatorView;
@property (weak, nonatomic) IBOutlet UILabel *lblCacheNum;

@property (nonatomic, strong) MsRewardedVideoAd *rewardedVideoAd;
@property (nonatomic, strong) NSString *placementId;
@end

@implementation RewardedVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _lblRewardInfo.text = @"";
    _lblCacheNum.text = @"";
    _placementId = @"160AFCDF01DDA48CCE0DBDBE69C8C669";
    self.rewardedVideoAd = [[MsRewardedVideoAd alloc] init];
    
    //设置isAutoLoad为YES 打开自动加载功能 后续不用再调用LoadAd方法
    [self.rewardedVideoAd setAdUnitID:_placementId isAutoLoad:YES];
    self.rewardedVideoAd.delegate = self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [self.activityIndicatorView startAnimating];
}

- (IBAction)btnLoadClick:(id)sender {
    [self.activityIndicatorView startAnimating];
    self.btnLoad.enabled = false;
    
    // Initiate the request to load the ad.
    [self.rewardedVideoAd loadAd];
}

- (IBAction)btnRefresh:(id)sender {
}

- (IBAction)btnBackClick:(id)sender {
    self.rewardedVideoAd.delegate = nil;
    self.rewardedVideoAd = nil;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)btnShowClick:(id)sender {
    if (self.rewardedVideoAd.isAdReady)
    {
    }
        [self.rewardedVideoAd showAdFromRootViewController:self];
        self.lblRewardInfo.text = @"";
        self.textView.text = [self.rewardedVideoAd getLoadDetailInfo];
//        if (self.rewardedVideoAd.readyAdCount < 2)
//            self.btnShow.enabled = NO;
}

- (void)doTimerRefreshState
{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.textView.text = [self.rewardedVideoAd getLoadDetailInfo];
        //self.btnShow.enabled = self.rewardedVideoAd.readyAdCount > 0;
    });
}

#pragma mark - MsRewardedVideoAdDelegate implementation

- (void)rewardedVideoAdAllLoaded:(int)readyCount
{
    NSLog(@"%s->ready:%d", __FUNCTION__, readyCount);
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
//    if (rewardedVideoAd.readyAdCount > 0)
//        self.btnShow.enabled = YES;
        weakSelf.btnLoad.enabled = YES;
        [weakSelf.activityIndicatorView stopAnimating];
        weakSelf.textView.text = [weakSelf.rewardedVideoAd getLoadDetailInfo];
    });
}


- (void)rewardedVideoAdDidLoaded:(NSDictionary *)dicChannelInfo
{
    NSLog(@"%s", __FUNCTION__);
}

- (void)rewardedVideoAd:(NSDictionary *)dicChannelInfo didFailedWithError:(NSError *)error
{
    NSLog(@"%s->%@", __FUNCTION__, error);
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        weakSelf.btnLoad.enabled = YES;
        [weakSelf.activityIndicatorView stopAnimating];
    });
}

- (void)rewardedVideoAdShown:(NSDictionary *)dicChannelInfo
{
    NSLog(@"%s", __FUNCTION__);
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        weakSelf.lblCacheNum.text = dicChannelInfo[@"channel_name"];
    });
}

- (void)rewardedVideoAdClicked:(NSDictionary *)dicChannelInfo
{
    NSLog(@"%s", __FUNCTION__);
}

- (void)rewardedVideoAdDismissed:(NSDictionary *)dicChannelInfo
{
    NSLog(@"%s", __FUNCTION__);
    //如果setAdUnitID 参数isAutoLoad 为NO 需调用
    //[self.rewardedVideoAd loadAd];
}

//have reward
- (void)rewardedVideoAdShouldReward:(NSDictionary *)dicChannelInfo reward:(MSRewardedVideoReward *)reward
{
    NSLog(@"%s", __FUNCTION__);
}

//no reward
- (void)rewardedVideoAdShouldNotReward:(NSDictionary *)dicChannelInfo
{
    NSLog(@"%s", __FUNCTION__);
}

- (void)rewardedVideoAdDidFailToPlay:(NSDictionary *)dicChannelInfo error:(NSError *)error
{
    
}

- (void)rewardedVideoAdOneLayerLoaded:(NSDictionary *)dicChannelInfo
{
    
}
- (void)rewardedVideoAdOneLayer:(NSDictionary *)dicChannelInfo didFailWithError:(NSError *)error
{
    
}
- (void)rewardedVideoAdBidStart
{
    
}
- (void)rewardedVideoAdBidEnd
{
    
}
- (void)rewardedVideoAdLoadStart:(NSDictionary *)dicChannelInfo
{
    
}
- (void)rewardedVideoAdPlayStart:(NSDictionary *)dicChannelInfo
{
    
}
- (void)rewardedVideoAdPlayEnd:(NSDictionary *)dicChannelInfo
{
    
}

@end
