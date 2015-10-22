//
//  CurUserMngTool.h
//  KGKuGouPlayer
//
//  Created by neuedu on 15/10/21.
//  Copyright (c) 2015年 neuedu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KGAccessToken.h"
#import "KGLoginUser.h"

@interface CurUserMngTool : NSObject

@property (strong, nonatomic) KGAccessToken *token;
@property (strong, nonatomic) KGLoginUser *loginUser;
@property (assign, nonatomic) BOOL isChangeUser;

+(instancetype)sharedCurUserMngTool;

@end
