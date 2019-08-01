//
//  MyYouHuiQuanTableViewController.m
//  QingKu
//
//  Created by mdb-losaic on 2019/7/31.
//  Copyright © 2019 mcxzfa. All rights reserved.
//

#import "MyYouHuiQuanTableViewController.h"
#import "MyYouHuiQuanTableViewCell.h"

@interface MyYouHuiQuanTableViewController ()

@end

@implementation MyYouHuiQuanTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView setBackgroundColor:[UIColor whiteColor]];
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    //    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
    //        ipage = 1;
    //        [self loadData];
    //    }];
    //    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
    //        ipage++;
    //        [self loadData];
    //    }];
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
}

-(void)loadData
{
    
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *strcell = @"MyYouHuiQuanTableViewCell";
    MyYouHuiQuanTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strcell];
    if(!cell)
    {
        cell = [[MyYouHuiQuanTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strcell];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 140;
}

@end
