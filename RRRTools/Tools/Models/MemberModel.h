//
//  MemberModel.h
//  LuminousWisdom
//
//  Created by 任敬 on 2017/9/5.
//  Copyright © 2017年 任敬. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MemberModel : NSObject<NSCoding>

@property (nonatomic, copy) NSString * user_id;

@property (nonatomic, copy) NSString * header;

@property (nonatomic, copy) NSString * nickName;

@property (nonatomic, copy) NSString * motto;

@property (nonatomic, assign) NSInteger  certification;

@property (nonatomic, copy) NSString * address;


- (NSString *)getCerti;

@end
