//
//  MBProgressHUD+MoreExtension.h
//  KGKuGouPlayer
//
//  Created by neuedu on 15/10/20.
//  Copyright (c) 2015年 neuedu. All rights reserved.
//

#import "MBProgressHUD.h"
#import "UIView+Extension.h"

@interface MBProgressHUD (MoreExtension)

+ (MB_INSTANCETYPE)showHUDAddedTo:(UIView *)view LabelText:(NSString*)labelText animated:(BOOL)animated;
+(void)showTipToWindow:(NSString *)tip afterDelay:(NSTimeInterval)timer;

@end
