//
//  KGMusicsPageTableViewController.m
//  KGKuGouPlayer
//
//  Created by neuedu on 15/10/21.
//  Copyright (c) 2015年 neuedu. All rights reserved.
//

#import "KGMusicsPageTableViewController.h"
#import <UIImageView+WebCache.h>

@interface KGMusicsPageTableViewController ()

@property (strong, nonatomic) NSMutableArray *albumLists;
@property (copy, nonatomic) NSString *total;

@end

@implementation KGMusicsPageTableViewController

-(NSMutableArray *)albumLists
{
    if (_albumLists == nil)
    {
        _albumLists = [NSMutableArray array];
    }
    return _albumLists;
}

#pragma mark 从网络上加载更多歌曲
- (void)addMoreMusicFromWeb
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"q":_singerCondition,
                                 @"start":@(self.albumLists.count),
                                 @"count":@5
                                 };
    
    [manager GET:@"https://api.douban.com/v2/music/search" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSArray *album = [responseObject objectForKey:@"musics"];
         for (int i = 0; i<album.count; i++)
         {
             NSDictionary *albumsDict = album[i];
             KGAlbums *albumModel = [KGAlbums albumWithDict:albumsDict];
             //self.albumLists = albumModel.tracks;
             [self.albumLists addObject:albumModel];
             _total = albumModel.total;
             NSLog(@"album %@",albumModel.tracks);
         }
         //判断albumLists中的歌曲数量是否合服务器返回的总数量相同
         if (self.albumLists.count == [_total integerValue])
         {
             [self.tableView.footer noticeNoMoreData];
         }
         [self.tableView reloadData];
         //NSLog(@"JSON: %@", responseObject);
     }
         failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
     }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = [NSString stringWithFormat:@"%@的歌曲",_singerCondition];
    
    [self addMoreMusicFromWeb];
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 54.f, 0);
    
    [self downRefresh];
    [self upRefresh];
}

- (void)downRefresh
{
    //下拉刷新
    [self.tableView.header beginRefreshing];
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self addMoreMusicFromWeb];
            [self.tableView.header endRefreshing];
        });
    }];
}

- (void)upRefresh
{
    //上拉刷新
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self addMoreMusicFromWeb];
            [self.tableView.footer endRefreshing];
        });
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.albumLists.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"musicsCell" forIndexPath:indexPath];
    
    // Configure the cell...
    KGAlbums *album = self.albumLists[indexPath.row];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:album.image] placeholderImage:[UIImage imageNamed:@"play_bar_singerbg"]];
    
    cell.textLabel.text = [album.titles firstObject];
    cell.detailTextLabel.text = [album.singers firstObject];
    
    return cell;
}

@end
