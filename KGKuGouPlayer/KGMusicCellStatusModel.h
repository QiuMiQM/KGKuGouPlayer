//
//  KGMusicCellStatusModel.h
//  KGKuGouPlayer
//
//  Created by neuedu on 15/9/17.
//  Copyright (c) 2015年 neuedu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KGMusicCellStatusModel : NSObject

@property (assign, nonatomic) BOOL selected;

+(instancetype)musicCellStatusModelWithDict:(NSDictionary *)dict;

@end
