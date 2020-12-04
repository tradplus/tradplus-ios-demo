//
//  YouDaoNativeAdView.m
//  yodaoSDKDemo-2.0.0
//
//  Created by lizai on 16/1/28.
//  Copyright © 2016年 lizai. All rights reserved.
//

#import "YouDaoNativeAdView.h"

@implementation YouDaoNativeAdView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel = [[UILabel alloc] init];
        [self.titleLabel setFont:[UIFont boldSystemFontOfSize:17.0f]];
        [self.titleLabel setText:@"Title"];
        [self addSubview:self.titleLabel];
        
        self.mainTextLabel = [[UILabel alloc] init];
        [self.mainTextLabel setFont:[UIFont systemFontOfSize:14.0f]];
        [self.mainTextLabel setText:@"Text"];
        [self.mainTextLabel setNumberOfLines:2];
        [self addSubview:self.mainTextLabel];
        
        self.iconImageView = [[UIImageView alloc] init];
        [self addSubview:self.iconImageView];
        
        self.mainImageView = [[UIImageView alloc] init];
        [self.mainImageView setClipsToBounds:YES];
        [self.mainImageView setContentMode:UIViewContentModeScaleAspectFill];
        [self addSubview:self.mainImageView];
        
        self.ctaLabel = [[UILabel alloc] init];
        [self.ctaLabel setFont:[UIFont systemFontOfSize:14.0f]];
        [self.ctaLabel setText:@"CTA Text"];
        [self.ctaLabel setTextColor:[UIColor greenColor]];
        [self.ctaLabel setTextAlignment:NSTextAlignmentRight];
        [self addSubview:self.ctaLabel];
        
        self.privacyInformationIconImageView = [[UIImageView alloc] init];
        [self addSubview:self.privacyInformationIconImageView];
        
        self.backgroundColor = [UIColor colorWithWhite:0.21 alpha:1.0f];
        self.titleLabel.textColor = [UIColor colorWithWhite:0.86 alpha:1.0f];
        self.mainTextLabel.textColor = [UIColor colorWithWhite:0.86 alpha:1.0f];
        
//        非标准元素渲染方式
        self.text1Label = [[UILabel alloc]init];
        self.text2Label = [[UILabel alloc]init];
        self.testImageView = [[UIImageView alloc]init];
        [self addSubview:self.text1Label];
        [self addSubview:self.text2Label];
        [self addSubview:self.testImageView];
        self.propertyLables = [[NSMutableDictionary alloc] init];
        self.propertyImageViews = [[NSMutableDictionary alloc] init];
        [self.propertyLables setObject:self.text1Label forKey:@"styleName"];
        [self.propertyLables setObject:self.text2Label forKey:@"text2"];
        [self.propertyImageViews setObject:self.testImageView forKey:@"mainimage"];
        
        self.adMarkLabel = [[UILabel alloc] init];
        [self.adMarkLabel setText:@"广告"];
        [self.adMarkLabel setFont:[UIFont systemFontOfSize:12.0f]];
        [self.adMarkLabel setTextColor:[UIColor whiteColor]];
        [self.adMarkLabel setTextAlignment:NSTextAlignmentCenter];
        [self.adMarkLabel setBackgroundColor:[UIColor clearColor]];
        [self addSubview:self.adMarkLabel];
        
        self.clipsToBounds = YES;
        
    }
    return self;
}

- (void)layoutSubviews
{
    CGFloat width = self.bounds.size.width;

    self.titleLabel.frame = CGRectMake(75, 110, 212, 60);
    self.iconImageView.frame = CGRectMake(10, 110, 60, 60);
    self.privacyInformationIconImageView.frame = CGRectMake(width - 30, 110, 20, 20);
    self.ctaLabel.frame = CGRectMake(width - 100, 370, 90, 48);
//    self.text1Label.frame = CGRectMake(width / 2 - 150, 68, 300, 50);
//    self.mainTextLabel.frame = CGRectMake(width / 2 - 150, 68, 100, 50);
    self.mainImageView.frame = CGRectMake(width / 2 - 150, 219, 300, 156);
    
    CGFloat height = self.bounds.size.height;
    self.adMarkLabel.frame = CGRectMake(width - 30, height - 15, 30, 15);
}

#pragma mark - <YDNativeAdRendering>

- (UILabel *)nativeMainTextLabel
{
    return self.mainTextLabel;
}

- (UILabel *)nativeTitleTextLabel
{
    return self.titleLabel;
}

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

- (NSMutableDictionary *)nativePropertyTextLabels
{
    return self.propertyLables;
}

- (NSMutableDictionary *)nativePropertyImageViews
{
    return self.propertyImageViews;
}


@end
