//
//  UIImage+Video.m
//  Crowdfunding
//
//  Created by 任敬 on 2017/12/19.
//  Copyright © 2017年 任敬. All rights reserved.
//

#import "UIImage+Video.h"
#import <AVFoundation/AVFoundation.h>

@implementation UIImage (Video)

+ (UIImage *)getScreenShotImageFromVideoURL:(NSString *)fileurl{
    
    
    UIImage *shotImage;
    //视频路径URL
    NSURL *fileURL = [NSURL URLWithString:fileurl];
    
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:fileURL options:nil];
    
    AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    
    gen.appliesPreferredTrackTransform = YES;
    
    CMTime time = CMTimeMakeWithSeconds(0.0, 600);
    
    NSError *error = nil;
    
    CMTime actualTime;
    
    CGImageRef image = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    
    shotImage = [[UIImage alloc] initWithCGImage:image];
    
    CGImageRelease(image);
    
    return shotImage;
}

@end
