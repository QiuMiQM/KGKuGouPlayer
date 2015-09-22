//
//  KGMusicTableViewCell.h
//  KGKuGouPlayer
//
//  Created by neuedu on 15/9/21.
//  Copyright (c) 2015年 neuedu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Music.h"
#import "UIView+Extension.h"
#import "KGMusicMenu.h"

@class KGMusicTableViewCell;
@protocol KGMusicTableViewCellDelegate <NSObject>

@optional
- (void)musicTableViewCell:(KGMusicTableViewCell *)cell didShowOrHiddenMenu:(BOOL)show;
- (void)musicTableViewCell:(KGMusicTableViewCell *)cell didButtonClick:(NSString *)title;

@end

@interface KGMusicTableViewCell : UITableViewCell<KGMusicMenuDelegate>

@property (weak, nonatomic) UIButton *addButton;
@property (weak, nonatomic) UILabel *musicName;
@property (weak, nonatomic) UIButton *mvButton;
@property (weak, nonatomic) UIButton *moreButton;
@property (weak, nonatomic) UIView *background;

@property (strong, nonatomic) Music *music;
@property (weak, nonatomic) id<KGMusicTableViewCellDelegate> delegate;

+ (instancetype)musicTableViewCellWith:(UITableView *)tableView;

@end
