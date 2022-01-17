
#import <UIKit/UIKit.h>
#import "GDTUnifiedNativeAdView.h"

NS_ASSUME_NONNULL_BEGIN

@interface NativeGDTDrawView : GDTUnifiedNativeAdView

@property (nonatomic,weak)IBOutlet UIImageView *iconImageView;
@property (nonatomic,weak)IBOutlet UIImageView *adChoiceImageView;
@property (nonatomic,weak)IBOutlet UILabel *titleLabel;
@property (nonatomic,weak)IBOutlet UILabel *textLabel;
@property (nonatomic,weak)IBOutlet UILabel *ctaLabel;
@property (nonatomic,weak)IBOutlet UIImageView *mainImageView;

- (void)setupWithObject:(GDTUnifiedNativeAdDataObject *)item;
@end

NS_ASSUME_NONNULL_END
