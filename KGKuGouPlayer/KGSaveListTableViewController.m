//
//  KGSaveListTableViewController.m
//  KGKuGouPlayer
//
//  Created by neuedu on 15/9/28.
//  Copyright (c) 2015年 neuedu. All rights reserved.
//

#import "KGSaveListTableViewController.h"

@interface KGSaveListTableViewController ()

@property (weak, nonatomic) KGSaveListView *saveListView;
@property (strong, nonatomic) NSArray *saveListArray;
@property (strong, nonatomic) Music* selMusic;
@property (strong, nonatomic) SaveList *oldSaveList;

@end

@implementation KGSaveListTableViewController

-(NSArray *)saveListArray
{
    if (_saveListArray == nil)
    {
        _saveListArray = [CoreDataMngTool sharedCoredataMngTool].saveNameList;
    }
    return _saveListArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"添加列表" style:UIBarButtonItemStylePlain target:self action:@selector(addSaveListTitle:)];
}

-(void)playNextMusic:(NSNotification*)nofity
{
    [self.tableView reloadData];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(playNextMusic:) name:@"playNextMusic" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardChange:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardChange:) name:UIKeyboardWillHideNotification object:nil];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

-(void)keyboardChange:(NSNotification *)notify
{
    if ([notify.name isEqualToString:@"UIKeyboardWillChangeFrameNotification"])
    {
        NSDictionary *userInfo = notify.userInfo;
        NSString *duration = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
        CGRect endRect = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey]CGRectValue];
        if (endRect.origin.y == [UIScreen mainScreen].bounds.size.height)
        {
            [UIView animateWithDuration:[duration floatValue] animations:^{
                _saveListView.center = CGPointMake([UIScreen mainScreen].bounds.size.width*0.5, ([UIScreen mainScreen].bounds.size.height-64.f-56.f)*0.5);
            }];
        }
        else
        {
            if (_saveListView.bottom < endRect.origin.y)
            {
                return;
            }
            else
            {
                CGPoint saveListCenter = CGPointMake(_saveListView.center.x, endRect.origin.y-54.f);
                [UIView animateWithDuration:[duration floatValue] animations:^{
                    _saveListView.center = saveListCenter;
                }];
            }
        }
    }
}

#pragma mark 添加收藏列表标题
-(void)addSaveListTitle:(id)sender
{
    KGSaveListView *saveListView = [KGSaveListView saveListView];
    saveListView.delegate = self;
    _saveListView = saveListView;
    //为了自定义View不跟随TableView联动，可以将自定义view添加到window，如果控制器是在导航控制器下的，可以添加到导航控制器上
    [saveListView showInView:self.view.window];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backgroundclick:)];
    
    [saveListView.mengBoard addGestureRecognizer:tap];
}

-(void)backgroundclick:(UITapGestureRecognizer *)sender
{
    [self.saveListView endEditing:YES];
}

-(void)KGSaveListView:(KGSaveListView *)saveListView didSaveListNameConfirm:(NSString *)saveListName
{
    [saveListView hide];
    
    if ([[CoreDataMngTool sharedCoredataMngTool]addSaveList:saveListName] == NO)
    {
        UIAlertView *alterView = [[UIAlertView alloc]initWithTitle:@"提示信息" message:@"列表名称不能重复" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alterView show];
    }
    else
    {
        [[CoreDataMngTool sharedCoredataMngTool]addSaveList:saveListName];
    }
    _saveListArray = nil;
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.saveListArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    SaveList *saveList = self.saveListArray[section];
    if (saveList.isShow)
    {
        return saveList.musics.allObjects.count;
    }
    else
    {
        return 0;
    }
}

//-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    SaveList *saveList = self.saveListArray[section];
//    return saveList.name;
//}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44.f;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    KGSaveListSectionHeaderView *headerView = [KGSaveListSectionHeaderView saveListSectionHeaderView];
    headerView.delegate = self;
    headerView.saveList = self.saveListArray[section];
    headerView.tag = section;
    return headerView;
}

-(void)saveListSectionHeaderViewDidDeleteButtonClicked:(KGSaveListSectionHeaderView *)headerView
{
    SaveList *saveList = self.saveListArray[headerView.tag];
    [CoreDataMngTool deleteSaveList:saveList];
    _saveListArray = nil;
    [self.tableView reloadData];
}

-(void)saveListSectionHeaderViewDidClicked:(KGSaveListSectionHeaderView *)headerView
{
    if (_oldSaveList != nil)
    {
        _oldSaveList.isShow = NO;
    }
    SaveList *saveList = self.saveListArray[headerView.tag];
    saveList.isShow = YES;
    _oldSaveList = saveList;
    [CoreDataMngTool sharedCoredataMngTool].curPlayList = saveList.musics.allObjects;
    [self.tableView reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    KGMusicTableViewCell *cell = [KGMusicTableViewCell musicTableViewCellWith:tableView];
    cell.delegate = self;
    SaveList *saveList = self.saveListArray[indexPath.section];
    //集合变数组
    cell.music = saveList.musics.allObjects[indexPath.row];
    cell.selectionStyle = UITableViewCellAccessoryNone;
    return cell;
}

#pragma mark - 自动删除
-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    SaveList *saveList = self.saveListArray[indexPath.section];
    Music *music = saveList.musics.allObjects[indexPath.row];
    if ([music.name isEqualToString:[CoreDataMngTool sharedCoredataMngTool].curMusic.name])
    {
        [[AudioPlayerTool sharedAudioPlayerTool]resetPlayer];
    }
    [saveList removeMusicsObject:music];
    _saveListArray = nil;
    [self.tableView reloadData];
}
-(void)musicTableViewCell:(KGMusicTableViewCell *)cell didShowHiddenMenu:(BOOL)show
{
    NSIndexPath* indexPath = [self.tableView indexPathForCell:cell];
    SaveList* saveList = self.saveListArray[indexPath.section];
    Music* music = saveList.musics.allObjects[indexPath.row];
    music.cellStatus = !show;
    
    [self.tableView reloadData];
}


-(void)musicTableViewCell:(KGMusicTableViewCell *)cell didButtonClicked:(NSString *)title
{
    SaveList* saveList = self.saveListArray[[self.tableView indexPathForCell:cell].section];
    
    Music* music = saveList.musics.allObjects[[self.tableView indexPathForCell:cell].row];
    _selMusic = music;
    
    NSString* actionTitle = [NSString stringWithFormat:@"添加%@到:", music.name];
    
    UIActionSheet* actionSheet = [[UIActionSheet alloc]initWithTitle:actionTitle delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"我喜欢", @"收藏列表", nil];
    [actionSheet showInView:self.view];
    
    music.cellStatus = YES;
    [self.tableView reloadData];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex)
    {
        case 0: //我喜欢
        {
            _selMusic.isMyLove = YES;
        }
            break;
        case 1: //收藏列表
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

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SaveList* saveList = self.saveListArray[indexPath.section];
    Music* music = saveList.musics.allObjects[indexPath.row];
    return music.cellStatus?44.f:109.f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SaveList* saveList = self.saveListArray[indexPath.section];
    Music* music = saveList.musics.allObjects[indexPath.row];
    [CoreDataMngTool sharedCoredataMngTool].curMusic = music;
    [[AudioPlayerTool sharedAudioPlayerTool]playMusic:music.name];
    
    [self.tableView reloadData];
}

@end
