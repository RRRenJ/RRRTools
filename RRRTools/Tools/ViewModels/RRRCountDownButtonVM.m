//
//  RRRCountDownButtonVM.m
//  RAC&MVVM
//
//  Created by 任敬 on 2017/7/3.
//  Copyright © 2017年 任敬. All rights reserved.
//

#import "RRRCountDownButtonVM.h"


@interface RRRCountDownButtonVM ()

@property (nonatomic, assign) NSInteger seconds;

@property (nonatomic, assign) NSInteger totalSeconds;

@property (nonatomic, strong) NSTimer * timer;

@property (nonatomic, copy) NSString * startTitle;
    
@property (nonatomic, copy) NSString * endTitle;

    
@end

@implementation RRRCountDownButtonVM

- (void)setButtonStartTitle:(NSString *)startTitle andEndTitle:(NSString *)endTitle andTotalTime:(NSInteger)totalTime{
    
    self.startTitle = startTitle;
    self.endTitle = endTitle;
    self.totalSeconds = totalTime;
    [self.countDownButton setTitle:self.startTitle forState:UIControlStateNormal];
    
//    [[self.countDownButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
//        [self startCountDown];
//    }];
    
}
    
- (void)startCountDown{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
    self.seconds = self.totalSeconds;
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}
    
-(void)countDown{
   
    NSString *title = [NSString stringWithFormat:@"%zd秒",self.seconds];
    [self.countDownButton setTitle:title forState:UIControlStateDisabled];
    self.countDownButton.enabled = NO;
    if (self.seconds <= 0) {
        [self stopCountDown];
        return;
    }
    self.seconds -- ;
}
    
- (void)stopCountDown{
    if (self.timer) {
        if ([self.timer isValid]) {
            [self.timer invalidate];
            self.seconds =self.totalSeconds;
            self.countDownButton.enabled = YES;
            self.timer = nil;
            [self.countDownButton setTitle:self.endTitle forState:UIControlStateNormal];
        }
    }
}

- (void)setCountDownButton:(RRRButton *)countDownButton{
    _countDownButton = countDownButton;
}

    
@end
