//
//  NSObject+Json.h
//  pm
//
//  Created by Mon on 7/5/15.
//  Copyright (c) 2015 Thomas. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Json)
+ (NSString *)toJSON:(id)parameter;
+ (id)parserJSON:(NSString *)jsonString;
@end
