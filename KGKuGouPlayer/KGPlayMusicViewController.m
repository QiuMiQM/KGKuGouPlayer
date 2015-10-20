//
//  KGPlayMusicViewController.m
//  KGKuGouPlayer
//
//  Created by neuedu on 15/9/24.
//  Copyright (c) 2015年 neuedu. All rights reserved.
//

#import "KGPlayMusicViewController.h"

@interface KGPlayMusicViewController ()

@end

@implementation KGPlayMusicViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    KGPlayMusicBar *musicBar = [KGPlayMusicBar KGPlayMusicBar];
    musicBar.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height-musicBar.height, [UIScreen mainScreen].bounds.size.width, musicBar.height);
    [self.view addSubview:musicBar];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
