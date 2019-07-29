//
//  FenLeiSearchTableView.m
//  QingKu
//
//  Created by mdb-losaic on 2019/7/29.
//  Copyright © 2019 mcxzfa. All rights reserved.
//

#import "FenLeiSearchTableView.h"
#import "FenLeiSearchTableViewCell.h"

#import "GoodsDetailViewController.h"

@interface FenLeiSearchTableView () <UITableViewDataSource,UITableViewDelegate>

@end

@implementation FenLeiSearchTableView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(id)initWithFrame:(CGRect)frame andtype:(NSString *)type
{
    if(self = [super initWithFrame:frame])
    {
        [self setDelegate:self];
        [self setDataSource:self];
        //        [self setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        //        [self setBackgroundColor:[UIColor redColor]];
    }
    return self;
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *strcell = @"FenLeiSearchTableViewCell";
    FenLeiSearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strcell];
    if(!cell)
    {
        cell = [[FenLeiSearchTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strcell];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld",indexPath.row);
    GoodsDetailViewController *gvc = [[GoodsDetailViewController alloc] init];
    [self.viewController.navigationController pushViewController:gvc animated:YES];
}

@end
