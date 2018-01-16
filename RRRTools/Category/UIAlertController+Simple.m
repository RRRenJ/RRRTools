//
//  UIAlertController+Simple.m
//  RACDemo
//
//  Created by 任敬 on 2018/1/16.
//  Copyright © 2018年 任敬. All rights reserved.
//

#import "UIAlertController+Simple.h"

@implementation UIAlertController (Simple)


+ (UIAlertController *)alertControllerWithTitle:(NSString *)title message:(NSString *)message preferredStyle:(UIAlertControllerStyle)style actions:(NSArray <NSDictionary *>*)actions actionHandler:(void (^)(NSInteger))handler{
    UIAlertController * alertController =  [UIAlertController alertControllerWithTitle:title message:message preferredStyle:style];
    for (int index = 0; index < actions.count ; index ++) {
        UIAlertAction * action = [UIAlertAction actionWithTitle:actions[index].allKeys.firstObject style:(UIAlertActionStyle)actions[index].allValues.firstObject handler:^(UIAlertAction * _Nonnull action) {
            handler(index);
        }];
        [alertController addAction:action];
    }
    return alertController;
}


@end
