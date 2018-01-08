//
//  RRRLabel.h
//  Store
//
//  Created by 任敬 on 2017/7/5.
//  Copyright © 2017年 任敬. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE

@interface RRRLabel : UILabel




@property (nonatomic, assign)IBInspectable CGFloat cornerRadius;
@property (nonatomic, assign)IBInspectable BOOL masksToBounds;


+ (RRRLabel *)createLabelWithText:(NSString *)text andTextColor:(UIColor *)textColor andTextFont:(CGFloat)fontSize andTextAlignment:(NSTextAlignment)textAlignment;


+ (RRRLabel *)createLabelWithFrame:(CGRect)frame andText:(NSString *)text andTextColor:(UIColor *)textColor andTextFont:(CGFloat)fontSize andTextAlignment:(NSTextAlignment)textAlignment;

@end
