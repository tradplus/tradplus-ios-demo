//
//  TPNativeBannerTemplate.m
//  TradPlusAds
//
//  Created by xuejun on 2021/8/9.
//  Copyright © 2021 TradPlus. All rights reserved.
//

#import "NativeBannerTemplate.h"
#import <TradPlusAds/TradPlusNativeAdRendering.h>

@interface NativeBannerTemplate()<TradPlusNativeAdRendering>

@end

@implementation NativeBannerTemplate

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.iconImageView.layer.cornerRadius = 5.0;
    self.iconImageView.layer.masksToBounds = YES;
    self.ctaLabel.layer.cornerRadius = 5.0;
    self.ctaLabel.layer.masksToBounds = YES;
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
    return [UINib nibWithNibName:@"NativeBannerTemplate" bundle:nil];
}
@end
