//
//  Music.h
//  KGKuGouPlayer
//
//  Created by neuedu on 15/9/18.
//  Copyright (c) 2015年 neuedu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface Music : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * index;
@property (nonatomic, retain) NSString * singer;
@property (nonatomic, retain) NSString * time;

+(instancetype)musicWithDict:(NSDictionary *)dict;

@end
