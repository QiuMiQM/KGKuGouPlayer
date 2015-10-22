//
//  CurUserMngTool.m
//  KGKuGouPlayer
//
//  Created by neuedu on 15/10/21.
//  Copyright (c) 2015年 neuedu. All rights reserved.
//

#import "CurUserMngTool.h"

static CurUserMngTool *tool;

@implementation CurUserMngTool

+(instancetype)sharedCurUserMngTool
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        tool = [[CurUserMngTool alloc]init];
        tool.isChangeUser = YES;
    });
    return tool;
}

@end
