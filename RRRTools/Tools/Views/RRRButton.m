//
//  RRRButton.m
//  RAC&MVVM
//
//  Created by 任敬 on 2017/6/30.
//  Copyright © 2017年 任敬. All rights reserved.
//

#import "RRRButton.h"




@interface RRRButton ()



@end

@implementation RRRButton



- (void)awakeFromNib{
    [super awakeFromNib];


}


- (void)setCornerRadius:(CGFloat)cornerRadius{
    self.layer.cornerRadius = cornerRadius;
}

- (void)setMasksToBounds:(BOOL)masksToBounds{
    self.layer.masksToBounds = masksToBounds;
}

- (void)setBoardColor:(UIColor *)boardColor{
    self.layer.borderColor = boardColor.CGColor;
}

- (void)setBoardWidth:(CGFloat)boardWidth{
    self.layer.borderWidth = boardWidth;
}



+(RRRButton *)createButtonWithFrame:(CGRect)frame andType:(UIButtonType)type andTitle:(NSString *)title andButtonColor:(UIColor *)color andTarget:(id)target action:(SEL)selection forControlEvents:(UIControlEvents)event{
    RRRButton * button = [RRRButton buttonWithType:type];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    button.backgroundColor = color;
    [button addTarget:target action:selection forControlEvents:event];
    return button;
}


+ (RRRButton *)createCountDownButtonAddSuperView:(UIView *)superView andFrame:(CGRect)frame{
    RRRButton *button = [[RRRButton alloc]initWithFrame:frame];
    [superView addSubview:button];
    return button;
}




@end
