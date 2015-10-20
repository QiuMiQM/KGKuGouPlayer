//
//  KGAccessToken.h
//  KGKuGouPlayer
//
//  Created by neuedu on 15/10/20.
//  Copyright (c) 2015年 neuedu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KGAccessToken : NSObject

/*
 "access_token" = 7d2fce5e2ecf6e54778f6b1a8c6e4afc;
 "douban_user_id" = 73444424;
 "douban_user_name" = "\U4e18\U7c73\U7684\U4e18\U7c73";
 "expires_in" = 604800;
 "refresh_token" = 842fa98fee90c6d78c8efcafcbb25485;
 */

@property (copy, nonatomic) NSString *access_token;
@property (copy, nonatomic) NSString *douban_user_id;
@property (copy, nonatomic) NSString *douban_user_name;
@property (copy, nonatomic) NSString *expires_in;
@property (copy, nonatomic) NSString *refresh_token;

+(instancetype)accessTokenWithDict:(NSDictionary *)dict;

@end
