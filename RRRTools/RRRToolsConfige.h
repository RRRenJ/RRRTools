//
//  RRRToolsConfige.h
//  RRRTools
//
//  Created by 任敬 on 2018/1/5.
//  Copyright © 2018年 任敬. All rights reserved.
//

#ifndef RRRToolsConfige_h
#define RRRToolsConfige_h


typedef void (^SuccessBlock) (id successValue);
typedef void (^ErrorBlock) (id errorValue);
typedef void (^ProgressBlock) (float progressValue);

#define SCR_WIDTH   [UIScreen mainScreen].bounds.size.width
#define SCR_HEIGHT  [UIScreen mainScreen].bounds.size.height

#define StatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
#define NavBarHeight 44.0
#define TabBarHeight ([[UIApplication sharedApplication] statusBarFrame].size.height>20?83:49)
#define BottomHeight ([[UIApplication sharedApplication] statusBarFrame].size.height>20?34:0)
#define TopHeight (StatusBarHeight + NavBarHeight)

#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

#define SCREEN_MAX_LENGTH (MAX(SCR_WIDTH, SCR_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCR_WIDTH, SCR_HEIGHT))
/*********** 机型判断 ************/
#define iPhone4s (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define iPhoneSE (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define iPhone7 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define iPhone7P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)
#define iPhoneX (IS_IPHONE && SCREEN_MAX_LENGTH == 812.0)


#define BACKGROUND_COLOR [UIColor colorWithHexCode:@"f3f3f3"]
#define GRAY_TEXT_COLOR [UIColor colorWithHexCode:@"999999"]
#define WhiteColor [UIColor whiteColor]
#define BlackColor [UIColor blackColor]

#define Page_Size 10



#endif /* RRRToolsConfige_h */
