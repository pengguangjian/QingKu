//
//  GouWuCheMainTableView.m
//  QingKu
//
//  Created by mdb-losaic on 2019/7/29.
//  Copyright © 2019 mcxzfa. All rights reserved.
//

#import "GouWuCheMainTableView.h"
#import "GouWuCheMainTableViewCell.h"

@interface GouWuCheMainTableView ()<UITableViewDelegate,UITableViewDataSource>
{
    ///正常底部
    UIView *viewbottom;
    ///编辑底部
    UIView *viewEditBottom;
    ///全选价格
    UILabel *lballSelectprice;
    ///全选
    UIButton *btallselect;
}
@property (nonatomic , retain) UITableView *tabView;

@end

@implementation GouWuCheMainTableView

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
    self.tabView = [[UITableView alloc] init];
    [self.tabView setDelegate:self];
    [self.tabView setDataSource:self];
    [self.tabView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self addSubview:self.tabView];
    [self.tabView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.bottom.equalTo(self).offset(-50*kScale);
    }];
    
    ///正常的底部
    viewbottom = [[UIView alloc] init];
    [viewbottom setBackgroundColor:RGB(247, 247, 247)];
    [self addSubview:viewbottom];
    [viewbottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.height.offset(50*kScale);
        make.bottom.equalTo(self.mas_bottom);
    }];
    [self drawbottomui];
    
    ///编辑的底部
    viewEditBottom = [[UIView alloc] init];
    [viewEditBottom setBackgroundColor:RGB(247, 247, 247)];
    [viewEditBottom setHidden:YES];
    [self addSubview:viewEditBottom];
    [viewEditBottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.height.offset(50*kScale);
        make.bottom.equalTo(self.mas_bottom);
    }];
    [self drawEditBottomui];
    
}
-(void)drawbottomui
{
    UILabel *lball = [[UILabel alloc] init];
    [viewbottom addSubview:lball];
    [lball mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(10);
        make.top.offset(0);
        make.bottom.equalTo(self->viewbottom);
    }];
    [lball setText:@"总计："];
    [lball setTextColor:RGB(30, 30, 30)];
    [lball setTextAlignment:NSTextAlignmentLeft];
    [lball setFont:[UIFont systemFontOfSize:14]];
    
    UILabel *lballprice = [[UILabel alloc] init];
    [viewbottom addSubview:lballprice];
    [lballprice mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(lball.mas_right);
        make.top.offset(0);
        make.bottom.equalTo(self->viewbottom);
    }];
    [lballprice setText:@"￥546.64"];
    [lballprice setTextColor:RadMenuColor];
    [lballprice setTextAlignment:NSTextAlignmentLeft];
    [lballprice setFont:[UIFont systemFontOfSize:14]];
    lballSelectprice = lballprice;
    
    
    
    UIButton *btjiesuan = [[UIButton alloc] init];
    [btjiesuan setBackgroundColor:RadMenuColor];
    [viewbottom addSubview:btjiesuan];
    [btjiesuan mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset(110*kScale);
        make.top.offset(0);
        make.bottom.right.equalTo(self->viewbottom);
        
    }];
    [btjiesuan setTitle:@"去结算" forState:UIControlStateNormal];
    [btjiesuan setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btjiesuan.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [btjiesuan addTarget:self action:@selector(jiesuanAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIView *viewline = [[UIView alloc] init];
    [viewline setBackgroundColor:RGB(209, 209, 209)];
    [viewbottom addSubview:viewline];
    [viewline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self->viewbottom);
        make.height.offset(1);
    }];
    
    
}

-(void)drawEditBottomui
{
    btallselect = [[UIButton alloc] init];
    [viewEditBottom addSubview:btallselect];
    [btallselect mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset(100*kScale);
        make.left.offset(10);
        make.bottom.top.equalTo(self->viewEditBottom);
        
    }];
    [btallselect setTitle:@"全选" forState:UIControlStateNormal];
    [btallselect setTitleColor:RGB(30, 30, 30) forState:UIControlStateNormal];
    [btallselect.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [btallselect setImage:[UIImage imageNamed:@"yuan_select_no"] forState:UIControlStateNormal];
    [btallselect setImageEdgeInsets:UIEdgeInsetsMake(0, -15, 0, 0)];
    [btallselect addTarget:self action:@selector(selectAllAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btdel = [[UIButton alloc] init];
    [btdel setBackgroundColor:[UIColor whiteColor]];
    [viewEditBottom addSubview:btdel];
    [btdel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.offset(8);
        make.bottom.equalTo(self->viewEditBottom).offset(-8);
        make.width.offset(90*kScale);
        make.right.equalTo(self->viewEditBottom).offset(-10);
    }];
    [btdel.layer setMasksToBounds:YES];
    [btdel.layer setCornerRadius:(50*kScale-16)/2.0];
    [btdel.layer setBorderColor:RadMenuColor.CGColor];
    [btdel.layer setBorderWidth:1];
    [btdel setTitleColor:RadMenuColor forState:UIControlStateNormal];
    [btdel setTitle:@"删除" forState:UIControlStateNormal];
    [btdel.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [btdel addTarget:self action:@selector(delListAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *viewline = [[UIView alloc] init];
    [viewline setBackgroundColor:RGB(209, 209, 209)];
    [viewbottom addSubview:viewline];
    [viewline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self->viewbottom);
        make.height.offset(1);
    }];
    
    
}
#pragma mark - ///全选
-(void)selectAllAction
{
    
}
#pragma mark - ///删除
-(void)delListAction
{
    
}
#pragma mark - ///结算
-(void)jiesuanAction
{
    
}

#pragma mark - UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *strcell = @"GouWuCheMainTableViewCell";
    GouWuCheMainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strcell];
    if(!cell)
    {
        cell = [[GouWuCheMainTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strcell];
        
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}
////
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    return YES;
}
// 定义编辑样式
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
    
}
// 进入编辑模式，按下出现的编辑按钮后,进行删除操作
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        ///删除
        
    }
    
}
// 修改编辑按钮文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
