//
//  KGLocalMusicSaveListView.h
//  KGKuGouPlayer
//
//  Created by neuedu on 15/9/28.
//  Copyright (c) 2015年 neuedu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+Extension.h"
#import "CoreDataMngTool.h"
#import "SaveList.h"

@class KGLocalMusicSaveListView;
@protocol KGLocalMusicSaveListViewDelegate <NSObject>

@optional
-(void)KGLocalMusicSaveListView:(KGLocalMusicSaveListView *)saveListView didSaveListNameConfirm:(SaveList *)saveList;

@end

@interface KGLocalMusicSaveListView : UIView<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) UITableView *saveListName;
@property (weak, nonatomic) UIButton *okButton;
@property (weak, nonatomic) UIButton *cancelButton;
@property (weak, nonatomic) UIView *mengBoard;

@property (weak, nonatomic) id<KGLocalMusicSaveListViewDelegate> delegate;

+(instancetype)saveListView;

-(void)showInView:(UIView *)view;
-(void)hide;

@end
