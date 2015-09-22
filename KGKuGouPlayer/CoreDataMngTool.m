//
//  CoreDataMngTool.m
//  iOSCoreDataDemo
//
//  Created by hegf on 15/9/10.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "CoreDataMngTool.h"
#import <CoreData/CoreData.h>
#import "AppDelegate.h"

@implementation CoreDataMngTool

+(NSArray *)serachMusics
{
    
    AppDelegate* delegate = [UIApplication sharedApplication].delegate;
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *desc = [NSEntityDescription entityForName:@"Music" inManagedObjectContext:delegate.managedObjectContext];
    request.entity = desc;
    
//    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"age" ascending:YES];
//    request.sortDescriptors = [NSArray arrayWithObject:sort];
    
    NSError *error = nil;
    NSArray *objs = [delegate.managedObjectContext executeFetchRequest:request error:&error];
    if (error)
    {
        [NSException raise:@"查询错误" format:@"%@", [error localizedDescription]];
    }
    
    return objs;

}

+(void)deleteMusics:(Music *)music
{
    
    AppDelegate* delegate = [UIApplication sharedApplication].delegate;
    [delegate.managedObjectContext deleteObject:music];
    
    NSError *error = nil;
    [delegate.managedObjectContext save:&error];
    if (error)
    {
        [NSException raise:@"删除错误" format:@"%@", [error localizedDescription]];
    }
}

//+(NSArray *)searchPersonsWithKeyString:(NSString *)keyString{
//    AppDelegate* delegate = [UIApplication sharedApplication].delegate;
//    
//    NSFetchRequest *request = [[NSFetchRequest alloc] init];
//    
//    NSEntityDescription *desc = [NSEntityDescription entityForName:@"CoredataContact" inManagedObjectContext:delegate.managedObjectContext];
//    request.entity = desc;
//    
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name BEGINSWITH[cd] %@", keyString];
//    request.predicate = predicate;
//                              
//    NSError *error = nil;
//    NSArray *objs = [delegate.managedObjectContext executeFetchRequest:request error:&error];
//    if (error) {
//        [NSException raise:@"查询错误" format:@"%@", [error localizedDescription]];
//    }
//    
//    return objs;
//    
//}

@end
