//
//  MediaVideoManager.h
//  TradPlusDemo
//
//  Created by xuejun on 2023/3/2.
//  Copyright © 2023 tradplus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <TradPlusAds/TradPlusAdMediaVideo.h>

NS_ASSUME_NONNULL_BEGIN

@interface MediaVideoManager : NSObject

+(MediaVideoManager *)sharedInstance;
@property (nonatomic,readonly)TradPlusAdMediaVideo *mediaVideo;

@property (nonatomic,copy) void (^loadFinish)(void);
@property (nonatomic,copy) void (^starPlay)(void);
@property (nonatomic,copy) void (^playFinish)(void);
@end

NS_ASSUME_NONNULL_END
