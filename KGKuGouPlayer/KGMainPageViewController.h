//
//  KGMainPageViewController.h
//  KGKuGouPlayer
//
//  Created by neuedu on 15/9/15.
//  Copyright (c) 2015年 neuedu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KGMusicCellStatusModel.h"
#import "KGMainPageMusicTableViewCell.h"
#import "KGPlayBar.h"
#import "AppDelegate.h"

@interface KGMainPageViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *icon;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *arrow;
@property (weak, nonatomic) IBOutlet UIButton *myMusic;
@property (weak, nonatomic) IBOutlet UIButton *netMusic;
@property (weak, nonatomic) IBOutlet UIButton *moreFunction;

- (IBAction)login:(UIButton *)sender;
- (IBAction)signIn:(UIButton *)sender;
- (IBAction)musicSwitch:(UIButton *)sender;
- (IBAction)myMusic:(UIButton *)sender;
- (IBAction)netMusic:(UIButton *)sender;
- (IBAction)moreFunction:(UIButton *)sender;

@end
