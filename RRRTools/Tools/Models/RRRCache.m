//
//  RRRCache.m
//  Store
//
//  Created by 任敬 on 2017/7/25.
//  Copyright © 2017年 任敬. All rights reserved.
//

#import "RRRCache.h"

@implementation RRRCache

static RRRCache * _instance = nil;

+(RRRCache *)shareRRRCache{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[RRRCache alloc]init];
    });
    return _instance;
}

- (void)saveMemberManager{
    [self.cache setObject:[MemberManager shareMemberManager] forKey:@"MemberManager"];
}

- (MemberManager *)getMemberManager{
    return (MemberManager *)[self.cache objectForKey:@"MemberManager"];
}

- (void)deleteMemberManager{
    [MemberManager shareMemberManager].member = nil;
    [MemberManager shareMemberManager].identity = nil;
    [MemberManager shareMemberManager].defaultAddress = nil;
    [self saveMemberManager];
}

@end
