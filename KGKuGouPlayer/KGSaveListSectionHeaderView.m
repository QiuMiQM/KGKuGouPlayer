//
//  KGSaveListSectionHeaderView.m
//  KGKuGouPlayer
//
//  Created by neuedu on 15/9/29.
//  Copyright (c) 2015年 neuedu. All rights reserved.
//

#import "KGSaveListSectionHeaderView.h"

#define KMargin 7.f
#define HEIGHT 30.f

@implementation KGSaveListSectionHeaderView

+(instancetype)saveListSectionHeaderView
{
    KGSaveListSectionHeaderView *view = [[KGSaveListSectionHeaderView alloc]init];
    view.frame = CGRectMake(0.f, 0.f, [UIScreen mainScreen].bounds.size.width, 44.f);
    view.backgroundColor = [UIColor lightGrayColor];
    return view;
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        UILabel *title = [[UILabel alloc]init];
        _title = title;
        [self addSubview:title];
        
        UIButton *deleteButton = [[UIButton alloc]init];
        _deleteButton = deleteButton;
        [self addSubview:deleteButton];
        [deleteButton addTarget:self action:@selector(deleteButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [deleteButton setTitle:@"删除" forState:UIControlStateNormal];
        deleteButton.backgroundColor = [UIColor colorWithRed:48.f/255.f green:131.f/255.f blue:251.f/255.f alpha:1];
        deleteButton.alpha = 0.8;
        [deleteButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [deleteButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    }
    return self;
}

-(void)deleteButtonClicked:(UIButton *)sender
{
    if ([_delegate respondsToSelector:@selector(saveListSectionHeaderViewDidDeleteButtonClicked:)])
    {
        [_delegate saveListSectionHeaderViewDidDeleteButtonClicked:self];
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    _title.frame = CGRectMake(2*KMargin, KMargin, self.frame.size.width-2*HEIGHT-2*KMargin, HEIGHT);
    _deleteButton.frame = CGRectMake(_title.right+KMargin, _title.top, 2*HEIGHT-2*KMargin, HEIGHT);
}

-(void)setSaveList:(SaveList *)saveList
{
    _saveList = saveList;
    _title.text = saveList.name;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if ([_delegate respondsToSelector:@selector(saveListSectionHeaderViewDidClicked:)])
    {
        [_delegate saveListSectionHeaderViewDidClicked:self];
    }
}

@end
