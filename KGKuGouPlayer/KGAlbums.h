//
//  KGAlbums.h
//  KGKuGouPlayer
//
//  Created by neuedu on 15/10/21.
//  Copyright (c) 2015年 neuedu. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 JSON: {
 count = 1;
 musics =     (
 {
 alt = "http://music.douban.com/subject/3576776/";
 "alt_title" = "";
 attrs =             {
 discs =                 (
 1
 );
 media =                 (
 CD
 );
 pubdate =                 (
 "2008-04-27"
 );
 publisher =                 (
 "\U534e\U8c0a\U5144\U5f1f"
 );
 singer =                 (
 BOBO
 );
 title =                 (
 "\U4e16\U754c\U4e4b\U5927"
 );
 tracks =                 (
 "01 \U5927\U660e\U661f Follow me\n02 \U4e16\U754c\U4e4b\U5927 My world\n03 \U53cc\U57ce The memory of two cities\n04 \U5047\U5982 If\U2026\U2026love\n05 \U65f6\U523b\U51c6\U5907\U7740 Yes I\U2019m ready\n06 \U6211\U4eec\U5531\U7684\U6b4c Our song\n07 \U4e00\U7c73\U9633\U5149 A little sunshine\n08 \U5149\U8363Q MIX The glory Q Mix\n09 \U604b\U7231\U65b0\U624b The first time falling in love\n10 \U600e\U4e48\U7231 Baby don\U2019t go\n11 \U5149\U8363 COOL MIX"
 );
 version =                 (
 "Q\U7248"
 );
 };
 author =             (
 {
 name = BOBO;
 }
 );
 id = 3576776;
 image = "https://img2.doubanio.com/spic/s3062898.jpg";
 "mobile_link" = "http://m.douban.com/music/subject/3576776/";
 rating =             {
 average = "7.3";
 max = 10;
 min = 0;
 numRaters = 623;
 };
 tags =             (
 {
 count = 156;
 name = BOBO;
 },
 {
 count = 75;
 name = "\U4e16\U754c\U4e4b\U5927";
 },
 {
 count = 72;
 name = "\U5185\U5730";
 },
 {
 count = 59;
 name = "\U4e95\U67cf\U7136";
 },
 {
 count = 55;
 name = "\U4ed8\U8f9b\U535a";
 },
 {
 count = 49;
 name = "BOBO\U7ec4\U5408";
 },
 {
 count = 37;
 name = "\U534e\U8bed";
 },
 {
 count = 34;
 name = Pop;
 }
 );
 title = "\U4e16\U754c\U4e4b\U5927";
 }
 );
 start = 0;
 total = 101;
 }
 */

@interface KGAlbums : NSObject

@property (strong, nonatomic) NSArray *singers;
@property (strong, nonatomic) NSArray *titles;
@property (copy, nonatomic) NSString *image;
@property (strong, nonatomic) NSMutableArray *tracks;
@property (copy, nonatomic) NSString *total;

+(instancetype)albumWithDict:(NSDictionary *)dict;

@end
