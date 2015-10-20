//
//  KGSaveListSectionHeaderView.h
//  KGKuGouPlayer
//
//  Created by neuedu on 15/9/29.
//  Copyright (c) 2015年 neuedu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SaveList.h"
#import "UIView+Extension.h"

@class KGSaveListSectionHeaderView;
@protocol SaveListSectionHeaderViewDelegate <NSObject>

@optional
-(void)saveListSectionHeaderViewDidDeleteButtonClicked:(KGSaveListSectionHeaderView *)headerView;
-(void)saveListSectionHeaderViewDidClicked:(KGSaveListSectionHeaderView *)headerView;

@end

@interface KGSaveListSectionHeaderView : UIView

@property (weak, nonatomic) UILabel *title;
@property (weak, nonatomic) UIButton *deleteButton;

@property (strong, nonatomic) SaveList *saveList;
@property (weak, nonatomic) id<SaveListSectionHeaderViewDelegate> delegate;

+(instancetype)saveListSectionHeaderView;

@end
