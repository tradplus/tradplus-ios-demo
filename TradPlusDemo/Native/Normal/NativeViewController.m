//
//  SecondViewController.m
//  iMsgSDKSample
//
//  Created by ms-mac on 2016/11/23.
//  Copyright © 2016年 TradPlus. All rights reserved.
//

#import "NativeViewController.h"
#import <TradPlusAds/MsNativeAdView.h>
#import "AdvancedNativeAdViewSample.h"

@interface NativeViewController ()<MsNativeAdViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *adStatusLabel;
@property (strong, nonatomic) MsNativeAdView *nativeAd;
@property (weak, nonatomic) IBOutlet UIView *adView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicatorView;
@property (weak, nonatomic) IBOutlet UIButton *btnLoad;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *adViewHeight;
@property (weak, nonatomic) IBOutlet UITextView *textViewLoadInfo;
@property (nonatomic) BOOL isADLoaded;
@end

@implementation NativeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.textViewLoadInfo.editable = NO;
    _nativeAd = [[MsNativeAdView alloc] init];
//    [_nativeAd setAdUnitID:@"1E916A56353B12728E25766F8F242AD4"];
    [_nativeAd setAdUnitID:@"281D8267EAEB582924B0A9410B24F407"];
    
    _nativeAd.delegate = self;
    _nativeAd.renderingViewClass = [AdvancedNativeAdViewSample class];
}

- (void)viewDidLayoutSubviews
{
            _adViewHeight.constant = 310;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IB Actions

- (IBAction)loadNativeAdTapped:(id)sender
{
    self.btnLoad.enabled = NO;
    self.textViewLoadInfo.text = @"";
    [self.activityIndicatorView startAnimating];
    [_nativeAd removeFromSuperview];
    
    _nativeAd.frame = self.adView.bounds;
    [self.adView addSubview:_nativeAd];

    [_nativeAd loadAd];
}

#pragma mark - MsNativeAdViewDelegate implementation
- (UIViewController *)viewControllerForPresentingModalView
{
    return self;
}

- (void)nativeAdLoaded:(MsNativeAdView *)nativeAd
{
    NSLog(@"%s", __FUNCTION__);
    dispatch_async(dispatch_get_main_queue(), ^{
    self.btnLoad.enabled = YES;
    [self.activityIndicatorView stopAnimating];
    self.textViewLoadInfo.text = [nativeAd getLoadDetailInfo];
    });
}

- (void)nativeAd:(MsNativeAdView *)nativeAd didFailWithError:(NSError *)error
{
    NSLog(@"%s->error:%@", __FUNCTION__, error);
    dispatch_async(dispatch_get_main_queue(), ^{
    self.btnLoad.enabled = YES;
    [self.activityIndicatorView stopAnimating];
    self.textViewLoadInfo.text = [nativeAd getLoadDetailInfo];
    });
}

- (void)nativeAdClicked:(MsNativeAdView *)nativeAd
{
    NSLog(@"%s", __FUNCTION__);
}

@end
