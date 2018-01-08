//
//  NSObject+AboutDate.m
//  Store
//
//  Created by 任敬 on 2017/9/20.
//  Copyright © 2017年 任敬. All rights reserved.
//

#import "NSObject+AboutDate.h"

@implementation NSObject (AboutDate)

+ (NSString *)compareTime:(NSString *)time{
    NSDateFormatter *dateFomatter = [[NSDateFormatter alloc] init];
    
    dateFomatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    // 截止时间data格式
    NSDate * expireDate = [dateFomatter dateFromString:time];
    // 当前时间data格式
    NSDate * nowDate = [NSDate date];
    // 当前日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // 需要对比的时间数据
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth
    | NSCalendarUnitDay ;
    // 对比时间差
    NSDateComponents *dateCom = [calendar components:unit fromDate:nowDate toDate:expireDate options:0];
    
    if (dateCom.year) {
        dateFomatter.dateFormat = @"yyyy-MM-dd";
        return [dateFomatter stringFromDate:expireDate];
    }
    if (dateCom.month) {
        dateFomatter.dateFormat = @"MM-dd";
        return [dateFomatter stringFromDate:expireDate];
    }
    if (dateCom.day) {
        dateFomatter.dateFormat = @"MM-dd HH:mm";
        return [dateFomatter stringFromDate:expireDate];
    }
    
    dateFomatter.dateFormat = @"MM-dd HH:mm";
    return [dateFomatter stringFromDate:expireDate];
    
}

+ (NSString *)formatYYMMDDTime:(NSString *)time{
    NSDateFormatter *dateFomatter = [[NSDateFormatter alloc] init];
    dateFomatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate * date = [dateFomatter dateFromString:time];
    dateFomatter.dateFormat = @"yyyy-MM-dd";
    return [dateFomatter stringFromDate:date];
}


@end
