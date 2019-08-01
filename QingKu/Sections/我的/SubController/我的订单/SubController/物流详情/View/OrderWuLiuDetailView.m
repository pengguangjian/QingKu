//
//  OrderWuLiuDetailView.m
//  QingKu
//
//  Created by mdb-losaic on 2019/8/1.
//  Copyright © 2019 mcxzfa. All rights reserved.
//

#import "OrderWuLiuDetailView.h"
#import "OrderWuLiuDetailTableViewCell.h"


@interface OrderWuLiuDetailView () <UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tabview;
    
}
@end

@implementation OrderWuLiuDetailView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        [self drawUI];
    }
    return self;
}

-(void)drawUI
{
    tabview = [[UITableView alloc] init];
    [tabview setDelegate:self];
    [tabview setDataSource:self];
    [tabview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [tabview setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:tabview];
    [tabview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self);
        make.width.offset(kMainScreenW);
    }];
    [self drawtabHeaderview:nil];
    
}

-(void)drawtabHeaderview:(NSDictionary *)dicvalue
{
    
    if([[NSString stringWithFormat:@"%@",[dicvalue objectForKey:@"expressnumber"]] length]<5)
    {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenW, 20)];
        [view setBackgroundColor:[UIColor whiteColor]];
        [tabview setTableHeaderView:view];
        return;
    }
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenW, 100)];
    [view setBackgroundColor:[UIColor whiteColor]];
    
    
    UIImageView *imgvhead = [[UIImageView alloc] initWithFrame:CGRectMake(10, 17, 71, 71)];
    [imgvhead.layer setMasksToBounds:YES];
    [imgvhead.layer setCornerRadius:4];
    ///icon120.png
//    [[MDB_UserDefault defaultInstance] setViewImageWithURL:[NSURL URLWithString:[dicvalue objectForKey:@"shotpics"]] placeholder:[UIImage imageNamed:@"icon120.png"] UIimageview:imgvhead];
    [imgvhead setBackgroundColor:[UIColor grayColor]];
    [view addSubview:imgvhead];
    
    UILabel *lbtitle = [[UILabel alloc] initWithFrame:CGRectMake(imgvhead.right+10, imgvhead.top+15, view.width-imgvhead.right-75, 20)];
    [lbtitle setText:[NSString stringWithFormat:@"物流公司：%@",[dicvalue objectForKey:@"expressname"] ]];
    [lbtitle setTextColor:RGB(102,102,102)];
    [lbtitle setTextAlignment:NSTextAlignmentLeft];
    [lbtitle setFont:[UIFont systemFontOfSize:12]];
    [view addSubview:lbtitle];
    
    UILabel *lbwldanhao = [[UILabel alloc] initWithFrame:CGRectMake(imgvhead.right+10, lbtitle.bottom+5, view.width-imgvhead.right-75, 20)];
    [lbwldanhao setText:[NSString stringWithFormat:@"物流单号：%@",[dicvalue objectForKey:@"expressnumber"] ]];
    [lbwldanhao setTextColor:RGB(102,102,102)];
    [lbwldanhao setTextAlignment:NSTextAlignmentLeft];
    [lbwldanhao setFont:[UIFont systemFontOfSize:12]];
    [view addSubview:lbwldanhao];
    
    
    UIButton *btcopy = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30*kScale, 17*kScale)];
    [btcopy setTitle:@"复制" forState:UIControlStateNormal];
    [btcopy setTitleColor:RGB(51,51,51) forState:UIControlStateNormal];
    [btcopy.titleLabel setFont:[UIFont systemFontOfSize:11]];
    [btcopy.layer setMasksToBounds:YES];
    [btcopy.layer setCornerRadius:2];
    [btcopy.layer setBorderColor:RGB(102,102,102).CGColor];
    [btcopy.layer setBorderWidth:1];
    [btcopy setTop:lbwldanhao.top];
    [btcopy setRight:view.width-10];
    [view addSubview:btcopy];
    [btcopy addTarget:self action:@selector(copyAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *viewlin = [[UIView alloc] initWithFrame:CGRectMake(0, imgvhead.bottom+17,view.width , 10)];
    [viewlin setBackgroundColor:RGB(241,241,241)];
    [view addSubview:viewlin];
    
    
    UILabel *lbname = [[UILabel alloc] initWithFrame:CGRectMake(10, viewlin.bottom+20, 150, 30)];
    [lbname setText:@"物流中心"];
    [lbname setTextColor:RGB(51,51,51)];
    [lbname setTextAlignment:NSTextAlignmentLeft];
    [lbname setFont:[UIFont systemFontOfSize:15]];
    [view addSubview:lbname];
    
    [view setHeight:lbname.bottom+20];
    
    [tabview setTableHeaderView:view];
}
#pragma mark - 复制
-(void)copyAction
{
    
}

#pragma mark - UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *strcell = @"OrderWuLiuDetailTableViewCell";
    OrderWuLiuDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strcell];
    if(!cell)
    {
        cell = [[OrderWuLiuDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strcell];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
//    cell.model = arrdata[indexPath.row];
    cell.iline = indexPath.row;
    cell.islast = NO;
    if(indexPath.row == 4)
    {
        cell.islast = YES;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}


@end
