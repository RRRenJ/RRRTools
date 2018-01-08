//
//  NSObject+AboutDate.h
//  Store
//
//  Created by 任敬 on 2017/9/20.
//  Copyright © 2017年 任敬. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (AboutDate)
//和当前时间比较返回对应格式
+ (NSString*)compareTime:(NSString *)time;


+ (NSString*)formatYYMMDDTime:(NSString *)time;

@end
