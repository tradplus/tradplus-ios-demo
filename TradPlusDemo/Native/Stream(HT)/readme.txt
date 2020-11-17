//素材在这个回调里面的readAds参数里
- (void)nativeAdsAllLoaded:(MsNativeAdsLoader *)adsLoader isAdReady:(BOOL)isAdReady readyAds:(NSArray *)readyAds


readyAds里面存放的MsNativeAd数组，MsNativeAd.property里面是具体的素材字典，键值和具体对象对应如下：

#import <TradPlusAds/MSNativeAdConstants.h>

//标题
NSString *const gAdTitleKey = @"title";   
//副标题         
NSString *const gAdSubTitleKey = @"subtitle";
//描述
NSString *const gAdTextKey = @"text";
//小图标
NSString *const gAdIconImageViewKey = @"iconimageview";
//大图
NSString *const gAdMainMediaViewKey = @"mainmediaview";
//callToAction
NSString *const gAdCTATextKey = @"ctatext";


facebook特有
@"placementID"  广告位
@"socialContext"  

admob特有
@"price"
@"store"
@"starrating"