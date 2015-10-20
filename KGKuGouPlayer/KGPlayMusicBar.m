//
//  KGPlayMusicBar.m
//  KGKuGouPlayer
//
//  Created by neuedu on 15/9/24.
//  Copyright (c) 2015年 neuedu. All rights reserved.
//

#import "KGPlayMusicBar.h"

@implementation KGPlayMusicBar

+(instancetype)KGPlayMusicBar
{
    KGPlayMusicBar *musicBar = [[[NSBundle mainBundle]loadNibNamed:@"KGPlayMusicBar" owner:nil options:nil]lastObject];
    return musicBar;
}

- (IBAction)playButton:(UIButton *)sender
{
    
}

- (IBAction)nextButton:(UIButton *)sender
{
    
}

- (IBAction)frontButton:(UIButton *)sender
{
    
}
@end
