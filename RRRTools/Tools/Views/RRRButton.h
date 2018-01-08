//
//  RRRButton.h
//  RAC&MVVM
//
//  Created by 任敬 on 2017/6/30.
//  Copyright © 2017年 任敬. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIButton+ImageAndText.h"

IB_DESIGNABLE
@interface RRRButton : UIButton




@property (nonatomic, assign)IBInspectable CGFloat cornerRadius;
@property (nonatomic, assign)IBInspectable BOOL masksToBounds;
@property (nonatomic, assign)IBInspectable CGFloat boardWidth;
@property (nonatomic, assign)IBInspectable UIColor * boardColor;


/**
 按键

 @param frame frame
 @param type 按键类型
 @param title 按键名称
 @param color 按键颜色
 @param target 目标
 @param selection 按键方法
 @param event 相应手势
 @return RRRButton
 */
+ (RRRButton *)createButtonWithFrame:(CGRect)frame andType:(UIButtonType)type andTitle:(NSString *)title andButtonColor:(UIColor *)color andTarget:(id)target action:(SEL)selection forControlEvents:(UIControlEvents)event;


+ (RRRButton *)createCountDownButtonAddSuperView:(UIView *)superView andFrame:(CGRect)frame;


@end
