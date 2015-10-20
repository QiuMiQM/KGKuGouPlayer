//
//  SaveList.m
//  KGKuGouPlayer
//
//  Created by neuedu on 15/9/30.
//  Copyright (c) 2015年 neuedu. All rights reserved.
//

#import "SaveList.h"
#import "AppDelegate.h"

@implementation SaveList

@dynamic name;
@dynamic musics;
@dynamic isShow;

+(instancetype)saveListWithDict:(NSDictionary *)dict
{
    AppDelegate* delegate = [UIApplication sharedApplication].delegate;
    
    SaveList *saveList = [NSEntityDescription insertNewObjectForEntityForName:@"SaveList" inManagedObjectContext:delegate.managedObjectContext];
    
    saveList.name = [dict objectForKey:@"name"];
    saveList.isShow = NO;
    [delegate saveContext];
    
    return saveList;
}

@end
