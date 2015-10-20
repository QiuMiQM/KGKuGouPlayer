//
//  KGMainPageViewController.m
//  KGKuGouPlayer
//
//  Created by neuedu on 15/9/15.
//  Copyright (c) 2015年 neuedu. All rights reserved.
//

#import "KGMainPageViewController.h"

//自定义枚举的类型
typedef enum
{
    eMyMusic = 0,
    eNetMusic,
    eMoreFunction
}eMusicSelect;

@interface KGMainPageViewController ()

@property (strong, nonatomic) KGMainPageMusicTableViewCell *curselectCell;
@property (assign, nonatomic) NSInteger curselectRow;
@property (strong, nonatomic) NSMutableArray *cellStatus;
@property (strong, nonatomic) NSArray *cellContents;
//用枚举来区分三个不同的选项
@property (assign, nonatomic) eMusicSelect musicSelect;

@end

@implementation KGMainPageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    KGPlayBar *playBar = [KGPlayBar playBar];
    /*
     
     
     ----------------- 代理连线 -----------------
     
     
     */
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    [delegate.window addSubview:playBar];
    //view刚加载完毕，window为空，无法添加
    //[self.view.window addSubview:playBar];
    //默认选中的是“我的音乐”
    //_myMusic.selected = YES;
    //避免重复代码
    _curselectRow = -1;
    
    [self myMusic:_myMusic];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (NSMutableArray *)cellStatus
{
    if (_cellStatus == nil)
    {
        _cellStatus = [NSMutableArray array];
        NSString *fileName = @"MyMusicSelList.plist";
        switch (_musicSelect)
        {
            case eMyMusic:
            {
                fileName = @"MyMusicSelList.plist";
            }
                break;
            case eNetMusic:
            {
                fileName = @"webMusicList.plist";
            }
                break;
            case eMoreFunction:
            {
                fileName = @"MoreList.plist";
            }
                break;
            default:
                break;
        }
        _cellContents = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:fileName ofType:nil]];
        for (int i = 0; i < _cellContents.count; i++)
        {
            NSDictionary *dict = @{
                                   @"selected":@0
                                   };
            KGMusicCellStatusModel *status = [KGMusicCellStatusModel musicCellStatusModelWithDict:dict];
            [_cellStatus addObject:status];
        }
    }
    return _cellStatus;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)playBarDidSeguePlayMusic
{
    [self performSegueWithIdentifier:@"localMusicToPlayMusic" sender:nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.cellStatus.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    static NSString *cellID = @"mainListcell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
//    if (cell == nil)
//    {
//        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
//    }
//    
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    cell.textLabel.text = @"test";
//    cell.textLabel.textColor = [UIColor whiteColor];
//    cell.backgroundColor = [UIColor clearColor];
    KGMainPageMusicTableViewCell *cell = [KGMainPageMusicTableViewCell mainPageMusicTableViewCellWithTableView:tableView];
    cell.status = self.cellStatus[indexPath.row];
    if (_cellContents != nil)
    {
        cell.textLabel.text = self.cellContents[indexPath.row];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (_curselectCell != nil)
//    {
//        _curselectCell.textLabel.textColor = [UIColor whiteColor];
//    }
//    UITableViewCell *selectCell = [tableView cellForRowAtIndexPath:indexPath];
//    selectCell.textLabel.textColor = [UIColor colorWithRed:232.f/255.f green:222.f/255.f blue:0/255.f alpha:1];
//    
//    _curselectCell = selectCell;
    if (_curselectRow >= 0)
    {
        KGMusicCellStatusModel *status = self.cellStatus[_curselectRow];
        status.selected = NO;
    }
    KGMusicCellStatusModel *status = self.cellStatus[indexPath.row];
    status.selected = YES;
    
    _curselectRow = indexPath.row;
    
    [self.tableView reloadData];
    switch (_musicSelect)
    {
        case eMyMusic:
        {
            switch (_curselectRow) {
                case 0:
                {
                    [self performSegueWithIdentifier:@"toLocalMusic" sender:nil];
                }
                    break;
                case 1:
                {
                    [self performSegueWithIdentifier:@"toMyLove" sender:nil];
                }
                    break;
                case 2:
                {
                    [self performSegueWithIdentifier:@"toSaveList" sender:nil];
                }
                    break;
                default:
                    break;
            }
            break;
        }
        case eNetMusic:
        {
        }
        case eMoreFunction:
        {
        }
        default:
            break;
    }
}

//-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    KGMusicCellStatusModel *status = self.cellStatus[indexPath.row];
//    status.selected = NO;
//    [self.tableView reloadData];
//}

#pragma mark 登录
- (IBAction)login:(UIButton *)sender
{
    [self performSegueWithIdentifier:@"toLogin" sender:nil];
}

#pragma mark 注册
- (IBAction)signIn:(UIButton *)sender
{
    
}

#pragma mark 切换开关
- (IBAction)musicSwitch:(UIButton *)sender
{
    sender.selected = !sender.selected;
}

#pragma mark 我的音乐
- (IBAction)myMusic:(UIButton *)sender
{
    sender.selected = YES;
    _netMusic.selected = NO;
    _moreFunction.selected = NO;
    
    _musicSelect = eMyMusic;
    _cellStatus = nil;
    _curselectRow = -1;
    _arrow.center = CGPointMake(_arrow.center.x, sender.center.y);
    [self.tableView reloadData];
}

#pragma mark 网络音乐
- (IBAction)netMusic:(UIButton *)sender
{
    sender.selected = YES;
    _myMusic.selected = NO;
    _moreFunction.selected = NO;
    
    _musicSelect = eNetMusic;
    _cellStatus = nil;
    _curselectRow = -1;
    _arrow.center = CGPointMake(_arrow.center.x, sender.center.y);
    [self.tableView reloadData];
}

#pragma mark 更多功能
- (IBAction)moreFunction:(UIButton *)sender
{
    sender.selected = YES;
    _myMusic.selected = NO;
    _netMusic.selected = NO;
    
    _musicSelect = eMoreFunction;
    _cellStatus = nil;
    _curselectRow = -1;
    _arrow.center = CGPointMake(_arrow.center.x, sender.center.y);
    [self.tableView reloadData];
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}
@end
