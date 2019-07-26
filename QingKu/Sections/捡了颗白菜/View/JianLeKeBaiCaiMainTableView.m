//
//  JianLeKeBaiCaiMainTableView.m
//  QingKu
//
//  Created by mdb-losaic on 2019/7/26.
//  Copyright © 2019 mcxzfa. All rights reserved.
//

#import "JianLeKeBaiCaiMainTableView.h"

#import "JianLeKeBaiCaiMainTableViewCell.h"

@interface JianLeKeBaiCaiMainTableView () 
{
    
    
}
@end

@implementation JianLeKeBaiCaiMainTableView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(JianLeKeBaiCaiMainTableView * )initWithFrame:(CGRect)frame andtype:(NSString *)type
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
    static NSString *strcell = @"JianLeKeBaiCaiMainTableViewCell";
    JianLeKeBaiCaiMainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strcell];
    if(!cell)
    {
        cell = [[JianLeKeBaiCaiMainTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strcell];
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
    
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    self.contentOffsetp = scrollView.contentOffset;
    [self.listDelegate scrollViewDidScroll:scrollView];
}

@end
