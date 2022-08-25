

#import "TPNativeInListView.h"

@interface TPNativeInListView()

@end

@implementation TPNativeInListView

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

//- (UILabel *)nativeCallToActionTextLabel
//{
//    return self.ctaLabel;
//}

- (UIImageView *)nativePrivacyInformationIconImageView
{
    return self.adChoiceImageView;
}

+ (UINib *)nibForAd
{
    return [UINib nibWithNibName:@"TPNativeInListView" bundle:nil];
}
@end
