//
//  VideoPlayhead.h
//  IMADemo
//
//  Created by xuejun on 2023/9/25.
//

#import <Foundation/Foundation.h>
@import GoogleInteractiveMediaAds;

NS_ASSUME_NONNULL_BEGIN

@interface VideoPlayhead : NSObject<IMAContentPlayhead>

@property(nonatomic, weak) AVPlayer *contentPlayer;
@end

NS_ASSUME_NONNULL_END
