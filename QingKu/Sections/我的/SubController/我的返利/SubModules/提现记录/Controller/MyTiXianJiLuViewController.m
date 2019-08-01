//
//  MyTiXianJiLuViewController.m
//  QingKu
//
//  Created by mdb-losaic on 2019/7/31.
//  Copyright © 2019 mcxzfa. All rights reserved.
//

#import "MyTiXianJiLuViewController.h"
#import "MyTiXianJiLuTableViewCell.h"
#import <MJRefresh.h>

@interface MyTiXianJiLuViewController ()
{
    int ipage;
    
    
}
@end

@implementation MyTiXianJiLuViewController
-(id)initWithStyle:(UITableViewStyle)style
{
    if(self = [super initWithStyle:UITableViewStyleGrouped])
    {
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"提现记录";
    
    [self drawUI];
}

-(void)drawUI
{
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
#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section+1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *strcell = @"MyTiXianJiLuTableViewCell";
    MyTiXianJiLuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strcell];
    if(!cell)
    {
        cell = [[MyTiXianJiLuTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strcell];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenW, 40)];
    [view setBackgroundColor:RGB(245, 244, 245)];
    
    UILabel *lbgjname = [[UILabel alloc] init];
    [lbgjname setText:@"2016.06"];
    [lbgjname setTextAlignment:NSTextAlignmentLeft];
    [lbgjname setTextColor:RGB(150, 150, 150)];
    [lbgjname setFont:[UIFont systemFontOfSize:12]];
    [view addSubview:lbgjname];
    [lbgjname mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(20);
        make.top.bottom.equalTo(view);
        make.width.offset(200);
        
    }];
    
    
    return view;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenW, 0.1)];
    [view setBackgroundColor:[UIColor whiteColor]];
    
    return view;
}


@end
