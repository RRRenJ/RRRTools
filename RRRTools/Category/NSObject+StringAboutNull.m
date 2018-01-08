//
//  NSObject+StringAboutNull.m
//  SmartFactory
//
//  Created by RRR on 2016/12/11.
//  Copyright © 2016年 RRR. All rights reserved.
//

#import "NSObject+StringAboutNull.h"

@implementation NSObject (StringAboutNull)

-(BOOL)isNull{
    // 判断是否为空串
    if ([self isEqual:[NSNull null]]) {
        return YES;
    }
    else if ([self isKindOfClass:[NSNull class]])
    {
        return YES;
    }
    else if (self==nil){
        return YES;
    }
    return NO;
}

-(NSString*)nullConvertIntoZero:(NSString *)string{
    
    // 转换空串
    if ([string isEqual:[NSNull null]]) {
        return @"0";
    }
    else if ([string isKindOfClass:[NSNull class]])
    {
        return @"0";
    }
    else if (string==nil){
        return @"0";
    }
    return string;
    
}

-(NSString *)nullConvertIntoSpace:(NSString *)string{
    // 转换空串
    if ([string isEqual:[NSNull null]]) {
        return @" ";
    }
    else if ([string isKindOfClass:[NSNull class]])
    {
        return @" ";
    }
    else if (string==nil){
        return @" ";
    }
    return string;
}

-(NSString *)nullConvertIntoNothing:(NSString *)string{

    
    if ([string isEqual:[NSNull null]]) {
        return @"";
    }
    else if ([string isKindOfClass:[NSNull class]])
    {
        return @"";
    }
    else if (string==nil){
        return @"";
    }
    return string;
}



@end
