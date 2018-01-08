//
//  AVCompress.h
//  yasuo
//
//  Created by 任敬 on 2017/12/25.
//  Copyright © 2017年 任敬. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>

@class AVCompressModel;

typedef NS_ENUM(NSInteger,AVCompressStatus) {
    AVCompressStatusWithWating,
    AVCompressStatusWithCompress,
    AVCompressStatusWithSuccess,
    AVCompressStatusWithFailure,
};

typedef NS_ENUM(NSInteger,AVUploadStatus) {
    AVUploadStatusWithWating = 100,
    AVUploadStatusWithUpload,
    AVUploadStatusWithSuccess,
    AVUploadStatusWithFailure,
};


@protocol AVCompressDelegate <NSObject>

- (void)avcompressOutputModelArray:(NSMutableArray<AVCompressModel *>*)modelArray andCurrentIndex:(NSInteger)index;

- (void)avcompressAllCompleteOutputModelArray:(NSMutableArray<AVCompressModel *>*)modelArray;

@end


@interface AVCompress : NSObject

+ (instancetype)manager;



@property (nonatomic, strong) NSMutableArray <AVCompressModel *>* models;

@property (nonatomic, strong) AVCompressModel * currentmModel;

@property (nonatomic, strong) NSMutableArray  <AVCompressModel *>* outputModels;

@property (nonatomic, weak) id<AVCompressDelegate>delegate;

- (void)startCompress;

- (void)resetCompressModel:(AVCompressModel *)model;

@end

@interface AVCompressModel :NSObject

@property (nonatomic, strong) PHAsset * asset;

@property (nonatomic, strong) NSString * outputPath;

@property (nonatomic, strong) UIImage * image;

@property (nonatomic, assign) float progress;

@property (nonatomic, assign) AVCompressStatus status;

@property (nonatomic, assign) AVUploadStatus uploadStatus;

- (NSString *)getStatus;

- (NSString *)getUploadStatus;

@end
