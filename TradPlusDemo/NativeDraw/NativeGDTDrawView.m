

#import "NativeGDTDrawView.h"

@interface NativeGDTDrawView()

@end

@implementation NativeGDTDrawView

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.ctaLabel.layer.cornerRadius = 25.0;
    self.ctaLabel.layer.masksToBounds = YES;
    self.iconImageView.layer.cornerRadius = 5.0;
    self.iconImageView.layer.masksToBounds = YES;
}

- (void)setupWithObject:(GDTUnifiedNativeAdDataObject *)item
{
    if(item.isVideoAd)
    {
        self.mediaView.frame = self.bounds;
        [self insertSubview:self.mediaView atIndex:0];
    }
    else
    {
        self.mainImageView.hidden = NO;
        [item bindImageViews:@[self.mainImageView] placeholder:nil];
    }
    CGRect rect = self.logoView.bounds;
    rect.origin = self.adChoiceImageView.frame.origin;
    CGFloat x = rect.origin.x + rect.size.width;
    if(x > self.bounds.size.width)
    {
        rect.origin.x = CGRectGetMaxX(self.frame) - rect.size.width;
    }
    CGFloat y = rect.origin.y + rect.size.height;
    if(y > self.bounds.size.height)
    {
        rect.origin.y = CGRectGetMaxY(self.frame) - rect.size.height;
    }
    self.logoView.frame = rect;
    self.titleLabel.text = item.title;
    self.textLabel.text = item.desc;
    NSString *ctaText = @"打开";
    if(item.callToAction != nil)
    {
        ctaText = item.callToAction;
    }
    else if(item.isAppAd)
    {
        ctaText = @"下载";
    }
    self.ctaLabel.text = ctaText;
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        NSURL *url = [NSURL URLWithString:item.iconUrl];
        NSData *iconData = [NSData dataWithContentsOfURL:url];
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.iconImageView.image = [UIImage imageWithData:iconData];
        });
    });
    NSArray *clickableViews = @[self.titleLabel,self.iconImageView,self.textLabel,self.ctaLabel];
    [self registerDataObject:item clickableViews:clickableViews];
}
@end
