//
//  AdvancedNativeAdViewSample.h
//  TradPlusDemo
//
//  Created by ms-mac on 2017/2/24.
//  Copyright © 2017年 TradPlus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TradPlusAds/MSNativeAdRendering.h>

@interface AdvancedNativeAdViewSample : UIView <MSNativeAdRendering>

//@property (weak, nonatomic) IBOutlet *subtitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UIImageView *mainImageView;
@property (weak, nonatomic) IBOutlet UIImageView *privacyInformationIconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *ctaLabel;
@property (weak, nonatomic) IBOutlet UILabel *mainTextLabel;

+ (UINib *)nibForAd;

@end
