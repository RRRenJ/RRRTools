//
//  AVCompress.m
//  yasuo
//
//  Created by 任敬 on 2017/12/25.
//  Copyright © 2017年 任敬. All rights reserved.
//

#import "AVCompress.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

static AVCompress * manager;

@interface AVCompress()

@property (nonatomic, strong)AVAssetExportSession * session;

@property (nonatomic, strong) NSTimer * timer;

@property (nonatomic, assign) BOOL isAllComplete;

@end


@implementation AVCompress

+ (instancetype)manager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

- (void)dealloc{
    [self.timer invalidate];
    self.timer = nil;
}


- (void)getVideoOutputPathWithAssetModel:(AVCompressModel *)model presetName:(NSString *)presetName success:(void (^)(NSString *outputPath))success failure:(void (^)(NSString *errorMessage, NSError *error))failure{
    model.status = AVCompressStatusWithCompress;
    PHVideoRequestOptions* options = [[PHVideoRequestOptions alloc] init];
    options.version = PHVideoRequestOptionsVersionOriginal;
    options.deliveryMode = PHVideoRequestOptionsDeliveryModeAutomatic;
    options.networkAccessAllowed = YES;
    [[PHImageManager defaultManager] requestAVAssetForVideo:model.asset options:options resultHandler:^(AVAsset* avasset, AVAudioMix* audioMix, NSDictionary* info){
        // NSLog(@"Info:\n%@",info);
        AVURLAsset *videoAsset = (AVURLAsset*)avasset;
        // NSLog(@"AVAsset URL: %@",myAsset.URL);
        [self startExportVideoWithVideoAsset:videoAsset presetName:presetName success:success  failure:failure];
    }];
      
}
    
- (void)startExportVideoWithVideoAsset:(AVURLAsset *)videoAsset presetName:(NSString *)presetName success:(void (^)(NSString *outputPath))success failure:(void (^)(NSString *errorMessage, NSError *error))failure {
    // Find compatible presets by video asset.
    NSArray *presets = [AVAssetExportSession exportPresetsCompatibleWithAsset:videoAsset];
    
    // Begin to compress video
    // Now we just compress to low resolution if it supports
    // If you need to upload to the server, but server does't support to upload by streaming,
    // You can compress the resolution to lower. Or you can support more higher resolution.
    if ([presets containsObject:presetName]) {
       _session = [[AVAssetExportSession alloc] initWithAsset:videoAsset presetName:presetName];
        
        NSDateFormatter *formater = [[NSDateFormatter alloc] init];
        [formater setDateFormat:@"yyyy-MM-dd-HH:mm:ss-SSS"];
        NSString *outputPath = [NSHomeDirectory() stringByAppendingFormat:@"/tmp/output-%@.mp4", [formater stringFromDate:[NSDate date]]];
        // NSLog(@"video outputPath = %@",outputPath);
        _session.outputURL = [NSURL fileURLWithPath:outputPath];
        // Optimize for network use.
        _session.shouldOptimizeForNetworkUse = true;
        NSArray *supportedTypeArray = _session.supportedFileTypes;
        if ([supportedTypeArray containsObject:AVFileTypeMPEG4]) {
            _session.outputFileType = AVFileTypeMPEG4;
        } else if (supportedTypeArray.count == 0) {
            if (failure) {
                failure(@"该视频类型暂不支持导出", nil);
            }
            NSLog(@"No supported file types 视频类型暂不支持导出");
            return;
        } else {
            _session.outputFileType = [supportedTypeArray objectAtIndex:0];
        }
        
        if (![[NSFileManager defaultManager] fileExistsAtPath:[NSHomeDirectory() stringByAppendingFormat:@"/tmp"]]) {
            [[NSFileManager defaultManager] createDirectoryAtPath:[NSHomeDirectory() stringByAppendingFormat:@"/tmp"] withIntermediateDirectories:YES attributes:nil error:nil];
        }
        
        AVMutableVideoComposition *videoComposition = [self fixedCompositionWithAsset:videoAsset];
        if (videoComposition.renderSize.width) {
            // 修正视频转向
            _session.videoComposition = videoComposition;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.timer setFireDate:[NSDate distantPast]];
        });
        
       
        
        
        // Begin to export video to the output path asynchronously.
        [_session exportAsynchronouslyWithCompletionHandler:^(void) {
         
            dispatch_async(dispatch_get_main_queue(), ^{
                switch (_session.status) {
                    case AVAssetExportSessionStatusUnknown: {
                        NSLog(@"AVAssetExportSessionStatusUnknown");
                    }  break;
                    case AVAssetExportSessionStatusWaiting: {
                        NSLog(@"AVAssetExportSessionStatusWaiting");
                    }  break;
                    case AVAssetExportSessionStatusExporting: {
                        NSLog(@"AVAssetExportSessionStatusExporting");
                    }  break;
                    case AVAssetExportSessionStatusCompleted: {
                        NSLog(@"AVAssetExportSessionStatusCompleted");
                        if (success) {
                            success(outputPath);
                            [self nextAsset];
                        }
                    }  break;
                    case AVAssetExportSessionStatusFailed: {
                        NSLog(@"AVAssetExportSessionStatusFailed");
                        
                        if (failure) {
                            failure(@"视频导出失败", _session.error);
                            [self nextAsset];
                        }
                    }  break;
                    case AVAssetExportSessionStatusCancelled: {
                        self.timer.fireDate = [NSDate distantFuture];
                        NSLog(@"AVAssetExportSessionStatusCancelled");
                        if (failure) {
                            failure(@"导出任务已被取消", nil);
                        }
                    }  break;
                    default:break;
                }

            });
        }];
        
    } else {
        if (failure) {
            NSString *errorMessage = [NSString stringWithFormat:@"当前设备不支持该预设:%@", presetName];
            failure(errorMessage, nil);
        }
    }
}


/// 获取优化后的视频转向信息
- (AVMutableVideoComposition *)fixedCompositionWithAsset:(AVAsset *)videoAsset {
    AVMutableVideoComposition *videoComposition = [AVMutableVideoComposition videoComposition];
    // 视频转向
    int degrees = [self degressFromVideoFileWithAsset:videoAsset];
    if (degrees != 0) {
        CGAffineTransform translateToCenter;
        CGAffineTransform mixedTransform;
        videoComposition.frameDuration = CMTimeMake(1, 30);
        
        NSArray *tracks = [videoAsset tracksWithMediaType:AVMediaTypeVideo];
        AVAssetTrack *videoTrack = [tracks objectAtIndex:0];
        
        AVMutableVideoCompositionInstruction *roateInstruction = [AVMutableVideoCompositionInstruction videoCompositionInstruction];
        roateInstruction.timeRange = CMTimeRangeMake(kCMTimeZero, [videoAsset duration]);
        AVMutableVideoCompositionLayerInstruction *roateLayerInstruction = [AVMutableVideoCompositionLayerInstruction videoCompositionLayerInstructionWithAssetTrack:videoTrack];
        
        if (degrees == 90) {
            // 顺时针旋转90°
            translateToCenter = CGAffineTransformMakeTranslation(videoTrack.naturalSize.height, 0.0);
            mixedTransform = CGAffineTransformRotate(translateToCenter,M_PI_2);
            videoComposition.renderSize = CGSizeMake(videoTrack.naturalSize.height,videoTrack.naturalSize.width);
            [roateLayerInstruction setTransform:mixedTransform atTime:kCMTimeZero];
        } else if(degrees == 180){
            // 顺时针旋转180°
            translateToCenter = CGAffineTransformMakeTranslation(videoTrack.naturalSize.width, videoTrack.naturalSize.height);
            mixedTransform = CGAffineTransformRotate(translateToCenter,M_PI);
            videoComposition.renderSize = CGSizeMake(videoTrack.naturalSize.width,videoTrack.naturalSize.height);
            [roateLayerInstruction setTransform:mixedTransform atTime:kCMTimeZero];
        } else if(degrees == 270){
            // 顺时针旋转270°
            translateToCenter = CGAffineTransformMakeTranslation(0.0, videoTrack.naturalSize.width);
            mixedTransform = CGAffineTransformRotate(translateToCenter,M_PI_2*3.0);
            videoComposition.renderSize = CGSizeMake(videoTrack.naturalSize.height,videoTrack.naturalSize.width);
            [roateLayerInstruction setTransform:mixedTransform atTime:kCMTimeZero];
        }
        
        roateInstruction.layerInstructions = @[roateLayerInstruction];
        // 加入视频方向信息
        videoComposition.instructions = @[roateInstruction];
    }
    return videoComposition;
}

/// 获取视频角度
- (int)degressFromVideoFileWithAsset:(AVAsset *)asset {
    int degress = 0;
    NSArray *tracks = [asset tracksWithMediaType:AVMediaTypeVideo];
    if([tracks count] > 0) {
        AVAssetTrack *videoTrack = [tracks objectAtIndex:0];
        CGAffineTransform t = videoTrack.preferredTransform;
        if(t.a == 0 && t.b == 1.0 && t.c == -1.0 && t.d == 0){
            // Portrait
            degress = 90;
        } else if(t.a == 0 && t.b == -1.0 && t.c == 1.0 && t.d == 0){
            // PortraitUpsideDown
            degress = 270;
        } else if(t.a == 1.0 && t.b == 0 && t.c == 0 && t.d == 1.0){
            // LandscapeRight
            degress = 0;
        } else if(t.a == -1.0 && t.b == 0 && t.c == 0 && t.d == -1.0){
            // LandscapeLeft
            degress = 180;
        }
    }
    return degress;
}

/// 修正图片转向
- (UIImage *)fixOrientation:(UIImage *)aImage {
//    if (!self.shouldFixOrientation) return aImage;
    
    // No-op if the orientation is already correct
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}


- (void)exportingProgressDicChanged{
    BOOL all = YES;
    for (AVCompressModel * model in self.outputModels) {
        if (_currentmModel == model) {
            model.progress = _session.progress;
        }
        if (model.status == AVCompressStatusWithSuccess) {
            model.progress = 1;
        }
        if (model.status == AVCompressStatusWithWating || model.status == AVCompressStatusWithCompress) {
            all = NO;
        }
    }
    NSInteger index = [_models indexOfObject:_currentmModel];
    _isAllComplete = all;
    if ([self.delegate respondsToSelector:@selector(avcompressOutputModelArray:andCurrentIndex:)]) {
        [self.delegate avcompressOutputModelArray:self.outputModels andCurrentIndex:index];
    }
    if (_isAllComplete && [self.delegate respondsToSelector:@selector(avcompressAllCompleteOutputModelArray:)]) {
        [self.delegate avcompressAllCompleteOutputModelArray:self.outputModels];
        [self.timer setFireDate:[NSDate distantFuture]];
        NSLog(@"%@",self.timer);
    }
    
    
}


- (void)setModels:(NSMutableArray<AVCompressModel *> *)models{
    _models = models;
    _isAllComplete = NO;
    [self.outputModels removeAllObjects];
    [self.outputModels addObjectsFromArray:_models];
}

- (void)setCurrentmModel:(AVCompressModel *)currentmModel{
    _currentmModel = currentmModel;
}


- (void)nextAsset{
    NSInteger index = [_models indexOfObject:_currentmModel];
    if (index+1 < _models.count) {
        _currentmModel = _models[index+1];
        [self compressAssetWithModel:_currentmModel];
    }else{
        for (AVCompressModel * model in _models) {
            if (model.status == AVCompressStatusWithWating) {
                _currentmModel = model;
                [self compressAssetWithModel:_currentmModel];
                return;
            }
        }
    }
}

- (void)compressAssetWithModel:(AVCompressModel *)model{
    [self getVideoOutputPathWithAssetModel:model presetName:AVAssetExportPresetMediumQuality success:^(NSString *outputPath) {
        model.outputPath = outputPath;
        model.status = AVCompressStatusWithSuccess;
        model.uploadStatus = AVUploadStatusWithWating;
    } failure:^(NSString *errorMessage, NSError *error) {
        model.status = AVCompressStatusWithFailure;
        model.outputPath = nil;
    }];
}

- (void)startCompress{
    if (_currentmModel.asset) {
        [self compressAssetWithModel:_currentmModel];
    }
    
}

- (void)resetCompressModel:(AVCompressModel *)model{
    if ([_models containsObject:model]) {
        model.status = AVCompressStatusWithWating;
    }
    if (_currentmModel.status == AVCompressStatusWithSuccess || _currentmModel.status == AVCompressStatusWithFailure) {
        _currentmModel = model;
        [self compressAssetWithModel:_currentmModel];
    }
}

- (NSMutableArray<AVCompressModel *> *)outputModels{
    if (!_outputModels) {
        _outputModels = [NSMutableArray array];
    }
    return _outputModels;
}

- (NSTimer *)timer{
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval: 0.5 target: self selector: @selector(exportingProgressDicChanged) userInfo: nil repeats: YES];
        [[NSRunLoop mainRunLoop] addTimer: _timer forMode: NSDefaultRunLoopMode];
    }
    return _timer;
}


@end



@implementation AVCompressModel

- (NSString *)getStatus{
    switch (_status) {
        case AVCompressStatusWithWating:
            return @"等待压缩";
            break;
        case AVCompressStatusWithCompress:
            return @"正在压缩";
            break;
        case AVCompressStatusWithFailure:
            return @"压缩失败";
            break;
        case AVCompressStatusWithSuccess:
            return @"压缩成功";
            break;
        default:
            return @"未知状态";
            break;
    }
}

- (NSString *)getUploadStatus{
    switch (_uploadStatus) {
        case AVUploadStatusWithWating:
            return @"等待上传";
            break;
        case AVUploadStatusWithUpload:
            return @"正在上传";
            break;
        case AVUploadStatusWithFailure:
            return @"上传失败";
            break;
        case AVUploadStatusWithSuccess:
            return @"上传成功";
            break;
        default:
            return @"未知状态";
            break;
    }
}


@end
