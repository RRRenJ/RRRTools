//
//  RRRCountDownButtonVM.h
//  RAC&MVVM
//
//  Created by 任敬 on 2017/7/3.
//  Copyright © 2017年 任敬. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RRRButton.h"

@interface RRRCountDownButtonVM : NSObject

@property (nonatomic, strong) RRRButton * countDownButton;


- (void)setButtonStartTitle:(NSString *)startTitle andEndTitle:(NSString *)endTitle andTotalTime:(NSInteger )totalTime;
    
- (void)startCountDown;
    
@end
