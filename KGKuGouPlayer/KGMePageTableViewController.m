//
//  KGMePageTableViewController.m
//  KGKuGouPlayer
//
//  Created by neuedu on 15/10/21.
//  Copyright (c) 2015年 neuedu. All rights reserved.
//

#import "KGMePageTableViewController.h"

@interface KGMePageTableViewController ()

@end

@implementation KGMePageTableViewController

- (void)addMoreMusicFromWeb
{
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.tableView.header endRefreshing];
            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
            //序列化，设置header，采用参数时，不需要使用序列化
            manager.requestSerializer = [AFHTTPRequestSerializer serializer];
            //请求命令前，向服务器出示令牌，令牌时采用HTTPHeader的方式设置的，通常一些服务器还可以采用参数的方式出示令牌，如：新浪微博
            [manager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@",[CurUserMngTool sharedCurUserMngTool].token.access_token] forHTTPHeaderField:@"Authorization"];
            
            [manager GET:@"https://api.douban.com/v2/user/~me" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
             {
                 KGLoginUser *loginUser = [KGLoginUser loginUserWithDictionary:responseObject];
                 [CurUserMngTool sharedCurUserMngTool].loginUser = loginUser;
                 NSLog(@"JSON: %@", loginUser.avatar);
                 
                 //更新tableView
                 [self.tableView reloadData];
             }
                 failure:^(AFHTTPRequestOperation *operation, NSError *error)
             {
                 NSLog(@"Error: %@", error);
             }];
        });
    }];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    
    [self addMoreMusicFromWeb];
    
    // 马上进入刷新状态
    [self.tableView.header beginRefreshing];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self addMoreMusicFromWeb];
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
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"meCell" forIndexPath:indexPath];
    
    // Configure the cell...
    KGLoginUser *loginUser = [CurUserMngTool sharedCurUserMngTool].loginUser;
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:loginUser.avatar] placeholderImage:[UIImage imageNamed:@"userMessage_headBgImage"]];
    cell.textLabel.text = loginUser.name;
    cell.detailTextLabel.text = loginUser.desc;
    
    cell.imageView.layer.cornerRadius = 21.5;
//    cell.imageView.layer.masksToBounds = YES;
    cell.imageView.clipsToBounds = YES;
    
    return cell;
}

@end
