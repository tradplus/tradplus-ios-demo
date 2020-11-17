//
//  FirstViewController.m
//  iMsgSDKSample
//
//  Created by ms-mac on 2016/11/23.
//  Copyright © 2016年 TradPlus. All rights reserved.
//

#import "BannerViewController.h"
#import <TradPlusAds/MsBannerView.h>

@interface BannerViewController ()<MsBannerViewDelegate>
@property (nonatomic, strong) MsBannerView *bannerView;

@property (weak, nonatomic) IBOutlet UIView *adViewContainer;
@property (nonatomic) BOOL isAdLoaded;
@property (weak, nonatomic) IBOutlet UITextView *textViewLoadInfo;
@property (weak, nonatomic) IBOutlet UIButton *btnLoad;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicatorView;

@end

@implementation BannerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.textViewLoadInfo.editable = NO;
    self.bannerView = [[MsBannerView alloc] init];
    self.bannerView.delegate = self;
    [self.bannerView setAdUnitID:@"6008C47DF1201CC875F2044E88FCD287"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (IBAction)loadBanner:(id)sender {
    
    self.bannerView.frame = self.adViewContainer.bounds;
    [self.adViewContainer addSubview:self.bannerView];
    NSLog(@"%@:%@", NSStringFromCGRect(self.adViewContainer.frame), NSStringFromCGRect(self.bannerView.frame));

    self.textViewLoadInfo.text = @"";
    [self.bannerView loadAd];
    self.btnLoad.enabled = NO;
    [self.activityIndicatorView startAnimating];
}

#pragma mark - <FluteViewDelegate>
- (UIViewController *)viewControllerForPresentingModalView
{
    return self;
}

- (void)MsBannerViewDidLoaded:(MsBannerView *)adView
{
    NSLog(@"%s->%@", __FUNCTION__, [adView getLoadDetailInfo]);
    dispatch_async(dispatch_get_main_queue(), ^{
    [self.textViewLoadInfo insertText:[adView getLoadDetailInfo]];
    self.btnLoad.enabled = YES;
    [self.activityIndicatorView stopAnimating];
    });
}
- (void)MsBannerView:(MsBannerView *)adView didFailWithError:(NSError *)error
{
    NSLog(@"%s", __FUNCTION__);
    dispatch_async(dispatch_get_main_queue(), ^{
    [self.textViewLoadInfo insertText:[adView getLoadDetailInfo]];
    self.btnLoad.enabled = YES;
    [self.activityIndicatorView stopAnimating];
    });
}
- (void)MsBannerViewImpression:(MsBannerView *)adView
{
    NSLog(@"%s", __FUNCTION__);
}
- (void)MsBannerViewDidClick:(MsBannerView *)adView
{
    NSLog(@"%s", __FUNCTION__);
}

@end
