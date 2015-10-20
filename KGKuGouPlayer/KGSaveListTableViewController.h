//
//  KGSaveListTableViewController.h
//  KGKuGouPlayer
//
//  Created by neuedu on 15/9/28.
//  Copyright (c) 2015年 neuedu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "AudioPlayerTool.h"
#import "CoreDataMngTool.h"
#import "KGMusicTableViewCell.h"
#import "KGSaveListSectionHeaderView.h"
#import "KGSaveListView.h"
#import "SaveList.h"
#import "UIView+Extension.h"

@interface KGSaveListTableViewController : UITableViewController<KGSaveListViewDelegate,SaveListSectionHeaderViewDelegate,KGMusicTableViewCellDelegate,UIActionSheetDelegate>

@end
