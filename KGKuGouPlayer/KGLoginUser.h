//
//  KGLoginUser.h
//  KGKuGouPlayer
//
//  Created by neuedu on 15/10/21.
//  Copyright (c) 2015年 neuedu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KGLoginUser : NSObject

/*
 JSON: {
 alt = "http://www.douban.com/people/zhenzhuaibobo/";
 avatar = "http://img3.douban.com/icon/u73444424-3.jpg";
 created = "2013-06-05 10:49:00";
 desc = "\U8354\U679d\U7535\U53f0\Uff1aFM27608\Uff0c\U65e7\U65f6\U65e5\U5149\U518d\U503e\U57ce\n\U65b0\U6d6a\U5fae\U535a\Uff1a\U4e18\U7c73\U7684\U4e18\U7c73";
 id = 73444424;
 "is_banned" = 0;
 "is_suicide" = 0;
 "large_avatar" = "http://img3.douban.com/icon/up73444424-3.jpg";
 "loc_id" = 118124;
 "loc_name" = "\U8fbd\U5b81\U5927\U8fde";
 name = "\U4e18\U7c73\U7684\U4e18\U7c73";
 signature = "\U613f\U6211\U4eec\U6240\U6709\U7684\U610f\U5916\U90fd\U662f\U60ca\U559c\U3002";
 type = user;
 uid = zhenzhuaibobo;
 }
 */

@property (copy, nonatomic) NSString *avatar;
@property (copy, nonatomic) NSString *desc;
@property (copy, nonatomic) NSString *uid;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *large_avatar;

+(instancetype)loginUserWithDictionary:(NSDictionary *)dict;

@end
