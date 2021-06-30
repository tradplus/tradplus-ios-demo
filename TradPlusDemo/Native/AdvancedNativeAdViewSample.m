//
//  AdvancedNativeAdViewSample.m
//  TradPlusDemo
//
//  Created by ms-mac on 2017/2/24.
//  Copyright © 2017年 TradPlus. All rights reserved.
//

#import "AdvancedNativeAdViewSample.h"

@interface AdvancedNativeAdViewSample()

@end

@implementation AdvancedNativeAdViewSample

- (void)layoutSubviews
{
//    _titleLabel.numberOfLines = 2;
//    [_titleLabel sizeToFit];
    _mainTextLabel.numberOfLines = 3;
    [_mainTextLabel sizeToFit];
    
    _ctaLabel.layer.cornerRadius = 10;
    _ctaLabel.layer.masksToBounds = YES;
    _ctaLabel.layer.borderWidth = 1.0;
    _ctaLabel.layer.borderColor = [[UIColor blueColor] CGColor];
}

#pragma mark - <MSNativeAdRendering>

- (UILabel *)nativeMainTextLabel
{
    return self.mainTextLabel;
}

- (UILabel *)nativeTitleTextLabel
{
    return self.titleLabel;
}

//- (UILabel *)nativeSubTitleTextLabel
//{
//    return self.subtitleLabel;
//}

- (UILabel *)nativeCallToActionTextLabel
{
    return self.ctaLabel;
}

- (UIImageView *)nativeIconImageView
{
    return self.iconImageView;
}

- (UIImageView *)nativeMainImageView
{
    return self.mainImageView;
}

- (UIImageView *)nativePrivacyInformationIconImageView
{
    return self.privacyInformationIconImageView;
}

+ (UINib *)nibForAd
{
    return [UINib nibWithNibName:@"AdvancedNativeAdViewSample" bundle:nil];
}

- (NSArray <UIView *> *)clickableViews
{
    return @[_titleLabel, _mainTextLabel, _ctaLabel, _iconImageView, _mainImageView, _privacyInformationIconImageView];
}

@end
