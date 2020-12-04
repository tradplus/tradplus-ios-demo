//
//  YouDaoNativeAdView.h
//  yodaoSDKDemo-2.0.0
//
//  Created by lizai on 16/1/28.
//  Copyright © 2016年 lizai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YDSDKHeader.h"

@interface YouDaoNativeAdView : UIView <YDNativeAdRendering>

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *mainTextLabel;
@property (strong, nonatomic) UIImageView *iconImageView;
@property (strong, nonatomic) UIImageView *mainImageView;
@property (strong, nonatomic) UIImageView *privacyInformationIconImageView;
@property (strong, nonatomic) UILabel *ctaLabel;
@property (strong, nonatomic) UILabel *text1Label;
@property (strong, nonatomic) UILabel *text2Label;
@property (strong, nonatomic) UIImageView *testImageView;
@property (strong, nonatomic) NSMutableDictionary *propertyLables;
@property (strong, nonatomic) NSMutableDictionary *propertyImageViews;
@property (strong, nonatomic) UILabel *adMarkLabel;
@end
