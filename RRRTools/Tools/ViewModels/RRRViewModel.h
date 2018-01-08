//
//  RRRViewModel.h
//  RAC&MVVM
//
//  Created by 任敬 on 2017/7/3.
//  Copyright © 2017年 任敬. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RRRViewModel : NSObject

@property (nonatomic, copy) SuccessBlock successBlock;
@property (nonatomic, copy) ErrorBlock errorBlock;
@property (nonatomic, assign) ProgressBlock progressBlock;

@end
