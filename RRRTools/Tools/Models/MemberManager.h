//
//  MemberManager.h
//  Store
//
//  Created by 任敬 on 2017/7/23.
//  Copyright © 2017年 任敬. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MemberModel.h"
#import "AddressModel.h"

@interface MemberManager : NSObject<NSCoding>

@property (nonatomic, strong) UIStoryboard * storyboard;

@property (nonatomic, strong) YYCache * cache;

@property (nonatomic, strong) MemberModel * member;

@property (nonatomic, strong) AddressModel * defaultAddress;

@property (nonatomic, copy) NSString * identity;

@property (nonatomic, strong) NSMutableArray * CFTypeArray;

@property (nonatomic, assign) NSInteger tabBarCurrentIndex;


+ (MemberManager *)shareMemberManager;

@end
