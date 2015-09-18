//
//  KGMainPageMusicTableViewCell.h
//  KGKuGouPlayer
//
//  Created by neuedu on 15/9/17.
//  Copyright (c) 2015年 neuedu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KGMusicCellStatusModel.h"

@interface KGMainPageMusicTableViewCell : UITableViewCell

@property (strong, nonatomic) KGMusicCellStatusModel *status;

+ (instancetype)mainPageMusicTableViewCellWithTableView:(UITableView *)tableView;

@end
