//
//  KGMusicMenu.h
//  KGKuGouPlayer
//
//  Created by neuedu on 15/9/21.
//  Copyright (c) 2015年 neuedu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+Extension.h"
#import "NEUButton.h"

@class KGMusicMenu;
@protocol KGMusicMenuDelegate <NSObject>

@optional
-(void)musicMenu:(KGMusicMenu *)menu didButtonClick:(NSString *)title;

@end

@interface KGMusicMenu : UIView

@property (weak, nonatomic) id<KGMusicMenuDelegate> delegate;

+(instancetype)musicMenuWithInfos:(NSArray *)infoArray;

@end
