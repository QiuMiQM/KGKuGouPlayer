//
//  SaveList.h
//  KGKuGouPlayer
//
//  Created by neuedu on 15/9/30.
//  Copyright (c) 2015年 neuedu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Music;

@interface SaveList : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *musics;
@property (nonatomic, assign) BOOL isShow;

+(instancetype)saveListWithDict:(NSDictionary *)dict;

@end

@interface SaveList (CoreDataGeneratedAccessors)

- (void)addMusicsObject:(Music *)value;
- (void)removeMusicsObject:(Music *)value;
- (void)addMusics:(NSSet *)values;
- (void)removeMusics:(NSSet *)values;

@end
