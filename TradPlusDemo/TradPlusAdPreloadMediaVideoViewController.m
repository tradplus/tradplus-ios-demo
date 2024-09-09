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
            if(self.mediaVideoObject.adView != nil)
            {
                self.mediaVideoObject.adView.hidden = NO;
                self.mediaVideoObject.adView.frame = self.bgView.bounds;
                [self.bgView addSubview:self.mediaVideoObject.adView];
                [self.mediaVideoObject startWithSceneId:nil];
            }
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
        [weakSelf.mediaVideoObject destory];
        [weakSelf.contentPlayer play];
    };
}


@end
