//
//  TradPlusAdOfferwallViewController.m
//  TradPlusDemo
//
//  Created by xuejun on 2022/8/5.
//  Copyright © 2022 tradplus. All rights reserved.
//

#import "TradPlusAdOfferwallViewController.h"
#import <TradPlusAds/TradPlusAds.h>

@interface TradPlusAdOfferwallViewController ()<TradPlusADOfferwallDelegate>

@property (nonatomic, strong) TradPlusAdOfferwall *offerwall;
@property (nonatomic,weak)IBOutlet UILabel *logLabel;
@property (nonatomic,weak)IBOutlet UILabel *amountLabel;
@property (nonatomic,weak)IBOutlet UILabel *userIdInfoLabel;
@end

@implementation TradPlusAdOfferwallViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.offerwall = [[TradPlusAdOfferwall alloc] init];
    self.offerwall.delegate = self;
    [self.offerwall setAdUnitID:@"470166B2D4DEA9A7DCD3F42C5CE658B0"];
    self.logLabel.text = @"加载中...";
    //设置是否需要自动加载
//    [self.offerwall setAdUnitID:@"470166B2D4DEA9A7DCD3F42C5CE658B0" isAutoLoad:BOOL]
}

- (IBAction)loadAct:(id)sender
{
    //加载
    self.logLabel.text = @"开始加载";
    [self.offerwall loadAd];
}

- (IBAction)showAct:(id)sender
{
    [self.offerwall showAdFromRootViewController:self sceneId:nil];
}

//获取当前积分余额
- (IBAction)getCurrencyBalance:(id)sender
{
    [self.offerwall getCurrencyBalance];
}


//增加10积分
- (IBAction)awardCurrency:(id)sender
{
    [self.offerwall awardCurrency:10];
}


//扣除10积分
- (IBAction)spendCurrency:(id)sender
{
    [self.offerwall spendCurrency:10];
}


//设置用户userId
- (IBAction)setUserId:(id)sender
{
    [self.offerwall setUserId:@"tp_user_id"];
}

///AD加载完成 首个广告源加载成功时回调 一次加载流程只会回调一次
- (void)tpOfferwallAdLoaded:(NSDictionary *)adInfo
{
    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
    self.logLabel.text = @"加载成功";
}

///AD加载失败
- (void)tpOfferwallAdLoadFailWithError:(NSError *)error
{
    NSLog(@"%s \n%@", __FUNCTION__ ,error);
    self.logLabel.text = [NSString stringWithFormat:@"加载错误：%ld",(long)error.code];
}

///AD展现
- (void)tpOfferwallAdImpression:(NSDictionary *)adInfo
{
    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
}

///AD展现失败
- (void)tpOfferwallAdShow:(NSDictionary *)adInfo didFailWithError:(NSError *)error
{
    NSLog(@"%s \n%@ error:%@", __FUNCTION__ ,adInfo,error);
}

///AD被点击
- (void)tpOfferwallAdClicked:(NSDictionary *)adInfo
{
    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
}

///AD关闭
- (void)tpOfferwallAdDismissed:(NSDictionary *)adInfo
{
    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
}

///userID 设置结束 error = nil 成功
- (void)tpOfferwallSetUserIdFinish:(NSError *)error
{
    NSLog(@"%s \n error:%@", __FUNCTION__ ,error);
    NSString *text = @"userId 设置成功";
    if(error != nil)
    {
        text = @"userId 设置失败";
    }
    self.userIdInfoLabel.text = text;;
}

///用户当前积分墙积分数量
- (void)tpOfferwallGetCurrencyBalance:(NSDictionary *)response error:(NSError *)error
{
    NSLog(@"%s \n%@ error:%@", __FUNCTION__ ,response,error);
    NSInteger amount = [response[@"amount"] integerValue];
    self.amountLabel.text = [NSString stringWithFormat:@"当前用户积分：%@",@(amount)];
}

//扣除用户积分墙积分回调
- (void)tpOfferwallSpendCurrency:(NSDictionary *)response error:(NSError *)error
{
    NSLog(@"%s \n%@ error::%@", __FUNCTION__ ,response,error);
    NSString *text = @"扣除成功";
    if(error != nil)
        text = @"扣除失败";
    NSInteger amount = [response[@"amount"] integerValue];
    self.amountLabel.text = [NSString stringWithFormat:@"%@,当前用户积分：%@",text,@(amount)];
}

//添加用户积分墙积分回调
- (void)tpOfferwallAwardCurrency:(NSDictionary *)response error:(NSError *)error
{
    NSLog(@"%s \n%@ error::%@", __FUNCTION__ ,response,error);
    NSString *text = @"增加成功";
    if(error != nil)
        text = @"增加失败";
    NSInteger amount = [response[@"amount"] integerValue];
    self.amountLabel.text = [NSString stringWithFormat:@"%@,当前用户积分：%@",text,@(amount)];
}

///开始加载流程
- (void)tpOfferwallAdStartLoad:(NSDictionary *)adInfo
{
    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
}

///当每个广告源开始加载时会都会回调一次。
- (void)tpOfferwallAdOneLayerStartLoad:(NSDictionary *)adInfo
{
    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
}

///当每个广告源加载成功后会都会回调一次。
- (void)tpOfferwallAdOneLayerLoaded:(NSDictionary *)adInfo
{
    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
}

///当每个广告源加载失败后会都会回调一次，返回三方源的错误信息
- (void)tpOfferwallAdOneLayerLoad:(NSDictionary *)adInfo didFailWithError:(NSError *)error
{
    NSLog(@"%s \n%@ error:%@", __FUNCTION__ ,adInfo,error);
}

///加载流程全部结束
- (void)tpOfferwallAdAllLoaded:(BOOL)success
{
    NSLog(@"%s \n%@", __FUNCTION__ ,@(success));
}

@end
