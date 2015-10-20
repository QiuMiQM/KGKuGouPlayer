//
//  KGDoubanLoginViewController.h
//  KGKuGouPlayer
//
//  Created by neuedu on 15/10/19.
//  Copyright (c) 2015年 neuedu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD+MoreExtension.h"
#import "KGAccessToken.h"

@interface KGDoubanLoginViewController : UIViewController<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *loginWeb;

@end
