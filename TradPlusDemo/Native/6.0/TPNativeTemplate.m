//
//  TPNativeInterstitialTemplate.m
//  TradPlusAds
//
//  Created by xuejun on 2021/8/9.
//  Copyright © 2021 ms-mac. All rights reserved.
//

#import "TPNativeTemplate.h"
#import <TradPlusAds/TradPlusNativeAdRendering.h>

//TradPlusNativeAdRendering 协议是MSNativeAdRendering 简化版本
//如已使用支持MSNativeAdRendering协议 无需更换
@interface TPNativeTemplate()<TradPlusNativeAdRendering>

@end

@implementation TPNativeTemplate

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.ctaLabel.layer.cornerRadius = 25.0;
    self.ctaLabel.layer.masksToBounds = YES;
    self.iconImageView.layer.cornerRadius = 5.0;
    self.iconImageView.layer.masksToBounds = YES;
}


- (UILabel *)nativeTitleTextLabel
{
    return self.titleLabel;
}

- (UILabel *)nativeMainTextLabel
{
    return self.textLabel;
}

- (UIImageView *)nativeIconImageView
{
    return self.iconImageView;
}

- (UIImageView *)nativeMainImageView
{
    return self.mainImageView;
}

- (UILabel *)nativeCallToActionTextLabel
{
    return self.ctaLabel;
}

- (UIImageView *)nativePrivacyInformationIconImageView
{
    return self.adChoiceImageView;
}

+ (UINib *)nibForAd
{
    return [UINib nibWithNibName:@"TPNativeTemplate" bundle:nil];
}
@end
