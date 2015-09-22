//
//  NEUButton.m
//  KGKuGouPlayer
//
//  Created by neuedu on 15/9/22.
//  Copyright (c) 2015年 neuedu. All rights reserved.
//

#import "NEUButton.h"

@implementation NEUButton

-(CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat newRectX = (CGRectGetWidth(contentRect)-30.f)*0.5;
    CGFloat newRectY = 5.f;
    CGRect newRect = CGRectMake(newRectX, newRectY, 30.f, 30.f);
    return newRect;
}

-(CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGRect titleRect = [super titleRectForContentRect:contentRect];
    CGFloat newRectX = (CGRectGetWidth(contentRect)-CGRectGetWidth(titleRect))*0.37;
    CGFloat newRectY = (CGRectGetHeight(contentRect)-35.f-CGRectGetHeight(titleRect))*0.5+35.f;
    CGRect newRect = CGRectMake(newRectX, newRectY, CGRectGetWidth(titleRect)+15.f, CGRectGetHeight(titleRect));
    return newRect;
}

@end
