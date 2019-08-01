//
//  MyorderListTableViewController.m
//  QingKu
//
//  Created by mdb-losaic on 2019/7/31.
//  Copyright © 2019 mcxzfa. All rights reserved.
//

#import "MyorderListTableViewController.h"
#import "MyOrderListTableViewCell.h"

#import "OrderDetailViewController.h"

@interface MyorderListTableViewController ()

@end

@implementation MyorderListTableViewController
-(id)initWithStyle:(UITableViewStyle)style
{
    if(self = [super initWithStyle:UITableViewStyleGrouped])
    {
        
    }
    return self;
}


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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *strcell = @"MyOrderListTableViewCell";
    MyOrderListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strcell];
    if(!cell)
    {
        cell = [[MyOrderListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strcell];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    if(indexPath.row == indexPath.section)
    {
        cell.islast = YES;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    return 100;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.width, 40)];
    [view setBackgroundColor:[UIColor whiteColor]];
    [view setUserInteractionEnabled:YES];
    [view setTag:section];
    UITapGestureRecognizer *tapheader = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headerFooterTapAction:)];
    [view addGestureRecognizer:tapheader];
    
    
    UILabel *lbshop = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, kMainScreenW-150, 40)];
    [lbshop setTextColor:RadMenuColor];
    [lbshop setTextAlignment:NSTextAlignmentLeft];
    [lbshop setFont:[UIFont systemFontOfSize:14]];
    [view addSubview:lbshop];
    
    
    UILabel *lbstate = [[UILabel alloc] initWithFrame:CGRectMake(view.width-110, 0, 100, lbshop.height)];
    [lbstate setTextColor:RGB(153,153,153)];
    [lbstate setTextAlignment:NSTextAlignmentRight];
    [lbstate setFont:[UIFont systemFontOfSize:13]];
    [view addSubview:lbstate];
    [lbstate setText:@"待付款"];
    
    
    UIView *viewline0 = [[UIView alloc] initWithFrame:CGRectMake(0, lbstate.bottom, view.width, 1)];
    [viewline0 setBackgroundColor:RGB(236,236,236)];
    [view addSubview:viewline0];
    
    return view;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    float ftemp = 100.0;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.width, ftemp)];
    [view setBackgroundColor:[UIColor whiteColor]];
    [view setTag:section];
    UITapGestureRecognizer *tapfooter = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headerFooterTapAction:)];
    [view addGestureRecognizer:tapfooter];
    
    
    UILabel *lbmessage = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, view.width-20, 40)];
    [lbmessage setTextColor:RGB(153,153,153)];
    [lbmessage setTextAlignment:NSTextAlignmentLeft];
    [lbmessage setNumberOfLines:2];
    [lbmessage setFont:[UIFont systemFontOfSize:13]];
    [view addSubview:lbmessage];
    
    [lbmessage setText:[NSString stringWithFormat:@"共计%ld件商品，合计￥%@",section,@"200.00"]];
    
    
    
    UIButton *btleft = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    [btleft.layer setMasksToBounds:YES];
    [btleft.layer setCornerRadius:2];
    [btleft.layer setBorderColor:RGB(187,187,187).CGColor];
    [btleft.layer setBorderWidth:1];
    [btleft setTitle:@"" forState:UIControlStateNormal];
    [btleft setTitleColor:RGB(102,102,102) forState:UIControlStateNormal];
    [btleft.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [view addSubview:btleft];
    [btleft setTag:section];
    [btleft addTarget:self action:@selector(leftAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btright = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    [btright.layer setMasksToBounds:YES];
    [btright.layer setCornerRadius:2];
    [btright.layer setBorderColor:RGB(187,187,187).CGColor];
    [btright.layer setBorderWidth:1];
    [btright setTitle:@"" forState:UIControlStateNormal];
    [btright setTitleColor:RGB(102,102,102) forState:UIControlStateNormal];
    [btright.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [btright setTag:section];
    [view addSubview:btright];
    [btright addTarget:self action:@selector(rightAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [btright setFrame:CGRectMake(0, lbmessage.bottom, 66, 30)];
    [btright setTitle:@"立即付款" forState:UIControlStateNormal];
    [btright setRight:view.width-10];
    
    [btleft setFrame:CGRectMake(0, btright.top, 66, btright.height)];
    [btleft setTitle:@"取消订单" forState:UIControlStateNormal];
    [btleft setRight:btright.left-10];
    
    
    UILabel *lbtuikuanstate = [[UILabel alloc] initWithFrame:CGRectZero];
    [lbtuikuanstate setTextColor:RGB(243,93,0)];
    [lbtuikuanstate setTextAlignment:NSTextAlignmentRight];
    [lbtuikuanstate setFont:[UIFont systemFontOfSize:10]];
    [view addSubview:lbtuikuanstate];
    [lbtuikuanstate setFrame:CGRectMake(0, btright.bottom, 100, 15)];
    [lbtuikuanstate setRight:view.width-10];
    [lbtuikuanstate setText:@"退款中"];
    
    
    UIView *viewline1 = [[UIView alloc] initWithFrame:CGRectZero];
    [viewline1 setBackgroundColor:RGB(236,236,236)];
    [view addSubview:viewline1];
    [viewline1 setFrame:CGRectMake(0, view.height-10, view.width, 10)];
    [view addSubview:viewline1];
    
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld",indexPath.section);
    OrderDetailViewController *ovc = [[OrderDetailViewController alloc] init];
    [self.navigationController pushViewController:ovc animated:YES];
    
}

-(void)headerFooterTapAction:(UIGestureRecognizer *)gesture
{
    NSIndexPath *index = [NSIndexPath indexPathWithIndex:gesture.view.tag];
    [self tableView:self.tableView didSelectRowAtIndexPath:index];
    
}

-(void)leftAction:(UIButton *)sender
{
    
}

-(void)rightAction:(UIButton *)sender
{
    
}

@end
