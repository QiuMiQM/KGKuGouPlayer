//
//  KGLocalMusicSaveListView.m
//  KGKuGouPlayer
//
//  Created by neuedu on 15/9/28.
//  Copyright (c) 2015年 neuedu. All rights reserved.
//

#import "KGLocalMusicSaveListView.h"

#define KMargin 20.f
#define MidMargin 8.f

@interface KGLocalMusicSaveListView()

@property (strong, nonatomic) NSArray *saveNameList;
@property (strong, nonatomic) SaveList *saveList;

@end

@implementation KGLocalMusicSaveListView

-(NSArray *)saveNameList
{
    if (_saveNameList == nil)
    {
        _saveNameList = [CoreDataMngTool sharedCoredataMngTool].saveNameList;
    }
    return _saveNameList;
}

+(instancetype)saveListView
{
    KGLocalMusicSaveListView *saveListView = [[KGLocalMusicSaveListView alloc]init];
    saveListView.bounds = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width*0.6, 198.f);
    saveListView.center = CGPointMake([UIScreen mainScreen].bounds.size.width*0.5, ([UIScreen mainScreen].bounds.size.height-64.f-56.f)*0.5);
    saveListView.backgroundColor = [UIColor blackColor];
    //saveListView.alpha = 0.8;
    return saveListView;
}

-(instancetype)init
{
    self = [super init];
    if (self)
    {
        //让view成圆弧状
        self.layer.cornerRadius = 15.f;
        
        UITableView *saveListName = [[UITableView alloc]init];
        saveListName.delegate = self;
        saveListName.dataSource = self;
        _saveListName = saveListName;
        [self addSubview:saveListName];
        
        UIButton *okButton = [[UIButton alloc]init];
        _okButton = okButton;
//        okButton.backgroundColor = [UIColor grayColor];
//        //okButton.layer.borderColor = (__bridge CGColorRef)([UIColor whiteColor]);
//        okButton.layer.borderColor = [[UIColor whiteColor] CGColor];
//        okButton.layer.borderWidth = 2.f;
//        okButton.layer.cornerRadius = 5.f;
        [okButton setTitle:@"确定" forState:UIControlStateNormal];
        [okButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [okButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [okButton addTarget:self action:@selector(okButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self  addSubview:okButton];
        
        UIButton *cancelButton = [[UIButton alloc]init];
        _cancelButton = cancelButton;
//        cancelButton.backgroundColor = [UIColor grayColor];
//        cancelButton.layer.borderColor = [[UIColor whiteColor] CGColor];
//        cancelButton.layer.borderWidth = 2.f;
//        cancelButton.layer.cornerRadius = 5.f;
        [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [cancelButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [cancelButton addTarget:self action:@selector(cancelButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self  addSubview:cancelButton];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    _saveListName.frame = CGRectMake(KMargin, KMargin, self.frame.size.width-2*KMargin, 120.f);
    _okButton.frame = CGRectMake(_saveListName.left, _saveListName.bottom+2*MidMargin, (_saveListName.width-MidMargin)*0.5, 30.f);
    _cancelButton.frame = CGRectMake(_okButton.right+MidMargin, _okButton.top, _okButton.width, _okButton.height);
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.saveNameList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"localMusicCellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    SaveList *saveList = self.saveNameList[indexPath.row];
    cell.textLabel.text = saveList.name;
    return cell;
}

-(void)showInView:(UIView *)view
{
    UIView *mengBoard = [[UIView alloc]init];
    _mengBoard = mengBoard;
    mengBoard.frame = [UIScreen mainScreen].bounds;
    mengBoard.backgroundColor = [UIColor blackColor];
    mengBoard.alpha = 0.2;
    [view addSubview:mengBoard];
    [view addSubview:self];
}

-(void)hide
{
    [_mengBoard removeFromSuperview];
    [self removeFromSuperview];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SaveList *saveList = self.saveNameList[indexPath.row];
    _saveList = saveList;
}

#pragma mark 确定添加
-(void)okButtonClick:(UIButton *)sender
{
    if (_saveList.name.length == 0 || _saveList == nil)
    {
        UIAlertView *alterView = [[UIAlertView alloc]initWithTitle:@"提示信息" message:@"请输入播放列表" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alterView show];
        return;
    }
    if ([_delegate respondsToSelector:@selector(KGLocalMusicSaveListView:didSaveListNameConfirm:)])
    {
        [_delegate KGLocalMusicSaveListView:self didSaveListNameConfirm:_saveList];
    }
}

#pragma mark 取消添加
-(void)cancelButtonClick:(UIButton *)sender
{
    if ([_delegate respondsToSelector:@selector(KGLocalMusicSaveListView:didSaveListNameConfirm:)])
    {
        [_delegate KGLocalMusicSaveListView:self didSaveListNameConfirm:nil];
    }
}
@end
