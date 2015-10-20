//
//  KGSaveListView.m
//  KGKuGouPlayer
//
//  Created by neuedu on 15/9/28.
//  Copyright (c) 2015年 neuedu. All rights reserved.
//

#import "KGSaveListView.h"

#define KMargin 20.f
#define MidMargin 8.f

@implementation KGSaveListView

+(instancetype)saveListView
{
    KGSaveListView *saveListView = [[KGSaveListView alloc]init];
    saveListView.bounds = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width*0.6, 108.f);
    saveListView.center = CGPointMake([UIScreen mainScreen].bounds.size.width*0.5, ([UIScreen mainScreen].bounds.size.height-64.f-56.f)*0.5);
    saveListView.backgroundColor = [UIColor blackColor];
    saveListView.alpha = 0.8;
    return saveListView;
}

-(instancetype)init
{
    self = [super init];
    if (self)
    {
        //让view成圆弧状
        self.layer.cornerRadius = 15.f;
        
        UITextField *saveListName = [[UITextField alloc]init];
        _saveListName = saveListName;
        saveListName.text = @"默认列表";
        saveListName.backgroundColor = [UIColor whiteColor];
        saveListName.borderStyle = UITextBorderStyleRoundedRect;
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
    _saveListName.frame = CGRectMake(KMargin, KMargin, self.frame.size.width-2*KMargin, 30.f);
    _okButton.frame = CGRectMake(_saveListName.left, _saveListName.bottom+2*MidMargin, (_saveListName.width-MidMargin)*0.5, 30.f);
    _cancelButton.frame = CGRectMake(_okButton.right+MidMargin, _okButton.top, _okButton.width, _okButton.height);
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

#pragma mark 确定添加
-(void)okButtonClick:(UIButton *)sender
{
    if (_saveListName.text.length == 0)
    {
        UIAlertView *alterView = [[UIAlertView alloc]initWithTitle:@"提示信息" message:@"请输入播放列表" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alterView show];
        return;
    }
    if ([_delegate respondsToSelector:@selector(KGSaveListView:didSaveListNameConfirm:)])
    {
        [_delegate KGSaveListView:self didSaveListNameConfirm:_saveListName.text];
    }
}

#pragma mark 取消添加
-(void)cancelButtonClick:(UIButton *)sender
{
    if ([_delegate respondsToSelector:@selector(KGSaveListView:didSaveListNameConfirm:)])
    {
        [_delegate KGSaveListView:self didSaveListNameConfirm:nil];
    }
}
@end
