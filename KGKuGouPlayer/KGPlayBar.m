//
//  KGPlayBar.m
//  KGKuGouPlayer
//
//  Created by neuedu on 15/9/18.
//  Copyright (c) 2015年 neuedu. All rights reserved.
//

#import "KGPlayBar.h"

@implementation KGPlayBar

+ (instancetype)playBar
{
    KGPlayBar *playBar = [[[NSBundle mainBundle] loadNibNamed:@"KGPlayBar" owner:nil options:nil]lastObject];
    playBar.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 54.f, [UIScreen mainScreen].bounds.size.width, 54.f);
    playBar.progress.progress = 0.0;
    return playBar;
}

//根据屏幕的大小不同对子控件进行适配
- (void)layoutSubviews
{
    //icon
    _icon.frame = CGRectMake(10.f, 5.f, 44.f, 44.f);
    //progress
    _progress.frame = CGRectMake(_icon.right+10.f, 8.f, [UIScreen mainScreen].bounds.size.width-_icon.right-2*10.f, 2.f);
    //nextMusic
    _nextButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-18.f-22.f, (54.f-22.f)/2, 22.f, 22.f);
    //playOrPause
    _playButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-_nextButton.left-22.f-35.f, _nextButton.top, _nextButton.width, _nextButton.height);
    //musicName
    _musicName.frame = CGRectMake(_progress.left, _progress.bottom + 2.f, [UIScreen mainScreen].bounds.size.width-_progress.left-([UIScreen mainScreen].bounds.size.width-_playButton.left), 20.f);
    //singer
    _singer.frame = CGRectMake(_musicName.left, _musicName.bottom, _musicName.width, _musicName.height);
}

-(void)setMusic:(Music *)music
{
    _musicName.text = music.name;
    _singer.text = music.singer;
}

#pragma mark 播放/暂停歌曲
- (IBAction)playOrPauseMusic:(UIButton *)sender
{
    sender.selected = !sender.selected;
    if ([_delegate respondsToSelector:@selector(playBar:didPlayPauseMusic:)])
    {
        [_delegate playBar:self didPlayPauseMusic:sender.selected];
    }
}

#pragma mark 播放下一曲
- (IBAction)playNextMusic:(UIButton *)sender
{
    if ([_delegate respondsToSelector:@selector(playBarDidPlayPauseMusic:)])
    {
        [_delegate playBarDidPlayPauseMusic:self];
    }
}

#pragma mark 跳转到播放界面
- (IBAction)iconButton:(UIButton *)sender
{
    if ([_delegate respondsToSelector:@selector(playBarDidPlayMusic)])
    {
        [_delegate playBarDidPlayMusic];
    }
}
@end
