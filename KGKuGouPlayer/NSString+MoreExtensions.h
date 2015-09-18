//
//  NSString+MoreExtentions.h
//  UI12 - MicroBlog
//
//  Created by neuedu on 15/8/24.
//  Copyright (c) 2015年 neuedu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (MoreExtensions)

//返回字符串占用的高度
-(CGFloat)heightForWidth:(CGFloat)width WithFont:(UIFont *)font;
-(CGFloat)widthForText:(CGFloat)width WithFont:(UIFont *)font;

-(BOOL)validatePhoneNumber;

@end
