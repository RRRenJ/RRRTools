//
//  MemberModel.m
//  LuminousWisdom
//
//  Created by 任敬 on 2017/9/5.
//  Copyright © 2017年 任敬. All rights reserved.
//

#import "MemberModel.h"
#import "NSObject+StringAboutNull.h"

@interface MemberModel ()<YYModel>

@end

@implementation MemberModel

+ (NSDictionary *)modelCustomPropertyMapper{
    NSDictionary *dic=@{@"nickName":@"nick_name",@"motto":@"about_me",@"Id":@"id",@"header":@"avatar_url"};
    return dic;
}

- (NSString *)header{
    return [_header stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}


- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.nickName forKey:@"nickName"];
    [aCoder encodeObject:self.header forKey:@"header"];
    [aCoder encodeObject:self.address forKey:@"address"];
    [aCoder encodeObject:self.motto forKey:@"motto"];
    [aCoder encodeObject:self.user_id forKey:@"user_id"];
    
}
-(id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
     
        self.nickName= [aDecoder decodeObjectForKey:@"nickName"];
        self.header= [aDecoder decodeObjectForKey:@"header"];
        self.address= [aDecoder decodeObjectForKey:@"address"];
        self.motto= [aDecoder decodeObjectForKey:@"motto"];
        self.user_id= [aDecoder decodeObjectForKey:@"user_id"];
    }
    return self;
}

- (NSString *)getCerti{
    switch (_certification) {
        case 0:
            return @"未认证";
            break;
        case 1:
            return @"已认证";
            break;
        default:
            return @"未知";
            break;
    }
}


@end
