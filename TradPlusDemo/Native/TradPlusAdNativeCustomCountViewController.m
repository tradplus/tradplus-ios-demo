//
//  TradPlusAdNativeCustomCountViewController.m
//  TradPlusDemo
//
//  Created by xuejun on 2022/3/2.
//  Copyright © 2022 tradplus. All rights reserved.
//

#import "TradPlusAdNativeCustomCountViewController.h"
#import <TradPlusAds/TradPlusAdNative.h>
#import "TPNativePasterView.h"

@interface TradPlusAdNativeCustomCountViewController ()<TradPlusADNativeDelegate>

@property (nonatomic,weak)IBOutlet UITableView *myTableView;
@property (nonatomic,weak)IBOutlet UILabel *infoLabel;
@property (nonatomic,strong)TradPlusAdNative *native;
@property (nonatomic,assign)CGSize adSize;
@property (nonatomic,strong)NSMutableArray <TradPlusAdNativeObject *>*adArray;
@end

@implementation TradPlusAdNativeCustomCountViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.native = [[TradPlusAdNative alloc] init];
    [self.native setAdUnitID:@"E8D198EBD7FDC4F8A725066C82D707E1" isAutoLoad:NO];
    self.native.delegate = self;
    CGFloat width = CGRectGetWidth([UIScreen mainScreen].bounds);
    self.adSize = CGSizeMake(width, width);
    self.adArray = [[NSMutableArray alloc] init];
    [self.native setTemplateRenderSize:self.adSize];
}

- (IBAction)loadAct:(id)sender
{
    self.infoLabel.text = @"开始加载,自定义缓存数3";
    //设置自定义缓存个数
    [self.native loadAds:3];
}

- (IBAction)showAct:(id)sender
{
    self.infoLabel.text = @"";
    if(self.native.readyAdCount > 0)
    {
        self.infoLabel.text = @"展示广告";
        [self.adArray removeAllObjects];
        //获取缓存个数
        NSInteger readyAdCount = self.native.readyAdCount;
        for(NSInteger i = 0 ; i < readyAdCount; i++)
        {
            //保存原生广告对象
            TradPlusAdNativeObject *nativeObject = [self.native getReadyNativeObject];
            if(nativeObject != nil)
            {
                [self.adArray addObject:nativeObject];
            }
        }
        //刷新列表
        [self.myTableView reloadData];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.adArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UIScreen mainScreen].bounds.size.width;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGRect rect = CGRectZero;
    rect.size = self.adSize;
    UITableViewCell *cell = [[UITableViewCell alloc] initWithFrame:rect];
    UIView *adView = [[UIView alloc] initWithFrame:rect];
    TradPlusAdNativeObject *nativeObject = self.adArray[indexPath.row];
    [nativeObject showADWithRenderingViewClass:[TPNativePasterView class] subview:adView sceneId:nil];
    [cell.contentView addSubview:adView];
    return cell;
}


#pragma mark - TradPlusADNativeDelegate implementation


- (UIViewController *)viewControllerForPresentingModalView
{
    return self;
}


- (void)tpNativeAdLoaded:(NSDictionary *)adInfo
{
    NSLog(@"tpNativeAdLoaded %@",adInfo);
}

///AD加载失败
- (void)tpNativeAdLoadFailWithError:(NSError *)error
{
    NSLog(@"tpNativeAdLoadFailWithError with Error \n%@",error);
}

///AD展现失败
- (void)tpNativeAdShow:(NSDictionary *)adInfo didFailWithError:(NSError *)error
{
    NSLog(@"nativeAdShow didFailWithError \n%@\n%@\n<<<<<<",error ,adInfo);
}

///AD展现
- (void)tpNativeAdImpression:(NSDictionary *)adInfo
{
    NSLog(@"tpNativeAdImpression \n%@\n<<<<<<",adInfo);
}

///AD被点击
- (void)tpNativeAdClicked:(NSDictionary *)adInfo
{
    NSLog(@"tpNativeAdClicked \n%@\n<<<<<<",adInfo);
}

///bidding开始
- (void)tpNativeAdBidStart:(NSDictionary *)adInfo
{
    NSLog(@"tpNativeAdBidStart \n%@\n<<<<<<",adInfo);
}
///bidding结束
- (void)tpNativeAdBidEnd:(NSDictionary *)adInfo error:(NSError *)error
{
    NSLog(@"tpNativeAdBidEnd %@\n%@\n<<<<<<",adInfo,error);
}

///v7.6.0+新增 开始加载流程
- (void)tpNativeAdStartLoad:(NSDictionary *)adInfo
{
    NSLog(@"tpNativeAdStartLoad \n%@\n<<<<<<",adInfo);
}

///当每个广告源开始加载时会都会回调一次。
///v7.6.0+新增。替代原回调接口：tpNativeAdLoadStart:(NSDictionary *)adInfo;
- (void)tpNativeAdOneLayerStartLoad:(NSDictionary *)adInfo
{
    NSLog(@"tpNativeAdOneLayerStartLoad \n%@\n<<<<<<",adInfo);
}

///加载流程全部结束
- (void)tpNativeAdAllLoaded:(BOOL)success
{
    NSLog(@"tpNativeAdAllLoaded success %@\n<<<<<<",@(success));
    self.infoLabel.text = [NSString stringWithFormat:@"加载完成，加载到%@个缓存",@(self.native.readyAdCount)];
}

//多缓存情况下，当每个广告源加载成功后会都会回调一次。
- (void)tpNativeAdOneLayerLoaded:(NSDictionary *)adInfo
{
    NSLog(@"tpNativeAdOneLayerLoaded \n%@\n<<<<<<",adInfo);
}

//多缓存情况下，当每个广告源加载失败后会都会回调一次。
- (void)tpNativeAdOneLayerLoad:(NSDictionary *)adInfo didFailWithError:(NSError *)error
{
    NSLog(@"tpNativeAdOneLayerLoad error \n%@\n%@\n<<<<<<",error,adInfo);
}

- (void)tpNativeAdClose:(NSDictionary *)adInfo
{
    NSLog(@"tpNativeAdClose \n%@\n<<<<<<",adInfo);
}

- (void)tpNativePasterDidPlayFinished:(NSDictionary *)adInfo
{
    NSLog(@"tpNativePasterDidPlayFinished \n%@\n<<<<<<",adInfo);
}


@end
