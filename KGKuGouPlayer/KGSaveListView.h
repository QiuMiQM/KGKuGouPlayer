//
//  KGSaveListView.h
//  KGKuGouPlayer
//
//  Created by neuedu on 15/9/28.
//  Copyright (c) 2015年 neuedu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+Extension.h"

@class KGSaveListView;
@protocol KGSaveListViewDelegate <NSObject>

@optional
-(void)KGSaveListView:(KGSaveListView *)saveListView didSaveListNameConfirm:(NSString *)saveListName;

@end

@interface KGSaveListView : UIView

@property (weak, nonatomic) UITextField *saveListName;
@property (weak, nonatomic) UIButton *okButton;
@property (weak, nonatomic) UIButton *cancelButton;
@property (weak, nonatomic) UIView *mengBoard;

@property (weak, nonatomic) id<KGSaveListViewDelegate> delegate;

+(instancetype)saveListView;

-(void)showInView:(UIView *)view;
-(void)hide;

@end
