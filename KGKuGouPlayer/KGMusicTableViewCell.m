//
//  KGMusicTableViewCell.m
//  KGKuGouPlayer
//
//  Created by neuedu on 15/9/21.
//  Copyright (c) 2015年 neuedu. All rights reserved.
//

#import "KGMusicTableViewCell.h"

#define kMargin 14.f
#define COUNT 5
#define BUTTONFONT [UIFont systemFontOfSize:15.f]

@implementation KGMusicTableViewCell

+ (instancetype)musicTableViewCellWith:(UITableView *)tableView
{
    static NSString *cellID = @"musicTableViewCell";
    KGMusicTableViewCell *musicCell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (musicCell == nil)
    {
        musicCell = [[KGMusicTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return musicCell;
}

//纯代码自定义tableViewCell，添加子控件在initWithStyle初始化方法中
#pragma mark 重写init方法
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44.f);
        
        UIButton *addButton = [[UIButton alloc]init];
        _addButton = addButton;
        addButton.backgroundColor = [UIColor colorWithRed:61.f/255.f green:61.f/255.f blue:61.f/255.f alpha:1];
        [self.contentView addSubview:addButton];
        [addButton addTarget:self action:@selector(addMusicToPlayList:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *musicName = [[UILabel alloc]init];
        _musicName = musicName;
        [self.contentView addSubview:musicName];
        
        UIButton *mvButton = [[UIButton alloc]init];
        _mvButton = mvButton;
        mvButton.backgroundColor = [UIColor colorWithRed:61.f/255.f green:61.f/255.f blue:61.f/255.f alpha:1];
        [self.contentView addSubview:mvButton];
        [mvButton addTarget:self action:@selector(mvPlay:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *moreButton = [[UIButton alloc]init];
        _moreButton = moreButton;
        moreButton.backgroundColor = [UIColor colorWithRed:61.f/255.f green:61.f/255.f blue:61.f/255.f alpha:1];
        [self.contentView addSubview:moreButton];
        [moreButton addTarget:self action:@selector(moreMenu:) forControlEvents:UIControlEventTouchUpInside];
        
        //更多菜单
        NSArray *infos = @[@{@"title":@"下载",
                             @"image":@"download"},
                           @{@"title":@"添加",
                             @"image":@"addPlayList"},
                           @{@"title":@"分享",
                             @"image":@"share"},
                           @{@"title":@"歌曲信息"},
                           @{@"title":@"K歌"}];
        KGMusicMenu *menu = [KGMusicMenu musicMenuWithInfos:infos];
        menu.delegate = self;
        _background = menu;
        menu.hidden = YES;
        [self.contentView addSubview:menu];
//        UIView *backgroundView = [[UIView alloc]init];
//        _background = backgroundView;
//        backgroundView.backgroundColor = [UIColor blackColor];
//        backgroundView.alpha = 0.9f;
//        [self.contentView addSubview:backgroundView];
//        
//        NSArray *titles = @[@"下载",@"添加",@"分享",@"歌曲信息",@"K歌"];
//        
//        for (int i = 0; i < COUNT; i++)
//        {
//            UIButton *subButton = [[UIButton alloc]init];
//            [subButton setTitle:titles[i] forState:UIControlStateNormal];
//            //subButton.font = BUTTONFONT;
//            //[subButton setFont:BUTTONFONT];
//            [backgroundView addSubview:subButton];
//        }
    }
    return self;
}

#pragma mark 模型的set方法
- (void)setMusic:(Music *)music
{
    _music = music;
    [_musicName setText:music.name];
    if (music.cellStatus)
    {
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44.f);
    }
    else
    {
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44.f+65.f);
    }
    _background.hidden = music.cellStatus;
}

#pragma mark 设置子控件的位置
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _addButton.frame = CGRectMake(kMargin, kMargin, 16.f, 16.f);
    _moreButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-kMargin-29.f, 12.f, 29.f, 20.f);
    _mvButton.frame = CGRectMake(_moreButton.left-kMargin-29.f, _moreButton.top, 29.f, 20.f);
    _musicName.frame = CGRectMake(_addButton.right+kMargin, _addButton.top-5.f, [UIScreen mainScreen].bounds.size.width-_addButton.right, 28.f);
    _background.frame = CGRectMake(0, 44.f, [UIScreen mainScreen].bounds.size.width, 65.f);
    
//    NSUInteger index = 0;
//    for (UIButton *button in _background.subviews)
//    {
//        button.frame = CGRectMake(index*([UIScreen mainScreen].bounds.size.width)/_background.subviews.count, 0, ([UIScreen mainScreen].bounds.size.width)/_background.subviews.count, _background.height);
//        index++;
//    }
}

#pragma mark 添加歌曲到播放列表
- (void)addMusicToPlayList:(UIButton *)sender
{

}

#pragma mark 播放MV
- (void)mvPlay:(UIButton *)sender
{
    
}

#pragma mark 弹出更多菜单
- (void)moreMenu:(UIButton *)sender
{
    //_background.hidden = !_background.hidden;
    //self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44.f+65.f);
    
    sender.selected = !sender.selected;
    
    if ([_delegate respondsToSelector:@selector(musicTableViewCell:didShowOrHiddenMenu:)])
    {
        [_delegate musicTableViewCell:self didShowOrHiddenMenu:sender.selected];
    }
}

#pragma mark 代理方法
-(void)musicMenu:(KGMusicMenu *)menu didButtonClick:(NSString *)title
{
    if ([_delegate respondsToSelector:@selector(musicTableViewCell:didButtonClick:)])
    {
        [_delegate musicTableViewCell:self didButtonClick:title];
    }
}
@end
