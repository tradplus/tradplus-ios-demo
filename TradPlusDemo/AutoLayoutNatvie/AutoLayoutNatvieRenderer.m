

#import "AutoLayoutNatvieRenderer.h"

@implementation AutoLayoutNatvieRenderer

- (void)customerRendererWithRes:(TradPlusAdRes *)res
{
    //对三方的mediaView 增加自动布局
    if(res.mediaType == TPAdResMediaTypeView)
    {
        UIView *mediaView = res.mediaView;
        mediaView.translatesAutoresizingMaskIntoConstraints = NO;
        UIView *superView = mediaView.superview;
        [superView addConstraint:
         [NSLayoutConstraint constraintWithItem: mediaView
                                      attribute: NSLayoutAttributeWidth
                                      relatedBy: NSLayoutRelationEqual
                                         toItem: superView
                                      attribute: NSLayoutAttributeWidth
                                     multiplier: 1
                                       constant: 0]];
        [superView addConstraint:
         [NSLayoutConstraint constraintWithItem: mediaView
                                      attribute: NSLayoutAttributeHeight
                                      relatedBy: NSLayoutRelationEqual
                                         toItem: superView
                                      attribute: NSLayoutAttributeHeight
                                     multiplier: 1
                                       constant: 0]];
        [superView addConstraint:
         [NSLayoutConstraint constraintWithItem: mediaView
                                      attribute: NSLayoutAttributeCenterX
                                      relatedBy: NSLayoutRelationEqual
                                         toItem: superView
                                      attribute: NSLayoutAttributeCenterX
                                     multiplier: 1
                                       constant: 0]];
        [superView addConstraint:
         [NSLayoutConstraint constraintWithItem: mediaView
                                      attribute: NSLayoutAttributeCenterY
                                      relatedBy: NSLayoutRelationEqual
                                         toItem: superView
                                      attribute: NSLayoutAttributeCenterY
                                     multiplier: 1
                                       constant: 0]];
    }
}


- (void)addConstraintWithAdView:(UIView *)adView
{
    //渲染完成后对adView添加自动布局，部分三方需使用三方指定容器
    NSLog(@"adView --- %@",adView);
    adView.translatesAutoresizingMaskIntoConstraints = NO;
    UIView *superView = adView.superview;
    [superView addConstraint:
     [NSLayoutConstraint constraintWithItem: adView
                                  attribute: NSLayoutAttributeWidth
                                  relatedBy: NSLayoutRelationEqual
                                     toItem: superView
                                  attribute: NSLayoutAttributeWidth
                                 multiplier: 1
                                   constant: 0]];
    [superView addConstraint:
     [NSLayoutConstraint constraintWithItem: adView
                                  attribute: NSLayoutAttributeHeight
                                  relatedBy: NSLayoutRelationEqual
                                     toItem: superView
                                  attribute: NSLayoutAttributeHeight
                                 multiplier: 1
                                   constant: 0]];
    [superView addConstraint:
     [NSLayoutConstraint constraintWithItem: adView
                                  attribute: NSLayoutAttributeCenterX
                                  relatedBy: NSLayoutRelationEqual
                                     toItem: superView
                                  attribute: NSLayoutAttributeCenterX
                                 multiplier: 1
                                   constant: 0]];
    [superView addConstraint:
     [NSLayoutConstraint constraintWithItem: adView
                                  attribute: NSLayoutAttributeCenterY
                                  relatedBy: NSLayoutRelationEqual
                                     toItem: superView
                                  attribute: NSLayoutAttributeCenterY
                                 multiplier: 1
                                   constant: 0]];
}
@end
