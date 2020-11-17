//
//  SecondViewController.h
//  iMsgSDKSample
//
//  Created by ms-mac on 2016/11/23.
//  Copyright © 2016年 TradPlus. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    MsNativeADTypeSmall,
    MsNativeADTypeMedium,
    MsNativeADTypeLarge,
    MsNativeADTypeAdvanced,
} MsNativeADType;

@interface NativeViewController : UIViewController
@property (nonatomic) MsNativeADType nativeADType;
@end

