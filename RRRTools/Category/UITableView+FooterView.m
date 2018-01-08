//
//  UITableView+FooterView.m
//  Store
//
//  Created by 任敬 on 2017/7/5.
//  Copyright © 2017年 任敬. All rights reserved.
//

#import "UITableView+FooterView.h"


@implementation UITableView (FooterView)

- (void)footerViewWithEmptyView{
    if(iPhoneX){
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCR_WIDTH, 34)];
        view.backgroundColor = BACKGROUND_COLOR;
        self.tableFooterView = view;
    }else{
        self.tableFooterView = [[UIView alloc]init];
    }
    
}
- (void)footerViewWithEmptyViewAlliPhone{
    self.tableFooterView = [[UIView alloc]init];
}


- (void)footerViewWithString:(NSString *)string{
    [self footerViewWithString:string andFrame:CGRectMake(SCR_WIDTH - 50, SCR_HEIGHT/3/2, 100, 20)];
}

-(void)footerViewWithImageName:(NSString *)imageName{
    
    [self footerViewWithImageName:imageName andFrame: CGRectMake(SCR_WIDTH - 50, SCR_HEIGHT/3/2, 100, 100)];
}

- (void)footerViewWithImageName:(NSString *)imageName andString:(NSString *)string{
    [self footerViewWithImageName:imageName andImageFrame:CGRectMake(SCR_WIDTH - 50, SCR_HEIGHT/3/2, 100, 100) andString:string andStringFrame:CGRectMake(SCR_WIDTH - 50, SCR_HEIGHT/3/2+60, 100, 20)];
}


- (void)footerViewWithImageName:(NSString *)imageName andFrame:(CGRect)frame{
    UIView * errorView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCR_WIDTH, SCR_HEIGHT/3)];
    UIImageView * errorImageView = [[UIImageView alloc]init];
    [errorView addSubview:errorImageView];
    errorImageView.image = [UIImage imageNamed:imageName];
    errorImageView.frame = frame;
    self.tableFooterView = errorView;
}

- (void)footerViewWithString:(NSString *)string andFrame:(CGRect)frame{
    UIView * errorView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCR_WIDTH, SCR_HEIGHT/3)];
    RRRLabel * remindLabel = [RRRLabel createLabelWithText:string andTextColor:GRAY_TEXT_COLOR andTextFont:16 andTextAlignment:NSTextAlignmentCenter];
    [errorView addSubview:remindLabel];
    remindLabel.frame = frame;
    self.tableFooterView = errorView;
}

- (void)footerViewWithImageName:(NSString *)imageName andImageFrame:(CGRect)imageFrame andString:(NSString *)string andStringFrame:(CGRect)stringFrame{
    UIView * errorView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCR_WIDTH, SCR_HEIGHT/3)];
    UIImageView * errorImageView = [[UIImageView alloc]init];
    [errorView addSubview:errorImageView];
    errorImageView.image = [UIImage imageNamed:imageName];
    RRRLabel * remindLabel = [RRRLabel createLabelWithText:string andTextColor:GRAY_TEXT_COLOR andTextFont:16 andTextAlignment:NSTextAlignmentCenter];
    [errorView addSubview:remindLabel];
    errorImageView.frame = imageFrame;
    remindLabel.frame = stringFrame;
    self.tableFooterView = errorView;
}


@end
