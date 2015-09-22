//
//  CoreDataMngTool.h
//  iOSCoreDataDemo
//
//  Created by hegf on 15/9/10.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Music.h"

@interface CoreDataMngTool : NSObject

//查询所有Person的方法
+(NSArray*)serachMusics;

//删除一个Person的方法
+(void)deleteMusics:(Music *)music;

//查询所有以keyString开头的人
//+(NSArray*)searchMusicsWithKeyString:(NSString* )keyString;
@end
