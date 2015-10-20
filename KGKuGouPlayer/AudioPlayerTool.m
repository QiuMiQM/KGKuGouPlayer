//
//  AudioPlayerTool.m
//  KGKuGouPlayer
//
//  Created by neuedu on 15/9/23.
//  Copyright (c) 2015年 neuedu. All rights reserved.
//

#import "AudioPlayerTool.h"

static AudioPlayerTool *tool;

@implementation AudioPlayerTool

+(instancetype)sharedAudioPlayerTool
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        tool = [[AudioPlayerTool alloc]init];
    });
    return tool;
}

-(void)playMusic:(NSString *)musicName
{
    //遍历window的所有子控件，如果子控件的类型是KGPlayBar，就设置它的模型
    for (UIView *subView in [UIApplication sharedApplication].keyWindow.subviews)
    {
        if ([subView isKindOfClass:[KGPlayBar class]])
        {
            KGPlayBar *playBar = (KGPlayBar *)subView;
            playBar.playButton.selected = YES;
            
            //进度条
            playBar.progress.progress = 0.0;
            _nowPlayTime = 0.0;
            if (_oldTimer != nil)
            {
                [_oldTimer invalidate];
                _oldTimer = nil;
            }
            NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(updateProgress:) userInfo:nil repeats:YES];
            [[NSRunLoop mainRunLoop]addTimer:timer forMode:NSRunLoopCommonModes];
            _oldTimer = timer;
            
            playBar.delegate = self;
            playBar.music = [CoreDataMngTool sharedCoredataMngTool].curMusic;
            _playBar = playBar;
        }
    }
    
    NSString *fullMusicName = [NSString stringWithFormat:@"%@.mp3",musicName];
    NSURL *musicURL = [[NSBundle mainBundle]URLForResource:fullMusicName withExtension:nil];
    
    AVAudioPlayer *audioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:musicURL error:nil];
    _audioPlayer = audioPlayer;
    audioPlayer.delegate = self;
    //缓冲
    [audioPlayer prepareToPlay];
    //播放
    [audioPlayer play];
    //从倒数5秒开始播放---------可惜失败了
    //[audioPlayer playAtTime:[music.time floatValue]-15];
}

-(void)playMusic
{
    
}

-(void)initPlayer
{
    
}

#pragma mark 进度条的更新
- (void)updateProgress:(NSTimer *)timer
{
    if ([[AudioPlayerTool sharedAudioPlayerTool].audioPlayer isPlaying])
    {
        _nowPlayTime = _nowPlayTime+1.0f;
        Music* music = [CoreDataMngTool sharedCoredataMngTool].curMusic;
        CGFloat totalTime = [music.time floatValue];
        CGFloat nowTimeProgressValue = _nowPlayTime/totalTime;
        if (nowTimeProgressValue >= 1.0f)
        {
            nowTimeProgressValue = 1.0f;
        }
        for (UIView *view in [UIApplication sharedApplication].keyWindow.subviews)
        {
            if ([view isKindOfClass:[KGPlayBar class]])
            {
                KGPlayBar *playBar = (KGPlayBar *)view;
                playBar.progress.progress = nowTimeProgressValue;
            }
        }
    }
}

#pragma mark 播放/暂停的代理方法
- (void)playBar:(KGPlayBar *)playBar didPlayPauseMusic:(BOOL)playMethod
{
    if (playMethod)
    {
        [_audioPlayer play];
    }
    else
    {
        [_audioPlayer pause];
    }
}

#pragma mark 监听xib“下一曲”被点击的代理方法
- (void)playBarDidPlayPauseMusic:(KGPlayBar *)playBar
{
    [CoreDataMngTool sharedCoredataMngTool].curMusic = [CoreDataMngTool sharedCoredataMngTool].nextMusic;
    [[AudioPlayerTool sharedAudioPlayerTool]playMusic:[CoreDataMngTool sharedCoredataMngTool].curMusic.name];
    //发一个播放下一曲的通知
    [[NSNotificationCenter defaultCenter]postNotificationName:@"playNextMusic" object:nil];
}

-(void)pauseMusic
{
    if (_audioPlayer != nil)
    {
        [_audioPlayer pause];
    }
}

-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    [self playBarDidPlayPauseMusic:nil];
}

-(void)playBarDidPlayMusic
{
    if ([_delegate respondsToSelector:@selector(playBarDidSeguePlayMusic)])
    {
        [_delegate playBarDidSeguePlayMusic];
    }
}

#pragma mark 恢复成初始状态
-(void)resetPlayer
{
    [[AudioPlayerTool sharedAudioPlayerTool].audioPlayer stop];
    [AudioPlayerTool sharedAudioPlayerTool].audioPlayer = nil;
    
    for (UIView *subView in [UIApplication sharedApplication].keyWindow.subviews)
    {
        if ([subView isKindOfClass:[KGPlayBar class]])
        {
            KGPlayBar *playBar = (KGPlayBar *)subView;
            playBar.musicName.text = @"酷狗音乐";
            playBar.singer.text = @"传播好音乐";
            playBar.progress.progress = 0.0;
            playBar.playButton.selected = NO;
        }
    }
    [CoreDataMngTool sharedCoredataMngTool].curMusic = nil;
}
@end
