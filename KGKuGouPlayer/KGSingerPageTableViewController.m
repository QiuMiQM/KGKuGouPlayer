//
//  KGSingerPageTableViewController.m
//  KGKuGouPlayer
//
//  Created by neuedu on 15/10/21.
//  Copyright (c) 2015年 neuedu. All rights reserved.
//

#import "KGSingerPageTableViewController.h"

@interface KGSingerPageTableViewController ()

@end

@implementation KGSingerPageTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.sectionHeaderHeight = 40.f;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *singerCondition = cell.textLabel.text;
    
    [self performSegueWithIdentifier:@"toMusics" sender:singerCondition];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    KGMusicsPageTableViewController *vc = segue.destinationViewController;
    vc.singerCondition = sender;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"singerCell" forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.textColor = [UIColor blueColor];
    
    return cell;
}
*/

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    if (searchBar.text.length != 0)
    {
        [self performSegueWithIdentifier:@"toMusics" sender:searchBar.text];
    }
    else
    {
        [MBProgressHUD showTipToWindow:@"Please input again." afterDelay:1.f];
    }
}

@end
