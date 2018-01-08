//
//  RRRCache.h
//  Store
//
//  Created by 任敬 on 2017/7/25.
//  Copyright © 2017年 任敬. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RRRCache : NSObject

@property (nonatomic, strong) YYCache * cache;

+ (RRRCache *)shareRRRCache;

- (MemberManager *)getMemberManager;

- (void)saveMemberManager;

- (void)deleteMemberManager;


@end
