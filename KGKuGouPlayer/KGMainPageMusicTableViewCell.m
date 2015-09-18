//
//  KGMainPageMusicTableViewCell.m
//  KGKuGouPlayer
//
//  Created by neuedu on 15/9/17.
//  Copyright (c) 2015年 neuedu. All rights reserved.
//

#import "KGMainPageMusicTableViewCell.h"

@implementation KGMainPageMusicTableViewCell

+ (instancetype)mainPageMusicTableViewCellWithTableView:(UITableView *)tableView
{
    static NSString *cellID = @"mainListcell";
    KGMainPageMusicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil)
    {
        cell = [[KGMainPageMusicTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}

- (void)setStatus:(KGMusicCellStatusModel *)status
{
    if (status.selected)
    {
        self.textLabel.textColor = [UIColor colorWithRed:232.f/255.f green:222.f/255.f blue:0/255.f alpha:1];
    }
    else
    {
        self.textLabel.textColor = [UIColor whiteColor];
    }
}

- (void)awakeFromNib
{
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
