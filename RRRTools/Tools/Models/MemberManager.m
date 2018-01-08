//
//  MemberManager.m
//  Store
//
//  Created by 任敬 on 2017/7/23.
//  Copyright © 2017年 任敬. All rights reserved.
//

#import "MemberManager.h"

@implementation MemberManager


static MemberManager * _instance = nil;

+(MemberManager *)shareMemberManager{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[MemberManager alloc]init];
    });
    return _instance;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.identity forKey:@"identity"];
    [aCoder encodeObject:self.member forKey:@"member"];
    [aCoder encodeObject:self.defaultAddress forKey:@"defaultAddress"];
   
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self.identity = [aDecoder decodeObjectForKey:@"identity"];
    self.member = [aDecoder decodeObjectForKey:@"member"];
    self.defaultAddress = [aDecoder decodeObjectForKey:@"defaultAddress"];
    return self;
}

- (NSMutableArray *)CFTypeArray{
    if (!_CFTypeArray) {
        _CFTypeArray = [NSMutableArray array];
    }
    return _CFTypeArray;
}


@end
