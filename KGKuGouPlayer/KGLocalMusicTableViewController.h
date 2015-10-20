//
//  KGLocalMusicTableViewController.h
//  KGKuGouPlayer
//
//  Created by neuedu on 15/9/18.
//  Copyright (c) 2015年 neuedu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "KGMusicTableViewCell.h"
#import "CoreDataMngTool.h"
#import "AudioPlayerTool.h"
#import "KGLocalMusicSaveListView.h"

@interface KGLocalMusicTableViewController : UITableViewController<KGMusicTableViewCellDelegate,UIActionSheetDelegate,KGLocalMusicSaveListViewDelegate>

@end
