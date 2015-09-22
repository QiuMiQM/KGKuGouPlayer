//
//  KGLocalMusicTableViewController.m
//  KGKuGouPlayer
//
//  Created by neuedu on 15/9/18.
//  Copyright (c) 2015年 neuedu. All rights reserved.
//

#import "KGLocalMusicTableViewController.h"

@interface KGLocalMusicTableViewController ()

@property (strong, nonatomic) NSArray *musicList;
@property (strong, nonatomic) AVAudioPlayer *audioPlayer;
@property (assign, nonatomic) NSInteger musicRow;
@property (strong, nonatomic) NSTimer *oldTimer;
@property (assign, nonatomic) CGFloat nowPlayTime;
@property (strong, nonatomic) KGPlayBar *playBar;

@end

@implementation KGLocalMusicTableViewController

#pragma mark 懒加载
- (NSArray *)musicList
{
    if (_musicList == nil)
    {
        _musicList = [CoreDataMngTool serachMusics];
    }
    NSLog(@"%li",[CoreDataMngTool serachMusics].count);
    return _musicList;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"本地音乐";
    _musicRow = -1;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 54.f, 0);
    _nowPlayTime = 0;
    //self.tableView.rowHeight = 44.f+65.f;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.musicList.count;
}

#pragma mark 自定义cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"localMusicCell" forIndexPath:indexPath];
    KGMusicTableViewCell *cell = [KGMusicTableViewCell musicTableViewCellWith:tableView];
    cell.music = self.musicList[indexPath.row];
    cell.delegate = self;
//    Music *music = self.musicList[indexPath.row];
//    cell.textLabel.text = music.name;
    return cell;
}

#pragma mark 播放/暂停功能的代理方法
- (void)musicTableViewCell:(KGMusicTableViewCell *)cell didShowOrHiddenMenu:(BOOL)show
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    Music *music = self.musicList[indexPath.row];
    music.cellStatus = !show;
    
    [self.tableView reloadData];
}

#pragma mark cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Music *music = self.musicList[indexPath.row];
    return music.cellStatus ? 44.f : 109.f;
}

#pragma mark 单击某一行的cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Music *music = self.musicList[indexPath.row];
    
    //遍历window的所有子控件，如果子控件的类型是KGPlayBar，就设置它的模型
    for (UIView *subView in self.view.window.subviews)
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
            playBar.music = music;
            _playBar = playBar;
        }
    }
    
    NSString *musicName = [NSString stringWithFormat:@"%@.mp3",music.name];
    NSURL *musicURL = [[NSBundle mainBundle]URLForResource:musicName withExtension:nil];
    
    AVAudioPlayer *audioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:musicURL error:nil];
    _audioPlayer = audioPlayer;
    audioPlayer.delegate = self;
    //缓冲
    [audioPlayer prepareToPlay];
    //播放
    [audioPlayer play];
    //从倒数5秒开始播放---------可惜失败了
    //[audioPlayer playAtTime:[music.time floatValue]-15];
    _musicRow = indexPath.row;
}

#pragma mark 进度条的更新
- (void)updateProgress:(NSTimer *)timer
{
    if ([_audioPlayer isPlaying])
    {
        _nowPlayTime = _nowPlayTime+1.0f;
        Music *music = self.musicList[_musicRow];
        CGFloat totalTime = [music.time floatValue];
        CGFloat nowTimeProgressValue = _nowPlayTime/totalTime;
        if (nowTimeProgressValue >= 1.0f)
        {
            nowTimeProgressValue = 1.0f;
        }
        for (UIView *view in self.view.window.subviews)
        {
            if ([view isKindOfClass:[KGPlayBar class]])
            {
                KGPlayBar *playBar = (KGPlayBar *)view;
                playBar.progress.progress = nowTimeProgressValue;
            }
        }
    }
}

#pragma mark 自动切换下一曲的代理方法
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    if (_musicRow == self.musicList.count - 1)
    {
        _musicRow = -1;
    }
    
    Music *music = self.musicList[_musicRow+1];
    
    for (UIView *subView in self.view.window.subviews)
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
            playBar.music = music;
            _playBar = playBar;
        }
    }
    
    NSString *musicName = [NSString stringWithFormat:@"%@.mp3",music.name];
    NSURL *musicURL = [[NSBundle mainBundle]URLForResource:musicName withExtension:nil];
    
    AVAudioPlayer *audioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:musicURL error:nil];
    _audioPlayer = audioPlayer;
    audioPlayer.delegate = self;
    //缓冲
    [audioPlayer prepareToPlay];
    //播放
    [audioPlayer play];
    //从倒数5秒开始播放---------可惜失败了
    //[audioPlayer playAtTime:[music.time floatValue]-15];
    
    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:_musicRow inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
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

#pragma mark 监听xib被点击的代理方法
- (void)playBarDidPlayPauseMusic:(KGPlayBar *)playBar
{
    //直接调用一首歌曲播放完毕切换下一首的代理方法实现
    [self audioPlayerDidFinishPlaying:_audioPlayer successfully:YES];
}

#pragma mark 监听下载等按钮的代理方法
-(void)musicTableViewCell:(KGMusicTableViewCell *)cell didButtonClick:(NSString *)title
{
    NSLog(@"%@",title);
    Music *music = self.musicList[[self.tableView indexPathForCell:cell].row];
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:[NSString stringWithFormat:@"添加%@到:",music.name] delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"我喜欢", @"我的收藏", nil];
    [actionSheet showInView:self.view];
}

#pragma mark UIActionSheet的代理方法
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"%li",buttonIndex);
    switch (buttonIndex)
    {
        case 0: //我喜欢
        {
        }
            break;
        case 1: //收藏
        {
        }
            break;
        case 2: //取消
        {
        }
            break;
        default:
            break;
    }
}
@end
