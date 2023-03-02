//
//  TradPlusAdPreloadMediaVideoViewController.m
//  TradPlusDemo
//
//  Created by xuejun on 2023/3/2.
//  Copyright © 2023 tradplus. All rights reserved.
//

#import "TradPlusAdPreloadMediaVideoViewController.h"
#import "MediaVideoManager.h"
#import <AVKit/AVKit.h>

@interface TradPlusAdPreloadMediaVideoViewController ()
{
    BOOL didLayoutSubviews;
}

@property (nonatomic,strong)TradPlusMediaVideoAdObject *mediaVideoObject;
@property (nonatomic,weak)IBOutlet UIView* bgView;
@property(nonatomic, strong) AVPlayer *contentPlayer;
@property(nonatomic, strong) AVPlayerLayer *contentPlayerLayer;
@end

@implementation TradPlusAdPreloadMediaVideoViewController

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    if(!didLayoutSubviews)
    {
        didLayoutSubviews = YES;
        self.contentPlayerLayer.frame = self.bgView.layer.bounds;
        self.mediaVideoObject = [[MediaVideoManager sharedInstance].mediaVideo getReadyMediaVideoObject];
        if(self.mediaVideoObject != nil)
        {
            [MediaVideoManager sharedInstance].adView.frame = self.bgView.bounds;
            [MediaVideoManager sharedInstance].adView.hidden = YES;
            [self.bgView addSubview:[MediaVideoManager sharedInstance].adView];
            [self.mediaVideoObject startWithViewController:self sceneId:nil];
        }
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSURL *contentURL = [NSURL URLWithString:@"https://storage.googleapis.com/gvabox/media/samples/stock.mp4"];
    self.contentPlayer = [AVPlayer playerWithURL:contentURL];
    
    self.contentPlayerLayer = [AVPlayerLayer playerLayerWithPlayer:self.contentPlayer];
    [self.bgView.layer addSublayer:self.contentPlayerLayer];
    
    __weak typeof(self) weakSelf = self;
    [MediaVideoManager sharedInstance].playFinish = ^{
        [[MediaVideoManager sharedInstance].adView removeFromSuperview];
        [weakSelf.contentPlayer play];
    };
    //收到开始播放时再显示广告
    [MediaVideoManager sharedInstance].starPlay = ^{
        [MediaVideoManager sharedInstance].adView.hidden = NO;
    };
}


@end
