//
//  TPListItem.h
//  TradPlusDemo
//
//  Created by xuejun on 2022/8/25.
//  Copyright © 2022 tradplus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TradPlusAds/TradPlusAds.h>

NS_ASSUME_NONNULL_BEGIN

@interface TPListItem : NSObject

@property (nonatomic,strong)TradPlusAdNativeObject *nativeObject;
@property (nonatomic,assign)BOOL willShowAd;
@end

NS_ASSUME_NONNULL_END
