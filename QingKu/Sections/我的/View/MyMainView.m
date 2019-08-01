//
//  MyMainView.m
//  QingKu
//
//  Created by mdb-losaic on 2019/7/30.
//  Copyright © 2019 mcxzfa. All rights reserved.
//

#import "MyMainView.h"
#import "CollectsTableViewController.h"
#import "AddressListsViewController.h"

#import "MyFanLiViewController.h"

#import "MyYouHuiQuanViewController.h"


#import "MyOrderMainViewController.h"


@implementation MyMainView

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
    UIScrollView *scvback = [[UIScrollView alloc] init];
    [scvback setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:scvback];
    [scvback mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self);
        make.width.offset(kMainScreenW);
    }];
    
    ////
    UIView *viewUserInfo = [[UIView alloc] init];
    [scvback addSubview:viewUserInfo];
    [viewUserInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(scvback);
        make.width.offset(kMainScreenW);
        make.height.offset(40+60*kScale);
    }];
    [self drawUserInfo:viewUserInfo];
    
    ///
    UIView *vieworderstate = [[UIView alloc] init];
    [scvback addSubview:vieworderstate];
    [vieworderstate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(viewUserInfo);
        make.top.equalTo(viewUserInfo.mas_bottom);
    }];
    [self drawOrderState:vieworderstate];
    
    
    ///
    UIView *viewAction = [[UIView alloc] init];
    [scvback addSubview:viewAction];
    [viewAction mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(viewUserInfo);
        make.top.equalTo(vieworderstate.mas_bottom);
    }];
    [self drawNextActionView:viewAction];
    
    
    
    [scvback mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(viewAction.mas_bottom);
    }];
}

////用户信息
-(void)drawUserInfo:(UIView *)view
{
    
    UIImageView *imghead = [[UIImageView alloc] init];
    [imghead setBackgroundColor:[UIColor grayColor]];
    [view addSubview:imghead];
    [imghead mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(20);
        make.top.offset(20);
        make.size.sizeOffset(CGSizeMake(60*kScale, 60*kScale));
    }];
    [imghead.layer setMasksToBounds:YES];
    [imghead.layer setCornerRadius:60*kScale/2.0];
    
    
    UILabel *lbvalue = [[UILabel alloc] init];
    [lbvalue setText:@"187****6416"];
    [lbvalue setTextColor:RGB(30, 30, 30)];
    [lbvalue setTextAlignment:NSTextAlignmentLeft];
    [lbvalue setFont:[UIFont systemFontOfSize:14]];
    [view addSubview:lbvalue];
    [lbvalue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imghead.mas_right).offset(15);
        make.top.bottom.equalTo(imghead);
        make.right.equalTo(view).offset(-20);
    }];
    
    UIView *viewline = [[UIView alloc] init];
    [viewline setBackgroundColor:RGB(234, 234, 234)];
    [view addSubview:viewline];
    [viewline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(view);
        make.height.offset(1);
    }];
    
}

///订单
-(void)drawOrderState:(UIView *)view
{
    UIButton *btall = [[UIButton alloc] init];
    [btall setTitle:@"查看全部>" forState:UIControlStateNormal];
    [btall setTitleColor:RGB(180, 180, 180) forState:UIControlStateNormal];
    [btall.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [view addSubview:btall];
    [btall setTag:10];
    [btall addTarget:self action:@selector(orderItemAction:) forControlEvents:UIControlEventTouchUpInside];
    [btall mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.equalTo(view);
        make.height.offset(30);
        make.width.offset(70);
    }];
    
    
    NSArray *arrimage = @[@"wode_order_daifukuan",@"wode_order_daifahuo",@"wode_order_daishouhuo",@"wode_order_yiwancheng"];
    NSArray *arrname = @[@"待付款",@"待发货",@"待收货",@"已完成"];
    UIButton *btlast;
    for(int i = 0 ; i < arrimage.count; i++)
    {
        UIButton *btitem = [[UIButton alloc] init];
        [btitem setImage:[UIImage imageNamed:arrimage[i]] forState:UIControlStateNormal];
        [btitem setTitle:arrname[i] forState:UIControlStateNormal];
        [btitem setTitleColor:RGB(50, 50, 50) forState:UIControlStateNormal];
        [view addSubview:btitem];
        [btitem mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(kMainScreenW/4.0*i);
            make.top.equalTo(btall.mas_bottom);
            make.width.offset(kMainScreenW/4.0);
            make.height.offset(kMainScreenW/4.0);
        }];
        [btitem setTag:i];
        [btitem addTarget:self action:@selector(orderItemAction:) forControlEvents:UIControlEventTouchUpInside];
        [btitem.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [self drawButtonImageAndtitleSize:btitem];
        btlast = btitem;
    }
    
    
    UIView *viewline = [[UIView alloc] init];
    [viewline setBackgroundColor:RGB(234, 234, 234)];
    [view addSubview:viewline];
    [viewline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(view);
        make.top.equalTo(btlast.mas_bottom);
        make.height.offset(10);
    }];
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(viewline.mas_bottom);
    }];
    
    
    
}
///设置按钮图片上，文字下
-(void)drawButtonImageAndtitleSize:(UIButton *)bt
{
    float imgW = bt.imageView.frame.size.width;
    float imgH = bt.imageView.frame.size.height;
    float lblW = bt.titleLabel.frame.size.width;
    float lblH = bt.titleLabel.frame.size.height;
    float margin = 10;
    bt.imageEdgeInsets = UIEdgeInsetsMake(-lblH-margin/2.0, 0, 0, -lblW);
    bt.titleEdgeInsets = UIEdgeInsetsMake(imgH+margin/2.0, -imgW, 0, 0);
}

////列表功能
-(void)drawNextActionView:(UIView *)view
{
    NSArray *arrtitle = @[@"我的收藏",@"收货地址",@"推荐给好友",@"我的返利",@"优惠券"];
    UIView *viewlast;
    for(int i = 0 ; i < arrtitle.count; i++)
    {
        UIView *viewitem = [[UIView alloc] init];
        [view addSubview:viewitem];
        [viewitem mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(view);
            make.top.offset(55*kScale*i);
            make.height.offset(55*kScale);
        }];
        [self drawNextItemView:viewitem andvalue:arrtitle[i]];
        viewlast = viewitem;
        [viewitem setTag:i];
        UITapGestureRecognizer *tapitem = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(itemAction:)];
        [viewitem addGestureRecognizer:tapitem];
    }
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(viewlast.mas_bottom);
    }];
}

-(void)drawNextItemView:(UIView *)view andvalue:(NSString *)strvalue
{
    UILabel *lbvalue = [[UILabel alloc] init];
    [lbvalue setText:strvalue];
    [lbvalue setTextColor:RGB(30, 30, 30)];
    [lbvalue setTextAlignment:NSTextAlignmentLeft];
    [lbvalue setFont:[UIFont systemFontOfSize:15]];
    [view addSubview:lbvalue];
    [lbvalue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(20);
        make.top.bottom.equalTo(view);
        make.width.offset(200);
    }];
    
    
    UIImageView *imgvnext = [[UIImageView alloc] init];
    [imgvnext setImage:[UIImage imageNamed:@"next_next_graw"]];
    [view addSubview:imgvnext];
    [imgvnext mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(view).offset(-15);
        make.size.sizeOffset(CGSizeMake(18, 18));
        make.centerY.equalTo(view);
    }];
    
    UIView *viewline = [[UIView alloc] init];
    [viewline setBackgroundColor:RGB(234, 234, 234)];
    [view addSubview:viewline];
    [viewline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(view);
        make.height.offset(1);
    }];
    
}

#pragma mark - 订单点击
-(void)orderItemAction:(UIButton *)sender
{
    MyOrderMainViewController *mvc = [[MyOrderMainViewController alloc] init];
    switch (sender.tag) {
        case 0:
        {///待付款
            mvc.itype=1;
        }
            break;
        case 1:
        {//待发货
            mvc.itype=2;
        }
            break;
        case 2:
        {//已发货
            mvc.itype=3;
        }
            break;
        case 3:
        {//已完成
            mvc.itype=4;
        }
            break;
        case 10:
        {//全部
            mvc.itype=0;
        }
            break;
        default:
            break;
    }
    [self.viewController.navigationController pushViewController:mvc animated:YES];
}

#pragma mark - 列表点击
-(void)itemAction:(UIGestureRecognizer *)gesture
{
    switch (gesture.view.tag) {
        case 0:
        {
            CollectsTableViewController *cvc = [[CollectsTableViewController alloc] init];
            [self.viewController.navigationController pushViewController:cvc animated:YES];
        }
            break;
        case 1:
        {
            AddressListsViewController *cvc = [[AddressListsViewController alloc] init];
            [self.viewController.navigationController pushViewController:cvc animated:YES];
        }
            break;
        case 2:
        {
            
        }
            break;
        case 3:
        {
            MyFanLiViewController *cvc = [[MyFanLiViewController alloc] init];
            [self.viewController.navigationController pushViewController:cvc animated:YES];
        }
            break;
        case 4:
        {
            MyYouHuiQuanViewController *cvc = [[MyYouHuiQuanViewController alloc] init];
            [self.viewController.navigationController pushViewController:cvc animated:YES];
        }
            break;
        default:
            break;
    }
}

@end
