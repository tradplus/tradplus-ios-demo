//
//  VideoPlayhead.m
//  IMADemo
//
//  Created by xuejun on 2023/9/25.
//

#import "VideoPlayhead.h"

@implementation VideoPlayhead

- (NSTimeInterval)currentTime
{
    if(self.contentPlayer != nil)
    {
        return CMTimeGetSeconds(self.contentPlayer.currentTime);
    }
    else
    {
        return 0;
    }
}
@end
