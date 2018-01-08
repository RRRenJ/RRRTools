//
//  NSString+ValidateFormat.m
//  Store
//
//  Created by 任敬 on 2017/7/23.
//  Copyright © 2017年 任敬. All rights reserved.
//

#import "NSString+ValidateFormat.h"

@implementation NSString (ValidateFormat)



+ (BOOL)isValidatePhoneNumber:(NSString *)phoneNumber{
    NSString *phoneNumberRegex = @"^1[345789]\\d{9}$";
    NSPredicate *phoneNumberTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneNumberRegex];
    return [phoneNumberTest evaluateWithObject:phoneNumber];
}

+ (BOOL)isValidatePassword:(NSString *)password{
    NSString *passwordRegex = @"^[0-9a-zA-Z~@#$%^&*()]{6,16}$";
    NSPredicate *passwordTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", passwordRegex];
    return [passwordTest evaluateWithObject:password];
}

+ (BOOL)isValidateJustLongPassword:(NSString *)password{
    NSString *passwordRegex = @"^.{6,16}$";
    NSPredicate *passwordTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", passwordRegex];
    return [passwordTest evaluateWithObject:password];
}

+ (BOOL)isValidateJustInteger:(NSString *)str{
    NSString *passwordRegex = @"^[0-9]*$";
    NSPredicate *passwordTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", passwordRegex];
    return [passwordTest evaluateWithObject:str];
}

+ (BOOL)isPureFloat:(NSString*)string{
    
    NSScanner* scan = [NSScanner scannerWithString:string];
    
    float val;
    
    return[scan scanFloat:&val] && [scan isAtEnd];
    
}

+ (BOOL)isPureInt:(NSString*)string{
    
    NSScanner* scan = [NSScanner scannerWithString:string];
    
    int val;
    
    return[scan scanInt:&val] && [scan isAtEnd];
    
}




@end
