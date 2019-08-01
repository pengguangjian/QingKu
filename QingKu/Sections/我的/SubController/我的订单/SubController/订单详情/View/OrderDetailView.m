//
//  OrderDetailView.m
//  QingKu
//
//  Created by mdb-losaic on 2019/8/1.
//  Copyright © 2019 mcxzfa. All rights reserved.
//

#import "OrderDetailView.h"
#import "TuiKuanDetailViewController.h"
#import "OrderWuLiuDetailViewController.h"

@interface OrderDetailView ()
{
    UIScrollView *scvback;
    
}

@end

@implementation OrderDetailView

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
    scvback = [[UIScrollView alloc] init];
    [self addSubview:scvback];
    [scvback mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self);
        make.width.offset(kMainScreenW);
        make.bottom.equalTo(self).offset(-55*kScale);
    }];
    
    ///
    UIView *viewtop = [self drawtop:CGRectMake(0, 0, kMainScreenW, 100) andtype:1];
    [scvback addSubview:viewtop];
    
    ///
    UIView *viewkdnow = [self drawFast:CGRectMake(0, viewtop.bottom, viewtop.width, 100)];
    [scvback addSubview:viewkdnow];
    
    ///
    UIView *viewaddress = [self drawAddress:CGRectMake(0, viewkdnow.bottom, viewtop.width, 100)];
    [scvback addSubview:viewaddress];
    
    ///
    UIView *viewgoods = [self drawGoodsView:CGRectMake(0, viewaddress.bottom, viewtop.width, 100)];
    [scvback addSubview:viewgoods];
    
    
    ///
    UIView *viewmoney = [self drawMoneyView:CGRectMake(0, viewgoods.bottom, viewtop.width, 100) andmoney:@"299.00" andyunfei:@"6.00"];
    [scvback addSubview:viewmoney];
    
    ///
    UIView *viewkf = [self drawOtherKffu:CGRectMake(0, viewmoney.bottom, viewtop.width, 80)];
    [scvback addSubview:viewkf];
    [scvback mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(viewkf.mas_bottom);
    }];
    
    
    ////
    UIView *viewbottom = [self drawBottom:CGRectMake(0, kMainScreenH-kTopHeight-55*kScale, viewtop.width, 55*kScale) andtype:1];
    [self addSubview:viewbottom];
    
    
}

#pragma mark - 头部订单状态
-(UIView *)drawtop:(CGRect)rect andtype:(int)type
{
    
    UIView *view = [[UIView alloc] initWithFrame:rect];
    [view setBackgroundColor:RGB(248, 248, 248)];
    NSString *strname=@"";
    NSString *strother=@"";
    strname=@"等待买家付款";
    strother=@"10分钟未支付，订单将自动取消";
    
    UILabel *lbname = [[UILabel alloc] initWithFrame:CGRectMake(38, 20, 250, 20)];
    [lbname setText:strname];
    [lbname setTextColor:RGB(30, 30, 30)];
    [lbname setTextAlignment:NSTextAlignmentLeft];
    [lbname setFont:[UIFont systemFontOfSize:14]];
    [view addSubview:lbname];
    if(strother.length > 0)
    {
        UILabel *lbother = [[UILabel alloc] initWithFrame:CGRectMake(lbname.left, lbname.bottom+5, view.width-76, 20)];
        [lbother setText:strother];
        [lbother setTextColor:RGB(30, 30, 30)];
        [lbother setTextAlignment:NSTextAlignmentLeft];
        [lbother setFont:[UIFont systemFontOfSize:12]];
        [lbother setNumberOfLines:2];
        [lbother sizeToFit];
        [view addSubview:lbother];
        
        [view setHeight:lbother.bottom+20];
    }
    else
    {
        [view setHeight:lbname.bottom+20];
    }
    
    UIButton *btleft = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, 150, 46*kScale)];
    [btleft.layer setMasksToBounds:YES];
    [btleft.layer setCornerRadius:6];
    [btleft setBackgroundColor:RadMenuColor];
    [btleft setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btleft setTitle:[NSString stringWithFormat:@"退款详情"] forState:UIControlStateNormal];
    [btleft.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [btleft sizeToFit];
    if(view.height/1.5<46*kScale)
    {
        [btleft setHeight:view.height/1.5];
    }
    else
    {
        [btleft setHeight:46*kScale];
    }
    
    [btleft setWidth:btleft.width+30];
    [btleft setCenterY:view.height/2.0];
    [btleft setRight:view.width-10];
    [view addSubview:btleft];
    [btleft addTarget:self action:@selector(btTuiKuanAction) forControlEvents:UIControlEventTouchUpInside];
    
    return view;
}

#pragma mark - 快递到哪儿了
-(UIView *)drawFast:(CGRect)rect
{
    UIView *view = [[UIView alloc] initWithFrame:rect];
    [view setBackgroundColor:[UIColor whiteColor]];
    [view setUserInteractionEnabled:YES];
    UITapGestureRecognizer *tapview = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(kuaidiWuLiuAction)];
    [view addGestureRecognizer:tapview];
    
    UIImageView *imgvp = [[UIImageView alloc] initWithFrame:CGRectMake(10, 15, 15, 15)];
    [imgvp setImage:[UIImage imageNamed:@"order_details_fast_wuliu"]];
    [view addSubview:imgvp];
    
    UILabel *lbname = [[UILabel alloc] initWithFrame:CGRectMake(imgvp.right+10, imgvp.top, 250, imgvp.height)];
//    [lbname setText:orderModel.logistics];
    [lbname setText:@"快递已到达北京中转站"];
    [lbname setTextColor:RGB(101,177,84)];
    [lbname setTextAlignment:NSTextAlignmentLeft];
    [lbname setFont:[UIFont systemFontOfSize:14]];
    [view addSubview:lbname];
    
    [view setHeight:imgvp.bottom+15];
    
//    UIImageView *imgvnext = [[UIImageView alloc] initWithFrame:CGRectMake(15, 17, 12, 12)];
//    [imgvnext setImage:[UIImage imageNamed:@"green_next"]];
//    [view addSubview:imgvnext];
//    [imgvnext setCenter:CGPointMake(0, view.height/2.0)];
//    [imgvnext setRight:view.width-15];
    
    UIView *viewline = [[UIView alloc] initWithFrame:CGRectMake(0, view.height-1, view.width, 1)];
    [viewline setBackgroundColor:RGB(238,238,238)];
    [view addSubview:viewline];
//    if(orderModel.logistics.length>0)
//    {
//
//    }
//    else
//    {
//        [view setHeight:0];
//        [view setHidden:YES];
//    }
    return view;
}

#pragma mark - 地址信息
-(UIView *)drawAddress:(CGRect)rect
{
    UIView *view = [[UIView alloc] initWithFrame:rect];
    [view setBackgroundColor:[UIColor whiteColor]];
    
    UIImageView *imgvadd = [[UIImageView alloc] initWithFrame:CGRectMake(15, 17, 15, 15)];
    [imgvadd setImage:[UIImage imageNamed:@"dingdan_address"]];
    [view addSubview:imgvadd];
    
    UILabel *lbtext = [[UILabel alloc] initWithFrame:CGRectMake(imgvadd.right+6, 17, view.width-60, 18)];
//    [lbtext setText:[NSString stringWithFormat:@"%@，%@",orderModel.truename,orderModel.mobile]];
    [lbtext setText:@"张三 15525456632"];
    [lbtext setTextColor:RGB(50,50,50)];
    [lbtext setTextAlignment:NSTextAlignmentLeft];
    [lbtext setFont:[UIFont systemFontOfSize:14]];
    [view addSubview:lbtext];
    
    UILabel *lbtext1 = [[UILabel alloc] initWithFrame:CGRectMake(lbtext.left, lbtext.bottom, lbtext.width, 25)];
    [lbtext1 setText:@"北京快递费加阿萨德付款了时代峻峰了斯柯达"];
    [lbtext1 setTextColor:RGB(50,50,50)];
    [lbtext1 setTextAlignment:NSTextAlignmentLeft];
    [lbtext1 setFont:[UIFont systemFontOfSize:14]];
    [lbtext1 setNumberOfLines:2];
    [lbtext1 sizeToFit];
    [view addSubview:lbtext1];
    [view setHeight:lbtext1.bottom+17];
    
    
    [imgvadd setCenterY:view.height/2.0];
    
    UIView *viewlin = [[UIView alloc] initWithFrame:CGRectMake(0, view.height-1,view.width , 1)];
    [viewlin setBackgroundColor:RGB(238,238,238)];
    [view addSubview:viewlin];
    
    
    return view;
}

#pragma mark - ///商品信息
-(UIView *)drawGoodsView:(CGRect)rect
{
    UIView *view = [[UIView alloc] initWithFrame:rect];
    [view setBackgroundColor:[UIColor whiteColor]];
    
    float flast = 0;
    for(int i = 0 ; i < 2; i++)
    {
        UIView *viewitem = [self drawgoodsInfo:nil andframe:CGRectMake(0, flast, view.width, 100)];
        [view addSubview:viewitem];
        [viewitem setTag:i];
        flast = viewitem.bottom;
    }
    
    UIView *viewlin = [[UIView alloc] initWithFrame:CGRectMake(0, flast,view.width , 10)];
    [viewlin setBackgroundColor:RGB(242,242,242)];
    [view addSubview:viewlin];
    
    
    [view setHeight:viewlin.bottom];
    
    return view;
}
///商品信息
-(UIView *)drawgoodsInfo:(id)model andframe:(CGRect)rect
{
    UIView *view = [[UIView alloc] initWithFrame:rect];
    [view setBackgroundColor:[UIColor whiteColor]];
    
    UIImageView *imgvhead = [[UIImageView alloc] initWithFrame:CGRectMake(10, 17, 71, 71)];
    [imgvhead.layer setMasksToBounds:YES];
    [imgvhead.layer setCornerRadius:4];
    [imgvhead setContentMode:UIViewContentModeScaleAspectFit];
//    [[MDB_UserDefault defaultInstance] setViewWithImage:imgvhead url:model.image];
    [imgvhead setBackgroundColor:[UIColor grayColor]];
    [view addSubview:imgvhead];
    [imgvhead setUserInteractionEnabled:YES];
    UITapGestureRecognizer *taphead = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goodsAction:)];
    [imgvhead addGestureRecognizer:taphead];
    [imgvhead setContentMode:UIViewContentModeScaleAspectFit];
    
    UILabel *lbtitle = [[UILabel alloc] initWithFrame:CGRectMake(imgvhead.right+10, imgvhead.top, view.width-imgvhead.right-70, 40)];
    [lbtitle setText:@"商品标题商品标题商品标题商品标题商品标题"];
    [lbtitle setTextColor:RGB(102,102,102)];
    [lbtitle setTextAlignment:NSTextAlignmentLeft];
    [lbtitle setFont:[UIFont systemFontOfSize:13]];
    [lbtitle setNumberOfLines:3];
    [view addSubview:lbtitle];
    [lbtitle setUserInteractionEnabled:YES];
    UITapGestureRecognizer *taptitle = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goodsAction:)];
    [lbtitle addGestureRecognizer:taptitle];
    
    UILabel *lbprice = [[UILabel alloc] initWithFrame:CGRectMake(lbtitle.left, lbtitle.bottom, 200, 20)];
    [lbprice setText:@"￥299.00"];
    [lbprice setTextColor:RGB(243,93,0)];
    [lbprice setTextAlignment:NSTextAlignmentLeft];
    [lbprice setFont:[UIFont systemFontOfSize:13]];
    [view addSubview:lbprice];
    
    ///颜色尺码
    UILabel *lbcmcolor = [[UILabel alloc] initWithFrame:CGRectMake(imgvhead.left, imgvhead.bottom, view.width-20, 35)];
    [lbcmcolor setText:@"规格规格规格规格"];
    [lbcmcolor setTextColor:RGB(153,153,153)];
    [lbcmcolor setTextAlignment:NSTextAlignmentLeft];
    [lbcmcolor setFont:[UIFont systemFontOfSize:13]];
    [lbcmcolor setNumberOfLines:2];
    [lbcmcolor sizeToFit];
    if(lbcmcolor.height<20)
    {
        [lbcmcolor setHeight:20];
    }
    [view addSubview:lbcmcolor];
    
    [view setHeight:lbcmcolor.bottom+15];
    
    UILabel *lbnumber = [[UILabel alloc] initWithFrame:CGRectMake(lbtitle.right, 0, view.width-lbtitle.right-10, view.height)];
    [lbnumber setText:@"x1"];
    [lbnumber setTextColor:RGB(153,153,153)];
    [lbnumber setTextAlignment:NSTextAlignmentRight];
    [lbnumber setFont:[UIFont systemFontOfSize:12]];
    [view addSubview:lbnumber];
    
    UIView *viewlin = [[UIView alloc] initWithFrame:CGRectMake(0, view.height-1,view.width , 1)];
    [viewlin setBackgroundColor:RGB(238,238,238)];
    [view addSubview:viewlin];
    
    return view;
}

#pragma mark - 商品金额

/**
 商品金额
 
 @param rect
 @param strmoney 商品总价
 @param stryunfei 运费总价
 @return
 */
-(UIView *)drawMoneyView:(CGRect)rect andmoney:(NSString *)strmoney andyunfei:(NSString *)stryunfei
{
    UIView *view = [[UIView alloc] initWithFrame:rect];
    [view setBackgroundColor:[UIColor whiteColor]];
    
    NSArray *arrtitle = @[@"商品金额",@"运费"];
    NSArray *arrvalue = @[strmoney,stryunfei];
    for(int i = 0 ; i<2; i++)
    {
        
        UILabel *lbtext = [[UILabel alloc] initWithFrame:CGRectMake(10, 40*i, 150, 40)];
        [lbtext setText:arrtitle[i]];
        [lbtext setTextColor:RGB(102,102,102)];
        [lbtext setTextAlignment:NSTextAlignmentLeft];
        [lbtext setFont:[UIFont systemFontOfSize:14]];
        [view addSubview:lbtext];
        
        
        UILabel *lbyouhuimoney = [[UILabel alloc] initWithFrame:CGRectMake(view.width-135, lbtext.top, 100, lbtext.height)];
        [lbyouhuimoney setText:[NSString nullToString:[NSString stringWithFormat:@"￥%@",arrvalue[i]]]];
        [lbyouhuimoney setTextColor:RGB(254, 110, 16)];
        [lbyouhuimoney setTextAlignment:NSTextAlignmentRight];
        [lbyouhuimoney setFont:[UIFont systemFontOfSize:13]];
        [view addSubview:lbyouhuimoney];
        
    }
    
    UIView *viewlin = [[UIView alloc] initWithFrame:CGRectMake(0, 80,view.width , 10)];
    [viewlin setBackgroundColor:RGB(242,242,242)];
    [view addSubview:viewlin];
    
    [view setHeight:viewlin.bottom];
    return view;
}

#pragma mark - 联系客服
-(UIView *)drawOtherKffu:(CGRect)rect
{
    UIView *view = [[UIView alloc] initWithFrame:rect];
    [view setBackgroundColor:[UIColor whiteColor]];
    
    UILabel *lbkf = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, view.width-20, view.height)];
    [lbkf setText:@"联系客服：QQ5623612456"];
    [lbkf setTextColor:RGB(102,102,102)];
    [lbkf setTextAlignment:NSTextAlignmentCenter];
    [lbkf setFont:[UIFont systemFontOfSize:14]];
    [view addSubview:lbkf];
    
    return view;
}

#pragma mark - 底部按钮 itype 1/2/3/4
-(UIView *)drawBottom:(CGRect)rect andtype:(int)itype
{
    UIView *view = [[UIView alloc] initWithFrame:rect];
    [view setBackgroundColor:RGB(246, 246, 246)];
    
    UIView *viewlin = [[UIView alloc] initWithFrame:CGRectMake(0, 0,view.width , 1)];
    [viewlin setBackgroundColor:RGB(238,238,238)];
    [view addSubview:viewlin];
    
    UIButton *btright = [[UIButton alloc] initWithFrame:CGRectMake(0, 8, 150, view.height-16)];
    [btright.layer setMasksToBounds:YES];
    [btright.layer setCornerRadius:6];
    [btright setBackgroundColor:RGB(253,122,14)];
    [btright setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btright setTitle:[NSString stringWithFormat:@"¥%@立即支付",@"299"] forState:UIControlStateNormal];
    [btright.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [btright sizeToFit];
    [btright setHeight:view.height-16];
    [btright setWidth:btright.width+30];
    [btright setRight:view.width-10];
    [view addSubview:btright];
    [btright setTag:0];
    [btright addTarget:self action:@selector(bottomAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btleft = [[UIButton alloc] initWithFrame:CGRectMake(0, 8, 150, 46*kScale)];
    [btleft.layer setMasksToBounds:YES];
    [btleft.layer setCornerRadius:6];
    [btleft setBackgroundColor:RGB(156,156,156)];
    [btleft setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btleft setTitle:[NSString stringWithFormat:@"取消订单"] forState:UIControlStateNormal];
    [btleft.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [btleft sizeToFit];
    [btleft setHeight:view.height-16];
    [btleft setWidth:btleft.width+30];
    [btleft setRight:btright.left-10];
    [view addSubview:btleft];
    [btleft setTag:10];
    [btleft addTarget:self action:@selector(bottomAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [view setHeight:btleft.bottom+8];
    
    return view;
}

#pragma mark - 退款详情
-(void)btTuiKuanAction
{
    TuiKuanDetailViewController *tvc = [[TuiKuanDetailViewController alloc] init];
    [self.viewController.navigationController pushViewController:tvc animated:YES];
    
}
#pragma mark - 查看物流
-(void)kuaidiWuLiuAction
{
    OrderWuLiuDetailViewController *dvc = [[OrderWuLiuDetailViewController alloc] init];
    [self.viewController.navigationController pushViewController:dvc animated:YES];
}
#pragma mark - 商品点击
-(void)goodsAction:(UIGestureRecognizer *)gesture
{
    
}
#pragma mark - 底部按钮点击
-(void)bottomAction:(UIButton *)sender
{
    
}

@end
