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
@property (strong, nonatomic) Music *selMusic;

@end

@implementation KGLocalMusicTableViewController

#pragma mark - 懒加载
- (NSArray *)musicList
{
    if (_musicList == nil)
    {
        _musicList = [CoreDataMngTool sharedCoredataMngTool].allMusicList;
        [CoreDataMngTool sharedCoredataMngTool].curPlayList = _musicList;
    }
    //NSLog(@"%li",[CoreDataMngTool serachMusics].count);
    return _musicList;
}

#pragma mark -
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"本地音乐";
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 54.f, 0);

    //_musicRow = -1;
    //self.tableView.rowHeight = 44.f+65.f;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"重新加载" style:UIBarButtonItemStylePlain target:self action:@selector(searchAll:)];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //注册接受通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(playNextMusic:) name:@"playNextMusic" object:nil];
}

-(void)viewWillDisappear:(BOOL)animated
{
    //销毁通知
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark 实现通知的方法
-(void)playNextMusic:(NSNotification *)nofity
{
    [self.tableView reloadData];
}

#pragma mark - 重新加载，搜索全部歌曲
-(void)searchAll:(UIBarButtonItem *)item
{
    [CoreDataMngTool loadAllMusicList];
    _musicList = nil;
    [self.tableView reloadData];
    [[AudioPlayerTool sharedAudioPlayerTool]resetPlayer];
}

#pragma mark Table view data source
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
    
    cell.selectionStyle = UITableViewCellAccessoryNone;
    return cell;
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
    //顺序...
    [CoreDataMngTool sharedCoredataMngTool].curMusic = music;
    [[AudioPlayerTool sharedAudioPlayerTool]playMusic:music.name];
    //_musicRow = indexPath.row;
    [self.tableView reloadData];
}

#pragma mark - 播放/暂停功能的代理方法
- (void)musicTableViewCell:(KGMusicTableViewCell *)cell didShowOrHiddenMenu:(BOOL)show
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    Music *music = self.musicList[indexPath.row];
    music.cellStatus = !show;
    
    [self.tableView reloadData];
}

#pragma mark 监听下载等按钮的代理方法
-(void)musicTableViewCell:(KGMusicTableViewCell *)cell didButtonClick:(NSString *)title
{
    NSLog(@"%@",title);
    Music *music = self.musicList[[self.tableView indexPathForCell:cell].row];
    _selMusic = music;
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:[NSString stringWithFormat:@"添加 %@ 到:",music.name] delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"我喜欢", @"我的收藏", nil];
    [actionSheet showInView:self.view];
    music.cellStatus = YES;
    [self.tableView reloadData];
}

#pragma mark UIActionSheet的代理方法
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"%li",buttonIndex);
    switch (buttonIndex)
    {
        case 0: //我喜欢
        {
            _selMusic.isMyLove = YES;
            
        }
            break;
        case 1: //收藏
        {
            KGLocalMusicSaveListView *localSaveListView = [KGLocalMusicSaveListView saveListView];
            localSaveListView.delegate = self;
            [localSaveListView showInView:self.view.window];
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

#pragma mark 代理
-(void)KGLocalMusicSaveListView:(KGLocalMusicSaveListView *)saveListView didSaveListNameConfirm:(SaveList *)saveListName
{
    [saveListView hide];
    if (saveListView != nil)
    {
        //1.取得收藏列表模型
        //2.取得歌曲模型
        //3.把歌曲模型加到收藏列表模型
        [saveListName addMusicsObject:_selMusic];
    }
}

#pragma mark - 自动删除
-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    Music *music = self.musicList[indexPath.row];
    if ([music.name isEqualToString:[CoreDataMngTool sharedCoredataMngTool].curMusic.name])
    {
        [[AudioPlayerTool sharedAudioPlayerTool]resetPlayer];
    }
    [CoreDataMngTool deleteMusics:music];
    _musicList = nil;
    [self.tableView reloadData];
}
@end
