//
//  KGMusicMenu.m
//  KGKuGouPlayer
//
//  Created by neuedu on 15/9/21.
//  Copyright (c) 2015年 neuedu. All rights reserved.
//

#import "KGMusicMenu.h"

@implementation KGMusicMenu

+ (instancetype)musicMenuWithInfos:(NSArray *)infoArray
{
    KGMusicMenu *menu = [[KGMusicMenu alloc]init];
    if (menu)
    {
        //menu.backgroundColor = [UIColor blackColor];
        //menu.alpha = 0.9f;
        menu.backgroundColor = [UIColor colorWithRed:61.f/255.f green:61.f/255.f blue:61.f/255.f alpha:1];
        [menu setupSubViews:infoArray];
    }
    return menu;
}

- (void)setupSubViews:(NSArray *)infoArray
{
    for (int i = 0; i < infoArray.count; i++)
    {
        NEUButton *subButton = [[NEUButton alloc]init];
        NSDictionary *dict = infoArray[i];
        [subButton setTitle:dict[@"title"] forState:UIControlStateNormal];
        [subButton setImage:[UIImage imageNamed:dict[@"image"]] forState:UIControlStateNormal];
        subButton.titleLabel.font = [UIFont systemFontOfSize:15.f];
        [subButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:subButton];
    }

}

- (void)layoutSubviews
{
    [super layoutSubviews];
    NSUInteger index = 0;
    for (NEUButton *button in self.subviews)
    {
        button.frame = CGRectMake(index*([UIScreen mainScreen].bounds.size.width)/self.subviews.count, 0, ([UIScreen mainScreen].bounds.size.width)/self.subviews.count, self.height);
        index++;
    }
}

#pragma mark 按钮点击响应函数
-(void)buttonClick:(NEUButton *)button
{
    if ([_delegate respondsToSelector:@selector(musicMenu:didButtonClick:)])
    {
        [_delegate musicMenu:self didButtonClick:[button titleForState:UIControlStateNormal]];
    }
}
@end
