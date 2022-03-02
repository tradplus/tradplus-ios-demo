

#import "TPNativePasterView.h"
#import <TradPlusAds/TradPlusNativeAdRendering.h>

@interface TPNativePasterView()<TradPlusNativeAdRendering>

@end

@implementation TPNativePasterView

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

- (UIView *)nativeMediaView
{
    return self.mainView;
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
    return [UINib nibWithNibName:@"TPNativePasterView" bundle:nil];
}
@end
