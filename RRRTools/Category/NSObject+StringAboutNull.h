//
//  NSObject+StringAboutNull.h
//  SmartFactory
//
//  Created by RRR on 2016/12/11.
//  Copyright © 2016年 RRR. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (StringAboutNull)

-(BOOL)isNull;

-(NSString *)nullConvertIntoZero:(NSString *)string;

-(NSString *)nullConvertIntoSpace:(NSString *)string;

-(NSString *)nullConvertIntoNothing:(NSString *)string;

@end
