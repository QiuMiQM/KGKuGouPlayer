//
//  KGWelcomePageViewController.h
//  KGKuGouPlayer
//
//  Created by neuedu on 15/9/15.
//  Copyright (c) 2015年 neuedu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KGWelcomePageViewController : UIViewController<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *welcomePageScrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *welcomePageControl;

@end
