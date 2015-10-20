//
//  CoreDataMngTool.h
//  iOSCoreDataDemo
//
//  Created by hegf on 15/9/10.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Music.h"
#import "SaveList.h"

@interface CoreDataMngTool : NSObject

/*------------------------------------------------------------
 |                                                           |
 |                        所有歌曲相关                         |
 |                                                           |
 ------------------------------------------------------------*/
//所有歌曲列表
@property (strong, nonatomic) NSArray *allMusicList;
//我喜欢歌曲列表
@property (strong, nonatomic) NSArray *myLoveMusicList;
//当前播放列表
@property (strong, nonatomic) NSArray *curPlayList;

@property (strong, nonatomic) Music *oldMusic;
@property (strong, nonatomic) Music *curMusic;
@property (strong, nonatomic) Music *nextMusic;

//重新加载所有歌曲
+(void)loadAllMusicList;

//查询所有Music
+(NSArray *)searchMusics;

//查询我喜欢Music
+(NSArray *)searchMyLoveMusics;

//删除一个Music
+(void)deleteMusics:(Music *)music;

//删除所有Music
+(void)deleteAllMusic;

//查询所有以keyString开头的人
+(NSArray*)searchMusicsWithKeyString:(NSString* )keyString;



/*------------------------------------------------------------
 |                                                           |
 |                        播放列表相关                         |
 |                                                           |
 ------------------------------------------------------------*/
//收藏列表（保存的是收藏文件夹的名字）
@property (strong, nonatomic) NSArray *saveNameList;

+(NSArray *)searchSaveNames;
-(BOOL)addSaveList:(NSString *)saveListName;
//删除一个收藏列表
+(void)deleteSaveList:(SaveList *)saveList;

//单例1.shared...Tool
+(instancetype)sharedCoredataMngTool;
@end
