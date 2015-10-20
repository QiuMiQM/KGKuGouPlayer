//
//  KGMyLoveTableViewController.m
//  KGKuGouPlayer
//
//  Created by neuedu on 15/9/24.
//  Copyright (c) 2015年 neuedu. All rights reserved.
//

#import "KGMyLoveTableViewController.h"

@interface KGMyLoveTableViewController ()

@property (strong, nonatomic) NSArray *myLoveList;

@end

@implementation KGMyLoveTableViewController

#pragma mark - 懒加载
-(NSArray *)myLoveList
{
    if (_myLoveList == nil)
    {
        _myLoveList = [CoreDataMngTool searchMyLoveMusics];
        [CoreDataMngTool sharedCoredataMngTool].curPlayList = _myLoveList;
    }
    return _myLoveList;
}

#pragma mark -
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"我喜欢";
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 54.f, 0);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.myLoveList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    KGMusicTableViewCell *cell = [KGMusicTableViewCell musicTableViewCellWith:tableView];
    cell.music = self.myLoveList[indexPath.row];
    //cell.delegate = self;
    
    cell.selectionStyle = UITableViewCellAccessoryNone;
    return cell;
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

#pragma mark 实现通知的方法
-(void)playNextMusic:(NSNotification *)nofity
{
    [self.tableView reloadData];
}

#pragma mark - 重新加载，搜索全部歌曲
-(void)searchAll:(UIBarButtonItem *)item
{
    [CoreDataMngTool loadAllMusicList];
    _myLoveList = nil;
    [self.tableView reloadData];
    [[AudioPlayerTool sharedAudioPlayerTool]resetPlayer];
}

#pragma mark cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Music *music = self.myLoveList[indexPath.row];
    return music.cellStatus ? 44.f : 109.f;
}

#pragma mark 单击某一行的cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Music *music = self.myLoveList[indexPath.row];
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
    Music *music = self.myLoveList[indexPath.row];
    music.cellStatus = !show;
    
    [self.tableView reloadData];
}

#pragma mark 监听下载等按钮的代理方法
-(void)musicTableViewCell:(KGMusicTableViewCell *)cell didButtonClick:(NSString *)title
{
    NSLog(@"%@",title);
    Music *music = self.myLoveList[[self.tableView indexPathForCell:cell].row];
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

#pragma mark - 自动删除
-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    Music *music = self.myLoveList[indexPath.row];
    if ([music.name isEqualToString:[CoreDataMngTool sharedCoredataMngTool].curMusic.name])
    {
        [[AudioPlayerTool sharedAudioPlayerTool]resetPlayer];
    }
    music.isMyLove = NO;
    _myLoveList = nil;
    [self.tableView reloadData];
}
@end
