//
//  KGPlayMusicBar.h
//  KGKuGouPlayer
//
//  Created by neuedu on 15/9/24.
//  Copyright (c) 2015年 neuedu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KGPlayMusicBar : UIView

@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet UIButton *frontButton;

+(instancetype)KGPlayMusicBar;

- (IBAction)playButton:(UIButton *)sender;
- (IBAction)nextButton:(UIButton *)sender;
- (IBAction)frontButton:(UIButton *)sender;

@end
