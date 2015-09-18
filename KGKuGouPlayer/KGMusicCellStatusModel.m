
//
//  KGMusicCellStatusModel.m
//  KGKuGouPlayer
//
//  Created by neuedu on 15/9/17.
//  Copyright (c) 2015年 neuedu. All rights reserved.
//

#import "KGMusicCellStatusModel.h"

@implementation KGMusicCellStatusModel

+(instancetype)musicCellStatusModelWithDict:(NSDictionary *)dict
{
    KGMusicCellStatusModel *status = [[KGMusicCellStatusModel alloc]init];
    if (status)
    {
        [status setValuesForKeysWithDictionary:dict];
    }
    return status;
}

@end
