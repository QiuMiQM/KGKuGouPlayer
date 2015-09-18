//
//  KGPlayBar.h
//  KGKuGouPlayer
//
//  Created by neuedu on 15/9/18.
//  Copyright (c) 2015年 neuedu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+Extension.h"
#import "Music.h"

@class KGPlayBar;
@protocol KGPlayBarDelegate <NSObject>

- (void)playBar:(KGPlayBar *)playBar didPlayPauseMusic:(BOOL)playMethod;
- (void)playBarDidPlayPauseMusic:(KGPlayBar *)playBar ;

@end

@interface KGPlayBar : UIView

@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UIProgressView *progress;
@property (weak, nonatomic) IBOutlet UILabel *musicName;
@property (weak, nonatomic) IBOutlet UILabel *singer;
@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;

@property (strong, nonatomic) Music *music;
@property (weak, nonatomic) id<KGPlayBarDelegate> delegate;

+ (instancetype)playBar;

- (IBAction)playOrPauseMusic:(UIButton *)sender;
- (IBAction)playNextMusic:(UIButton *)sender;

@end
