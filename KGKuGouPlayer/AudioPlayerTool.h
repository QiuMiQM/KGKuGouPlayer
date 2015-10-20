//
//  AudioPlayerTool.h
//  KGKuGouPlayer
//
//  Created by neuedu on 15/9/23.
//  Copyright (c) 2015年 neuedu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "KGPlayBar.h"
#import "CoreDataMngTool.h"

@class AudioPlayerTool;
@protocol AudioPlayerToolDelegate <NSObject>

@optional
- (void)playBarDidSeguePlayMusic;

@end

@interface AudioPlayerTool : NSObject<AVAudioPlayerDelegate,KGPlayBarDelegate>

@property (strong, nonatomic) AVAudioPlayer *audioPlayer;
@property (strong, nonatomic) NSTimer *oldTimer;
@property (assign, nonatomic) CGFloat nowPlayTime;
@property (strong, nonatomic) KGPlayBar *playBar;

@property (weak, nonatomic) id<AudioPlayerToolDelegate> delegate;

+(instancetype)sharedAudioPlayerTool;
-(void)playMusic:(NSString *)musicName;
-(void)pauseMusic;
-(void)resetPlayer;

@end
