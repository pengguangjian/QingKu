//
//  XiaoFeiJiLuTableViewController.m
//  QingKu
//
//  Created by mdb-losaic on 2019/9/2.
//  Copyright © 2019 mcxzfa. All rights reserved.
//

#import "XiaoFeiJiLuTableViewController.h"
#import "XiaoFeiJiLuTableViewCell.h"

@interface XiaoFeiJiLuTableViewController ()

@end

@implementation XiaoFeiJiLuTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = [MDB_UserDefault getSetStringNmae:@"xiaofeijilu"];
    [self.tableView setBackgroundColor:RGB(234, 234, 234)];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *strcell = @"XiaoFeiJiLuTableViewCell";
    XiaoFeiJiLuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strcell];
    if(!cell)
    {
        cell = [[XiaoFeiJiLuTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strcell];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [cell setBackgroundColor:RGB(234, 234, 234)];
    
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 105;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
