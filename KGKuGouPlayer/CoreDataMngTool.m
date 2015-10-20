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

//单例2.定义一个static类型的tool
static CoreDataMngTool *tool;

@implementation CoreDataMngTool

#pragma mark - 加载全部的歌曲列表
+(void)loadAllMusicList
{
    [CoreDataMngTool deleteAllMusic];
    NSArray *dictList = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"LocolMusicList.plist" ofType:nil]];
    for (int i = 0; i < dictList.count; i++)
    {
        NSDictionary *dict = dictList[i];
        //创建歌曲模型，但是不需要它的返回值
        [Music musicWithDict:dict];
    }
    
    //类方法，无法用“_”调用
    //全盘重新加载完歌曲到数据库中，原来的歌曲列表置空
    [CoreDataMngTool sharedCoredataMngTool].allMusicList = nil;
    [CoreDataMngTool sharedCoredataMngTool].oldMusic = nil;
    [CoreDataMngTool sharedCoredataMngTool].curMusic = nil;
}

#pragma mark 重写getter方法
-(NSArray *)allMusicList
{
    if (_allMusicList == nil)
    {
        _allMusicList = [CoreDataMngTool searchMusics];
    }
    return _allMusicList;
}

-(NSArray *)myLoveMusicList
{
    if (_myLoveMusicList == nil)
    {
        _myLoveMusicList = [CoreDataMngTool searchMyLoveMusics];
    }
    return _myLoveMusicList;
}

//当歌曲以任意形式切换时，都会调用这个设置当前播放音乐的方法
-(void)setCurMusic:(Music *)curMusic
{
    //_curMusic保存的是现在正在播放的歌曲，参数curMusic传入的是将要播放的歌曲
    if (curMusic != nil)
    {
        _oldMusic = _curMusic;
        if (_oldMusic != nil)
        {
            _oldMusic.isPlay = NO;
        }
        _curMusic = curMusic;
        _curMusic.isPlay = YES;
    }
    else
    {
        _curMusic = curMusic;
    }
}

-(Music *)nextMusic
{
    if (self.curPlayList != nil&&self.curPlayList.count != 0)
    {
        if (self.curMusic == nil)
        {
            Music *nextMusic = self.curPlayList[0];
            return nextMusic;
        }
        else
        {
            NSUInteger curMusicIndex = [self.curPlayList indexOfObject:self.curMusic];
            if (curMusicIndex == self.curPlayList.count-1)
            {
                curMusicIndex = -1;
            }
            curMusicIndex++;
            if (curMusicIndex >= self.curPlayList.count)
            {
                return nil;
            }
            else
            {
                Music *nextMusic = self.curPlayList[curMusicIndex];
                return nextMusic;
            }
        }
    }
    else
    {
        return nil;
    }
}

#pragma mark 查询Music
+(NSArray *)searchMusics
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

#pragma mark 查询我喜欢Music
+(NSArray *)searchMyLoveMusics
{
    
    AppDelegate* delegate = [UIApplication sharedApplication].delegate;
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *desc = [NSEntityDescription entityForName:@"Music" inManagedObjectContext:delegate.managedObjectContext];
    request.entity = desc;

    //查询条件的设置
    NSPredicate * qcondition= [NSPredicate predicateWithFormat:@"isMyLove = 1"];
    request.predicate = qcondition;
    
    NSError *error = nil;
    NSArray *objs = [delegate.managedObjectContext executeFetchRequest:request error:&error];
    if (error)
    {
        [NSException raise:@"查询错误" format:@"%@", [error localizedDescription]];
    }
    
    return objs;
}


#pragma mark 删除一个Music
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
    [CoreDataMngTool sharedCoredataMngTool].allMusicList = nil;
}

#pragma mark 删除所有Music
+(void)deleteAllMusic
{
    AppDelegate* delegate = [UIApplication sharedApplication].delegate;
    NSArray *musics = [CoreDataMngTool searchMusics];
    for (int i = 0; i < musics.count; i++)
    {
        [CoreDataMngTool deleteMusics:musics[i]];
    }
    
    NSError *error = nil;
    [delegate.managedObjectContext save:&error];
    if (error)
    {
        [NSException raise:@"删除错误" format:@"%@", [error localizedDescription]];
    }
}

#pragma mark 根据KeyString查询某一首歌曲
+(NSArray*)searchMusicsWithKeyString:(NSString* )keyString
{
    AppDelegate* delegate = [UIApplication sharedApplication].delegate;
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *desc = [NSEntityDescription entityForName:@"CoredataContact" inManagedObjectContext:delegate.managedObjectContext];
    request.entity = desc;
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name BEGINSWITH[cd] %@", keyString];
    request.predicate = predicate;
                              
    NSError *error = nil;
    NSArray *objs = [delegate.managedObjectContext executeFetchRequest:request error:&error];
    if (error)
    {
        [NSException raise:@"查询错误" format:@"%@", [error localizedDescription]];
    }
    
    return objs;
}


#pragma mark - 播放列表相关

#pragma mark 重写getter方法
-(NSArray *)saveNameList
{
    if (_saveNameList == nil)
    {
        _saveNameList = [CoreDataMngTool searchSaveNames];
    }
    return _saveNameList;
}

#pragma mark 查询播放列表
+(NSArray *)searchSaveNames
{
    AppDelegate* delegate = [UIApplication sharedApplication].delegate;
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *desc = [NSEntityDescription entityForName:@"SaveList" inManagedObjectContext:delegate.managedObjectContext];
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

#pragma mark 查询数据库中已有的播放列表
+(NSArray *)searchNameListWithName:(NSString *)saveName
{
    
    AppDelegate* delegate = [UIApplication sharedApplication].delegate;
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *desc = [NSEntityDescription entityForName:@"SaveList" inManagedObjectContext:delegate.managedObjectContext];
    request.entity = desc;
    
    //查询条件的设置
    NSString *conditon = [NSString stringWithFormat:@"name like '%@'",saveName];
    NSPredicate * qcondition= [NSPredicate predicateWithFormat:conditon];
    request.predicate = qcondition;
    
    NSError *error = nil;
    NSArray *objs = [delegate.managedObjectContext executeFetchRequest:request error:&error];
    if (error)
    {
        [NSException raise:@"查询错误" format:@"%@", [error localizedDescription]];
    }
    
    return objs;
}

#pragma mark 添加播放列表
-(BOOL)addSaveList:(NSString *)saveListName
{
    if (saveListName == nil)
    {
        return YES;
    }
    else if ([CoreDataMngTool searchNameListWithName:saveListName].count != 0)
    {
        
        return NO;
    }
    else
    {
        NSDictionary *dict = @{@"name":saveListName};
        [SaveList saveListWithDict:dict];
        [CoreDataMngTool sharedCoredataMngTool].saveNameList = nil;
        return YES;
    }
}

#pragma mark 删除一个播放列表
+(void)deleteSaveList:(SaveList *)saveList
{
    
    AppDelegate* delegate = [UIApplication sharedApplication].delegate;
    [delegate.managedObjectContext deleteObject:saveList];
    //[[CoreDataMngTool sharedCoredataMngTool].saveNameList removeObject:saveList];
    
    NSError *error = nil;
    [delegate.managedObjectContext save:&error];
    if (error)
    {
        [NSException raise:@"删除错误" format:@"%@", [error localizedDescription]];
    }
    [CoreDataMngTool sharedCoredataMngTool].saveNameList = nil;
}

#pragma mark - 单例方法
//单例3.实现shared...Tool，使用dispatch_once保证alloc init只调用一次
+(instancetype)sharedCoredataMngTool
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        tool = [[CoreDataMngTool alloc]init];
        if (tool)
        {
            tool.oldMusic = nil;
            tool.curMusic = nil;
        }
    });
    return tool;
}
@end
