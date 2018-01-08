//
//  NSObject+Json.m
//  pm
//
//  Created by Mon on 7/5/15.
//  Copyright (c) 2015 Thomas. All rights reserved.
//

#import "NSObject+Json.h"

@implementation NSObject (Json)

// 将字典或者数组转化为JSON串
+ (NSString *)toJSON:(id)parameter{
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:parameter
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    if ([jsonData length] > 0 && error == nil){
        return [[NSString alloc] initWithData:jsonData
                                     encoding:NSUTF8StringEncoding];;
    }else{
        return nil;
    }
}

// 将JSON串转化为字典或者数组

+ (id)parserJSON:(NSString *)jsonString{
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    if (jsonData == nil) {
        return nil;
    }
    NSError *error = nil;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData
                                                    options:NSJSONReadingAllowFragments
                                                      error:&error];
    if (jsonObject != nil && error == nil){
        return jsonObject;
    }else{
        // 解析错误
        return nil;
    }
}


@end
