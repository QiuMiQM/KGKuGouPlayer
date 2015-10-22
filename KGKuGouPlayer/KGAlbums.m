//
//  KGAlbums.m
//  KGKuGouPlayer
//
//  Created by neuedu on 15/10/21.
//  Copyright (c) 2015年 neuedu. All rights reserved.
//

#import "KGAlbums.h"

@implementation KGAlbums

+(instancetype)albumWithDict:(NSDictionary *)dict
{
    return [[KGAlbums alloc]initWithDict:dict];
}

-(instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self)
    {
        //按照JSON的格式，要找到singer，必须先找到attrs对应的字典
        NSDictionary *attrsDict = [dict objectForKey:@"attrs"];
        self.singers = [attrsDict objectForKey:@"singer"];
        self.titles = [attrsDict objectForKey:@"title"];
        self.image = [dict objectForKey:@"image"];
        self.total = [dict objectForKey:@"total"];
        
        NSArray *tracks = [attrsDict objectForKey:@"tracks"];
        _tracks = [NSMutableArray array];
        for (int i = 0; i<tracks.count; i++)
        {
            NSString *allString = tracks[i];
            NSArray *tempArray = [allString componentsSeparatedByString:@"\n"];
            [_tracks addObjectsFromArray:tempArray];
        }
        
    }
    return self;
}

@end
