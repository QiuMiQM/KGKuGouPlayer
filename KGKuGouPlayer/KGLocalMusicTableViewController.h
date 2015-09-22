//
//  KGLocalMusicTableViewController.h
//  KGKuGouPlayer
//
//  Created by neuedu on 15/9/18.
//  Copyright (c) 2015年 neuedu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "KGPlayBar.h"
#import "KGMusicTableViewCell.h"
#import "CoreDataMngTool.h"

@interface KGLocalMusicTableViewController : UITableViewController<AVAudioPlayerDelegate,KGPlayBarDelegate,KGMusicTableViewCellDelegate,UIActionSheetDelegate>

@end
