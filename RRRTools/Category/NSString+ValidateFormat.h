//
//  NSString+ValidateFormat.h
//  Store
//
//  Created by 任敬 on 2017/7/23.
//  Copyright © 2017年 任敬. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ValidateFormat)

+ (BOOL)isValidatePhoneNumber:(NSString *)phoneNumber;

+ (BOOL)isValidatePassword:(NSString *)password;

+ (BOOL)isValidateJustLongPassword:(NSString *)password;

+ (BOOL)isValidateJustInteger:(NSString *)str;

+ (BOOL)isPureFloat:(NSString*)string;
@end
