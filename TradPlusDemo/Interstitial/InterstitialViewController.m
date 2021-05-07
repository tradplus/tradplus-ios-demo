//
//  InterstitialViewController.m
//  fluteSDKSample
//
//  Created by ms-mac on 2019/10/22.
//  Copyright © 2019 TradPlus. All rights reserved.
//

#import "InterstitialViewController.h"
#import <TradPlusAds/MsInterstitialAd.h>
#import <TradPlusAds/MsCommon.h>

@interface InterstitialViewController ()<MsInterstitialAdDelegate>
@property (weak, nonatomic) IBOutlet UIButton *btnLoad;
@property (weak, nonatomic) IBOutlet UIButton *btnShow;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UITextView *textViewStatus;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicatorView;
@property (weak, nonatomic) IBOutlet UILabel *lblCacheNum;
@property (weak, nonatomic) IBOutlet UITextView *textViewFreq;

@property (nonatomic, strong) MsInterstitialAd *interstitialAd;
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation InterstitialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _lblCacheNum.text = @"";
    // Do any additional setup after loading the view from its nib.
    self.interstitialAd = [[MsInterstitialAd alloc] init];
    [self.interstitialAd setAdUnitID:@"063265866B93A4C6F93D1DDF7BF7329B"];
    self.interstitialAd.delegate = self;
    _lblCacheNum.text = @"";
//    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(doTimer) userInfo:nil repeats:YES];
}

- (void)doTimer
{
    NSLog(@"%@", [MsCommon getTimeStringForNow]);
}

- (IBAction)btnLoadClick:(id)sender {
    [self.activityIndicatorView startAnimating];
    self.btnLoad.enabled = false;
    
    // Initiate the request to load the ad.
    [self.interstitialAd loadAd];
}

- (IBAction)btnRefresh:(id)sender {
}

- (IBAction)btnBackClick:(id)sender {
    self.interstitialAd.delegate = nil;
    self.interstitialAd = nil;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)btnShowClick:(id)sender {
    self.textViewFreq.text = [self.interstitialAd getFreqInfo];
    if (self.interstitialAd.isAdReady)
    {
    }
        [self.interstitialAd showAdFromRootViewController:self];
        self.textView.text = [self.interstitialAd getLoadDetailInfo];
    self.textViewFreq.text = [self.interstitialAd getFreqInfo];
}

- (void)interstitialAdAllLoaded:(MsInterstitialAd *)interstitialAd readyCount:(int)readyCount
{
    NSLog(@"%s->ready:%d", __FUNCTION__, interstitialAd.readyAdCount);
    dispatch_async(dispatch_get_main_queue(), ^{
//    if (interstitialAd.readyAdCount > 0)
//        self.btnShow.enabled = YES;
    self.btnLoad.enabled = YES;
    [self.activityIndicatorView stopAnimating];
    self.textView.text = [interstitialAd getLoadDetailInfo];
    });
}

- (void)interstitialAd:(MsInterstitialAd *)interstitialAd didFailWithError:(NSError *)error
{
    NSLog(@"%s->%@", __FUNCTION__, error);
    dispatch_async(dispatch_get_main_queue(), ^{
    self.btnLoad.enabled = YES;
    [self.activityIndicatorView stopAnimating];
    });
}

- (void)interstitialAdShown:(MsInterstitialAd *)interstitialAd
{
    NSLog(@"%s->%@", __FUNCTION__, interstitialAd.channelName);
    dispatch_async(dispatch_get_main_queue(), ^{
        self->_lblCacheNum.text = [NSString stringWithFormat:@"current channel: %@", interstitialAd.channelName];
    });
}

- (void)interstitialAdClicked:(MsInterstitialAd *)interstitialAd
{
    NSLog(@"%s", __FUNCTION__);
}


- (void)loadingInfoChanged
{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.textView.text = [self.interstitialAd getLoadDetailInfo];
        self.textViewStatus.text = [self.interstitialAd getLoadDetailStatus];
        //_btnShow.enabled = self.interstitialAd.readyAdCount > 0;
        if ([_lblCacheNum.text isEqualToString:@""])
            _lblCacheNum.text = [NSString stringWithFormat:@"cache num: %d", self.interstitialAd.cacheNum];
    });
}

@end
