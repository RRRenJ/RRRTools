//
//  UILabel+LabelHeight.m
//  Store
//
//  Created by 任敬 on 2017/7/6.
//  Copyright © 2017年 任敬. All rights reserved.
//

#import "UILabel+LabelSize.h"

@implementation UILabel (LabelSize)

+ (CGFloat)getWidthByTitle:(NSString *)title AndFont:(CGFloat)font{
    NSDictionary *attrs = @{NSFontAttributeName : [UIFont systemFontOfSize:font]};
    CGSize size=[title sizeWithAttributes:attrs];
    return size.width+5;
}

+ (CGFloat)getHeightByWidth:(CGFloat)width andTitle:(NSString *)title andFont:(CGFloat)font andNumberOfLines:(NSInteger)number{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 0)];
    label.text = title;
    label.font = [UIFont systemFontOfSize:font];
    label.numberOfLines = number;
    [label sizeToFit];
    CGFloat height = label.frame.size.height;
    return height;
}


@end
