//
//  KGLoginUser.m
//  KGKuGouPlayer
//
//  Created by neuedu on 15/10/21.
//  Copyright (c) 2015年 neuedu. All rights reserved.
//

#import "KGLoginUser.h"

@implementation KGLoginUser

+(instancetype)loginUserWithDictionary:(NSDictionary *)dict
{
    KGLoginUser *loginUser = [[KGLoginUser alloc]init];
    if (loginUser)
    {
        loginUser.avatar = [dict objectForKey:@"avatar"];
        loginUser.desc = [dict objectForKey:@"desc"];
        loginUser.uid = [dict objectForKey:@"uid"];
        loginUser.name = [dict objectForKey:@"name"];
        loginUser.large_avatar = [dict objectForKey:@"large_avatar"];
    }
    return loginUser;
}

@end
