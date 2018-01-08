//
//  UIView+cutRound.m
//  Crowdfunding
//
//  Created by 任敬 on 2017/12/18.
//  Copyright © 2017年 任敬. All rights reserved.
//

#import "UIView+cutRound.h"

@implementation UIView (cutRound)

// 切圆角
- (void)cutRoundWithCorner:(CGFloat)corner{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(corner, corner)];
    shapeLayer.path = path.CGPath;
    self.layer.mask = shapeLayer;
}

@end
