//
//  TradPlusAdNativeInListViewController.m
//  TradPlusDemo
//
//  Created by xuejun on 2022/8/25.
//  Copyright © 2022 tradplus. All rights reserved.
//

#import "TradPlusAdNativeInListViewController.h"
#import "TPListItem.h"
#import <TradPlusAds/TradPlusAdNative.h>
#import "TPNativeInListView.h"

@interface TradPlusAdNativeInListViewController ()<TradPlusADNativeDelegate>

@property (nonatomic,weak)IBOutlet UITableView *myTableView;
@property (nonatomic,strong)NSMutableArray *itemArray;
@property (nonatomic,strong)TradPlusAdNative *native;
@end

@implementation TradPlusAdNativeInListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.native = [[TradPlusAdNative alloc] init];
    self.native.delegate = self;
    [self.native setTemplateRenderSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, 150)];
    [self.native setAdUnitID:@"E8D198EBD7FDC4F8A725066C82D707E1"];
    
    self.itemArray = [[NSMutableArray alloc] init];
    for(NSInteger i = 0; i < 50 ; i++)
    {
        TPListItem *item = [[TPListItem alloc] init];
        if(i > 0 && i%8 == 0)
        {
            item.willShowAd = YES;
        }
        [self.itemArray addObject:item];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.itemArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    TPListItem *item = self.itemArray[indexPath.row];
    if(item.willShowAd && item.nativeObject == nil)
    {
        return 0;
    }
    return 150;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"listCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"listCell"];
        CGRect rect = [UIScreen mainScreen].bounds;
        rect.size.height = 150;
        cell.frame = rect;
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row+1];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    TPListItem *item = self.itemArray[indexPath.row];
    if(item.nativeObject != nil)
    {
        CGRect rect = [UIScreen mainScreen].bounds;
        rect.size.height = 150;
        UIView *adView = [[UIView alloc] initWithFrame:rect];
        [item.nativeObject showADWithRenderingViewClass:[TPNativeInListView class] subview:adView sceneId:nil];
        [cell.contentView addSubview:adView];
        cell.textLabel.text = @"";
    }
    return cell;
}

- (void)adCheck
{
    NSArray<NSIndexPath *> *array = self.myTableView.indexPathsForVisibleRows;
    for(NSIndexPath *indexPath in array)
    {
        TPListItem *item = self.itemArray[indexPath.row];
        if(item.willShowAd && item.nativeObject == nil)
        {
            if(self.native.isAdReady)
            {
                TradPlusAdNativeObject *nativeObject = self.native.getReadyNativeObject;
                if(nativeObject != nil)
                {
                    item.nativeObject = nativeObject;
                }
                [self.myTableView reloadData];
                return;
            }
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"scrollViewDidEndDecelerating");
    [self adCheck];
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
