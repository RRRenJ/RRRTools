//
//  RRRLabel.m
//  Store
//
//  Created by 任敬 on 2017/7/5.
//  Copyright © 2017年 任敬. All rights reserved.
//

#import "RRRLabel.h"
#import "UILabel+LabelSize.h"

@implementation RRRLabel


- (void)awakeFromNib{
    [super awakeFromNib];

    
}


- (void)setCornerRadius:(CGFloat)cornerRadius{
    self.layer.cornerRadius = cornerRadius;
}

- (void)setMasksToBounds:(BOOL)masksToBounds{
    self.layer.masksToBounds = masksToBounds;
}




-(instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        
        
        self.text = @"--";
        self.textColor = [UIColor blackColor];
        self.font = RRRFont(16);
    }
    return self;
}


+ (RRRLabel *)createLabelWithText:(NSString *)text andTextColor:(UIColor *)textColor andTextFont:(CGFloat)fontSize andTextAlignment:(NSTextAlignment)textAlignment{
    
    RRRLabel * label = [[RRRLabel alloc]init];
    label.text = text;
    label.textColor = textColor;
//    label.font = [UIFont systemFontOfSize:fontSize];
    label.font = RRRFont(fontSize);
    label.textAlignment = textAlignment;
    
    return label;
}


+ (RRRLabel *)createLabelWithFrame:(CGRect)frame andText:(NSString *)text andTextColor:(UIColor *)textColor andTextFont:(CGFloat)fontSize andTextAlignment:(NSTextAlignment)textAlignment{
    
    RRRLabel * label = [RRRLabel createLabelWithText:text andTextColor:textColor andTextFont:fontSize andTextAlignment:textAlignment];
    label.frame = frame;
    
    return label;
    
}




@end
