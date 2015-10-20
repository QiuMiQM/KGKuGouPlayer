//
//  KGAccessToken.m
//  KGKuGouPlayer
//
//  Created by neuedu on 15/10/20.
//  Copyright (c) 2015年 neuedu. All rights reserved.
//

#import "KGAccessToken.h"

@implementation KGAccessToken

+(instancetype)accessTokenWithDict:(NSDictionary *)dict
{
    KGAccessToken *token = [[KGAccessToken alloc]init];
    if (token)
    {
        token.access_token = [dict objectForKey:@"access_token"];
        token.douban_user_id = [dict objectForKey:@"douban_user_id"];
        token.douban_user_name = [dict objectForKey:@"douban_user_name"];
        token.expires_in = [dict objectForKey:@"expires_in"];
        token.refresh_token = [dict objectForKey:@"refresh_token"];
    }
    return token;
}

@end
