

#import "TradPlusAdNativePasterViewController.h"
#import <TradPlusAds/TradPlusAdNative.h>
#import "TPNativePasterView.h"
#import <AVFoundation/AVFoundation.h>

@interface TradPlusAdNativePasterViewController ()<TradPlusADNativeDelegate>

@property (nonatomic,weak)IBOutlet UIView *adView;
@property (nonatomic,weak)IBOutlet UIView *videoActTool;
@property (nonatomic,weak)IBOutlet UILabel *infoLabel;
@property (nonatomic,strong)TradPlusAdNative *native;
@property (nonatomic,strong)TPNativePasterView *nativePasterView;
@property (nonatomic,strong)TradPlusAdNativeObject *nativeObject;

@property (nonatomic,strong)AVPlayer *myPlayer;
@property (nonatomic,strong)AVPlayerItem *playerItem;
@property (nonatomic,strong)AVPlayerLayer *myPlayerLayer;
@end

@implementation TradPlusAdNativePasterViewController

- (void)dealloc
{
    if(self.playerItem != nil)
    {
        [self.playerItem removeObserver:self forKeyPath:@"status"];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.native = [[TradPlusAdNative alloc] init];
    self.native.finishDownload = YES;
    self.native.delegate = self;
    [self.native setAdUnitID:@"1762D6F5BA9A25C2607B12E6E28D99BD"];
}

- (IBAction)loadAct:(id)sender
{
    self.infoLabel.text = @"加载中...";
    [self.native loadAd];
}

- (IBAction)showAct:(id)sender
{
    self.infoLabel.text = @"展示中";
    //获取一个已加载完成的，原生广告缓存，没有缓存时返回 nil
    //注意获取后此广告会从缓存中移除，SDK同时移除此缓存的引用
    //一般情况下一次只获取一个
    self.nativeObject = [self.native getReadyNativeObject];
    if(self.nativeObject != nil)
    {
        if(self.nativePasterView != nil)
        {
            [self.nativePasterView removeFromSuperview];
        }
        self.nativePasterView = [[NSBundle mainBundle] loadNibNamed:@"TPNativePasterView" owner:self options:nil].lastObject;
        self.nativePasterView.frame = self.adView.bounds;
        [self.nativePasterView layoutIfNeeded];
        
        //注册各组件及是否可点击
        TradPlusNativeRenderer *nativeRenderer = [[TradPlusNativeRenderer alloc] init];
        [nativeRenderer setTitleLable:self.nativePasterView.titleLabel canClick:YES];
        [nativeRenderer setTextLable:self.nativePasterView.textLabel canClick:YES];
        [nativeRenderer setCtaLable:self.nativePasterView.ctaLabel canClick:YES];
        [nativeRenderer setIconView:self.nativePasterView.iconImageView canClick:YES];
        //如果需要使用自定义播放器
        //可以通过 customVideoPaster 是否为空 来判断是否支持使用自定义播放器
        if(self.nativeObject.customVideoPaster != nil)
        {
            //添加自定义播放器
            [self addPlayerWithCustomVideoPaster:self.nativeObject.customVideoPaster];
            
        }
        [nativeRenderer setCustomerView:self.nativePasterView.mainView key:@"videoView" canClick:YES];
        self.videoActTool.hidden = (self.nativeObject.customVideoPaster == nil);
        
        [nativeRenderer setAdChoiceImageView:self.nativePasterView.adChoiceImageView canClick:YES];
        [nativeRenderer setAdView:self.nativePasterView canClick:NO];
        [self.nativeObject showADWithNativeRenderer:nativeRenderer subview:self.adView sceneId:[[NSUserDefaults standardUserDefaults] objectForKey:@"scene_id"]];
    }
}

- (void)addPlayerWithCustomVideoPaster:(TradPlusAdCustomVideoPaster *)customVideoPaster
{
    if(self.myPlayerLayer != nil)
    {
        [self.myPlayerLayer removeFromSuperlayer];
    }
    NSURL *url = [NSURL fileURLWithPath:customVideoPaster.videoUrl];
    
    self.playerItem = [[AVPlayerItem alloc] initWithURL:url];
    [self.playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    
    self.myPlayer = [AVPlayer playerWithPlayerItem:self.playerItem];
    self.myPlayerLayer = [AVPlayerLayer playerLayerWithPlayer:self.myPlayer];
    self.myPlayerLayer.frame = self.nativePasterView.mainView.bounds;
    [self.nativePasterView.mainView.layer addSublayer:self.myPlayerLayer];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playFinish) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([self.playerItem status] == AVPlayerStatusReadyToPlay)
    {
        [self startPlay];
    }
    else if ([self.playerItem status] == AVPlayerStatusFailed)
    {
        [self videoFailed];
    }
}

- (void)videoFailed
{
    NSError *error = self.playerItem.error;
    self.infoLabel.text = [NSString stringWithFormat:@"视频加载失败 %@",error];
    [self.nativeObject.customVideoPaster didPlayFailedWithError:error];
}

//开始播放
- (void)startPlay
{
    self.infoLabel.text = @"视频播放中...";
    [self.myPlayer play];
    //调用自定义贴片的埋点上报
    [self.nativeObject.customVideoPaster startPlayVideo];
}


//播放完成
- (void)playFinish
{
    self.infoLabel.text = @"播放完成";
    //调用自定义贴片的埋点上报
    [self.nativeObject.customVideoPaster didFinishVideo];
    [self.nativePasterView removeFromSuperview];
    self.videoActTool.hidden = YES;
}

//暂停
- (IBAction)pauseVideo:(id)sender
{
    if(self.myPlayer.timeControlStatus == AVPlayerTimeControlStatusPlaying)
    {
        self.infoLabel.text = @"暂停播放";
        [self.myPlayer pause];
        //调用自定义贴片的埋点上报
        NSTimeInterval currentTime = CMTimeGetSeconds(self.myPlayer.currentTime);
        [self.nativeObject.customVideoPaster didPauseVideoWithCurrentDuration:currentTime];
    }
}

//继续播放
- (IBAction)resumeVideo:(id)sender
{
    if(self.myPlayer.timeControlStatus == AVPlayerTimeControlStatusPaused)
    {
        self.infoLabel.text = @"视频播放中...";
        [self.myPlayer play];
        //调用自定义贴片的埋点上报
        NSTimeInterval currentTime = CMTimeGetSeconds(self.myPlayer.currentTime);
        [self.nativeObject.customVideoPaster didResumeVideoWithCurrentDuration:currentTime];
    }
}

#pragma mark - TradPlusADNativeDelegate

///部分三方源需要设置rootviewController smaato GDTMob kuaishou
- (UIViewController *)viewControllerForPresentingModalView
{
    return self;
}

///AD加载完成 首个广告源加载成功时回调 一次加载流程只会回调一次
- (void)tpNativeAdLoaded:(NSDictionary *)adInfo
{
    self.infoLabel.text = @"加载成功";
    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
}
///AD加载失败
- (void)tpNativeAdLoadFailWithError:(NSError *)error
{
    self.infoLabel.text = [NSString stringWithFormat:@"加载失败：%@",error];
    NSLog(@"%s \n error:%@", __FUNCTION__ ,error);
}
///AD展现
- (void)tpNativeAdImpression:(NSDictionary *)adInfo
{
    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
}
///AD展现失败
- (void)tpNativeAdShow:(NSDictionary *)adInfo didFailWithError:(NSError *)error
{
    NSLog(@"%s \n%@ error:%@", __FUNCTION__ ,adInfo,error);
}
///AD被点击
- (void)tpNativeAdClicked:(NSDictionary *)adInfo
{
    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
}

///AD被关闭
- (void)tpNativeAdClose:(NSDictionary *)adInfo
{
    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
}
///bidding开始
- (void)tpNativeAdBidStart:(NSDictionary *)adInfo
{
    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
}
///bidding结束 error = nil 表示成功
- (void)tpNativeAdBidEnd:(NSDictionary *)adInfo error:(NSError *)error
{
    NSLog(@"%s \n%@ error:%@", __FUNCTION__ ,adInfo,error);
}
///开始加载
- (void)tpNativeAdLoadStart:(NSDictionary *)adInfo
{
    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
}
//多缓存情况下，当每个广告源加载成功后会都会回调一次。
- (void)tpNativeAdOneLayerLoaded:(NSDictionary *)adInfo
{
    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
}
//多缓存情况下，当每个广告源加载失败后会都会回调一次。
- (void)tpNativeAdOneLayerLoad:(NSDictionary *)adInfo didFailWithError:(NSError *)error
{
    NSLog(@"%s \n%@ error:%@", __FUNCTION__ ,adInfo,error);
}
///加载流程全部结束
- (void)tpNativeAdAllLoaded:(BOOL)success
{
    NSLog(@"%s \n%@", __FUNCTION__ ,@(success));
}
///视频贴片类型播放完成回调
- (void)tpNativePasterDidPlayFinished:(NSDictionary *)adInfo
{
    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
}
@end
