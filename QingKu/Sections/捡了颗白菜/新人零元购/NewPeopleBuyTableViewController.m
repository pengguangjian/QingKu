//
//  NewPeopleBuyTableViewController.m
//  QingKu
//
//  Created by mdb-losaic on 2019/7/30.
//  Copyright © 2019 mcxzfa. All rights reserved.
//

#import "NewPeopleBuyTableViewController.h"
#import "NewPeopleBuyTableViewCell.h"
#import "MDB_UserDefault.h"

@interface NewPeopleBuyTableViewController ()
{
    NSTimer *toptimer;
    
    
}
@end

@implementation NewPeopleBuyTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"新人0元购";
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self drawHeaderview];
    
}

-(void)drawHeaderview
{
    UIView *viewheader = [self drawTopLineView:CGRectMake(0, 0, kMainScreenW, 45*kScale)];
    self.tableView.tableHeaderView = viewheader;
}

-(UIView *)drawTopLineView:(CGRect)rect
{
    UIView *viewtop = [[UIView alloc] initWithFrame:rect];
    [viewtop setBackgroundColor:RGBAlpha(255, 255, 221, 1)];
    [viewtop setClipsToBounds:YES];
    
    UILabel *lbtop = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, viewtop.width, viewtop.height)];
    [lbtop setText:@"0元购商品每个账户仅限1件，下单多件将收取超出的部分"];
    [lbtop setTextColor:RGB(251, 113, 0)];
    [lbtop setTextAlignment:NSTextAlignmentCenter];
    [lbtop setFont:[UIFont systemFontOfSize:14]];
    [lbtop setBackgroundColor:RGBAlpha(255, 255, 221, 1)];
    [viewtop addSubview:lbtop];
    
    if(toptimer != nil)
    {
        [toptimer timeInterval];
        toptimer = nil;
    }
    
    float flbtopw = [MDB_UserDefault countTextSize:CGSizeMake(1000, 20) andtextfont:lbtop.font andtext:lbtop.text].width;
    
    if(lbtop.width<flbtopw)
    {
        toptimer = [NSTimer scheduledTimerWithTimeInterval:0.02 target:self selector:@selector(toptimer:) userInfo:lbtop repeats:YES];
        [lbtop setWidth:flbtopw];
        [lbtop setLeft:10];
        
        [toptimer setFireDate:[NSDate dateWithTimeIntervalSince1970:[[NSDate date] timeIntervalSince1970]+3]];
        
        [[NSRunLoop mainRunLoop] addTimer:toptimer forMode:NSRunLoopCommonModes];
        
        
    }
    return viewtop;
}
#pragma mark - lbtop移动
-(void)toptimer:(NSTimer *)timer
{
    
    UILabel *lb = timer.userInfo;
    
    if(lb.right>0)
    {
        [lb setRight:lb.right-1];
    }
    else
    {
        [lb setLeft:kMainScreenW];
    }
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *strcell = @"NewPeopleBuyTableViewCell";
    NewPeopleBuyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strcell];
    if(!cell)
    {
        cell = [[NewPeopleBuyTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strcell];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 125;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
