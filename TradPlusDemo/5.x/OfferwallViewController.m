//
//  OfferwallViewController.m
//  TradPlusSDKSample
//
//  Created by ms-mac on 2019/10/18.
//  Copyright © 2019 ms-mac. All rights reserved.
//

#import "OfferwallViewController.h"
#import <TradPlusAds/MsOfferwallAd.h>
#import <TradPlusAds/MsServerApi.h>

@interface OfferwallViewController ()<MsOfferwallAdDelegate>
@property (weak, nonatomic) IBOutlet UIButton *btnLoad;
@property (weak, nonatomic) IBOutlet UIButton *btnShow;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UITextView *textViewStatus;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicatorView;
@property (weak, nonatomic) IBOutlet UILabel *lblRewardInfo;
@property (weak, nonatomic) IBOutlet UILabel *lblCacheNum;
@property (weak, nonatomic) IBOutlet UILabel *lblPlacementId;

@property (nonatomic, strong) MsOfferwallAd *rewardedVideoAd;
@end

@implementation OfferwallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _lblRewardInfo.text = @"";
    _lblCacheNum.text = @"";
    _placementId = @"470166B2D4DEA9A7DCD3F42C5CE658B0";
    self.rewardedVideoAd = [[MsOfferwallAd alloc] init];
    [self.rewardedVideoAd setAdUnitID:_placementId];
    self.rewardedVideoAd.delegate = self;
    _lblPlacementId.text = _placementId;
}

- (IBAction)doRefreshStrategy:(id)sender {
    [self.activityIndicatorView startAnimating];
    [[MsServerApi sharedInstance] updateStrategy:_placementId segmentTag:nil dicUserInfo:nil completionBlock:^(NSError *error) {
        [self.activityIndicatorView stopAnimating];
    }];
    [self.rewardedVideoAd isNetWorkAdReady];
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


#pragma mark - MsOfferwallAdDelegate implementation
- (void)offerwallAdAllLoaded:(MsOfferwallAd *)rewardedVideoAd readyCount:(int)readyCount
{
    NSLog(@"%s->ready:%d", __FUNCTION__, self.rewardedVideoAd.readyAdCount);
        dispatch_async(dispatch_get_main_queue(), ^{
    //    if (rewardedVideoAd.readyAdCount > 0)
    //        self.btnShow.enabled = YES;
        self.btnLoad.enabled = YES;
        [self.activityIndicatorView stopAnimating];
        self.textView.text = [self.rewardedVideoAd getLoadDetailInfo];
        });
}

- (void)offerwallAdLoaded:(MsOfferwallAd *)rewardedVideoAd
{
    NSLog(@"%s", __FUNCTION__);
}

- (void)offerwallAd:(MsOfferwallAd *)rewardedVideoAd didFailWithError:(NSError *)error
{
    NSLog(@"%s->%@", __FUNCTION__, error);
}

- (void)offerwallAdShown:(MsOfferwallAd *)rewardedVideoAd
{
    NSLog(@"%s", __FUNCTION__);
    dispatch_async(dispatch_get_main_queue(), ^{
    _lblCacheNum.text = rewardedVideoAd.channelName;
    });
}

- (void)offerwallAdDismissed:(MsOfferwallAd *)rewardedVideoAd
{
    NSLog(@"%s", __FUNCTION__);
//    [self btnLoadClick:nil];
}

- (void)offerwallAdClicked:(MsOfferwallAd *)rewardedVideoAd
{
    NSLog(@"%s", __FUNCTION__);
}

- (void)offerwallAdShouldReward:(MsOfferwallAd *)rewardedVideoAd reward:(MSRewardedVideoReward *)reward
{
    NSLog(@"%s", __FUNCTION__);
    dispatch_async(dispatch_get_main_queue(), ^{
    if (reward)
    {
        NSString *strReward = [NSString stringWithFormat:@"reward type:%@ amount:%d", reward.currencyType, [reward.amount intValue]];
        self->_lblRewardInfo.text = strReward;
    }
    });
}

- (void)loadingInfoChangedO:(MsOfferwallAd *)rewardedVideoAd
{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.textView.text = [self.rewardedVideoAd getLoadDetailInfo];
        self.textViewStatus.text = [self.rewardedVideoAd getLoadDetailStatus];
//        _btnShow.enabled = self.rewardedVideoAd.readyAdCount > 0;
//        _lblCacheNum.text = [NSString stringWithFormat:@"%d", self.rewardedVideoAd.cacheNum];
    });
}

@end
