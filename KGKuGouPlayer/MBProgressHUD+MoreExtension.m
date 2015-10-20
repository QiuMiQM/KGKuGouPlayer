//
//  MBProgressHUD+MoreExtension.m
//  KGKuGouPlayer
//
//  Created by neuedu on 15/10/20.
//  Copyright (c) 2015年 neuedu. All rights reserved.
//

#import "MBProgressHUD+MoreExtension.h"

@implementation MBProgressHUD (MoreExtension)

+(instancetype)showHUDAddedTo:(UIView *)view LabelText:(NSString *)labelText animated:(BOOL)animated
{
    MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:view animated:animated];
    hud.labelText = labelText;
    return hud;
}

+(void)showTipToWindow:(NSString *)tip afterDelay:(NSTimeInterval)timer
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = tip;
    hud.yOffset = ([UIScreen mainScreen].bounds.size.height/2.f)/2.f;
    [hud hide:YES afterDelay:2.f];
}

@end
