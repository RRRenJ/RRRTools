//
//  UISearchBar+SearchBarPlaceholder.m
//  Store
//
//  Created by 任敬 on 2017/7/7.
//  Copyright © 2017年 任敬. All rights reserved.
//

#import "UISearchBar+SearchBarPlaceholder.h"

@implementation UISearchBar (SearchBarPlaceholder)

-(void)changeLeftPlaceholder:(NSString *)placeholder {
    self.placeholder = placeholder;
    SEL centerSelector = NSSelectorFromString([NSString stringWithFormat:@"%@%@", @"setCenter", @"Placeholder:"]);
    if ([self respondsToSelector:centerSelector]) {
        BOOL centeredPlaceholder = NO;
        NSMethodSignature *signature = [[UISearchBar class] instanceMethodSignatureForSelector:centerSelector];
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
        [invocation setTarget:self];
        [invocation setSelector:centerSelector];
        [invocation setArgument:&centeredPlaceholder atIndex:2];
        [invocation invoke];
    }
}

@end
