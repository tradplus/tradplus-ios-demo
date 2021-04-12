//
//  NativeHTViewController.m
//  TradPlusDemo
//
//  Created by hy on 2020/6/7.
//  Copyright © 2020 tradplus. All rights reserved.
//

#import "NativeHTViewController.h"
#import <TradPlusAds/MsNativeAdsLoader.h>
#import <TradPlusAds/MsServerApi.h>
#import <TradPlusAds/MSLogging.h>
#import <TradPlusAds/MSNativeAdDelegate.h>
#import <TradPlusAds/MSNativeAd.h>
#import <TradPlusAds/MSNativeAd+internal.h>
#import "AdvancedNativeAdViewSample.h"
#import "AdvancedNativeAdViewSampleFB.h"
#import "AdvancedNativeAdViewSampleGG.h"

@interface NativeHTViewController ()<MsNativeAdsLoaderDelegate, MSNativeAdDelegate, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *lblPlacementId;
@property (weak, nonatomic) IBOutlet UITextField *tfAdsCount;
@property (weak, nonatomic) IBOutlet UIView *viewNative01;
@property (weak, nonatomic) IBOutlet UIView *viewNative02;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicatorView;

@property (strong, nonatomic) MsNativeAdsLoader *adsLoader;
@property (strong, nonatomic) NSString *placementId;
@end

@implementation NativeHTViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //_placementId = @"0AA7414819EE56542DBA126FE5A19C7E"; //fb admob
    //_placementId = @"1FFA9E20ED4498EDD839BF008AE6152A"; //穿山甲
    _placementId = @"7BDB36BCF18F9EEEB107ED3547B58F26"; //有道
    _lblPlacementId.text = _placementId;
    _tfAdsCount.delegate = self;
    _adsLoader = [[MsNativeAdsLoader alloc] init];
    _adsLoader.delegate = self;
    _adsLoader.defaultRenderingViewClass = [AdvancedNativeAdViewSample class];
    //_adsLoader.YDRenderingViewClass = [YouDaoNativeAdView class];
    [_adsLoader setAdUnitID:_placementId];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)doRefreshStrategy:(id)sender {
    [[MsServerApi sharedInstance] updateStrategy:_placementId segmentTag:nil dicUserInfo:nil completionBlock:nil];
}

- (IBAction)doLoadNativeAds:(id)sender {
    [_tfAdsCount resignFirstResponder];
    [[_viewNative01 subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [[_viewNative02 subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.activityIndicatorView startAnimating];
    [_adsLoader loadAds:[_tfAdsCount.text intValue]];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField;
{
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)doClose:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - MSNativeAdDelegate
- (void)willPresentModalForNativeAd:(MSNativeAd *)nativeAd
{
    MSLogInfo(@"%s", __PRETTY_FUNCTION__);
}

- (void)didDismissModalForNativeAd:(MSNativeAd *)nativeAd
{
    MSLogInfo(@"%s", __PRETTY_FUNCTION__);
}

- (void)willLeaveApplicationFromNativeAd:(MSNativeAd *)nativeAd
{
    MSLogInfo(@"%s", __PRETTY_FUNCTION__);
}

- (void)nativeAdClicked:(MSNativeAd *)nativeAd
{
    MSLogInfo(@"%s", __PRETTY_FUNCTION__);
}

- (void)nativeAdImpression:(MSNativeAd *)nativeAd
{
    MSLogInfo(@"%s", __PRETTY_FUNCTION__);
}

- (UIViewController *)viewControllerForPresentingModalView
{
    return self;
}

#pragma mark - MsNativeAdsLoaderDelegate
//整个TradPlus广告位加载结束。
- (void)nativeAdsAllLoaded:(BOOL)isAdReady readyAds:(nonnull NSArray *)readyAds error:(nonnull NSError *)error {
    MSLogInfo(@"nativeAdsAllLoaded->ready count:%d", readyAds.count);
    [self.activityIndicatorView stopAnimating];
    if (isAdReady)
    {
        for (int i = 0; i < readyAds.count;i++)
        {
            MSNativeAd *nativeAd = readyAds[i];
            MSLogInfo(@"nativeAd.properties:%@", nativeAd.properties);
            nativeAd.delegate = self;
            
            NSString *type = [nativeAd.properties objectForKey:@"type"];
            UIView *adView;
            
            if (type && [type isEqualToString:@"facebook"])
                adView = [nativeAd retrieveAdViewWithError:[AdvancedNativeAdViewSampleFB class] error:nil];
            else if (type && [type isEqualToString:@"admob"])
                adView = [nativeAd retrieveAdViewWithError:[AdvancedNativeAdViewSampleGG class] error:nil];
            else if (type && [type isEqualToString:@"pangle"])
                adView = [nativeAd retrieveAdViewWithError:[AdvancedNativeAdViewSampleGG class] error:nil];
            else if (type && [type isEqualToString:@"youdao"])
                adView = [nativeAd retrieveYDAdViewWithError:nil];
            else
                adView = [nativeAd retrieveAdViewWithError:[AdvancedNativeAdViewSampleGG class] error:nil];
            if (i == 0)
            {
                adView.frame = _viewNative01.bounds;
                [_viewNative01 addSubview:adView];
            } else if (i == 1)
            {
                adView.frame = _viewNative02.bounds;
                [_viewNative02 addSubview:adView];
            }
        }
    }
}

@end
