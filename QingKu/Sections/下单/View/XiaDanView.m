//
//  XiaDanView.m
//  QingKu
//
//  Created by mdb-losaic on 2019/7/30.
//  Copyright © 2019 mcxzfa. All rights reserved.
//

#import "XiaDanView.h"

#import "XiaDanGoodsView.h"

@interface XiaDanView ()
{
    UIScrollView *scvback;
    ///地址
    UIView *viewaddress;
    
}
@end

@implementation XiaDanView

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
    [scvback setBackgroundColor:RGB(241,241,241)];
    [self addSubview:scvback];
    [scvback mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self);
        make.bottom.equalTo(self).offset(-60);
        make.width.offset(kMainScreenW);
    }];
    
    
    ////
    UIView *viewaddress = [self drawAddress:CGRectMake(0, 0, kMainScreenW, 100) andvalue:nil];
    [scvback addSubview:viewaddress];
    
    ////
    XiaDanGoodsView *viewGoodsMessage = [[XiaDanGoodsView alloc] initWithFrame:CGRectMake(0, viewaddress.bottom+10, viewaddress.width, 202)];
    [scvback addSubview:viewGoodsMessage];
    
    ///
    UIView *viewmoney = [self drawMoneyView:CGRectMake(0, viewGoodsMessage.bottom+10, viewGoodsMessage.width, 100) andmoney:@"255.00" andyunfei:@"6.00"];
    [scvback addSubview:viewmoney];
    
    ///
    UIView *viewyouhui = [self drawYouHuis:CGRectMake(0, viewmoney.bottom+10, viewmoney.width, 100) andyhu:@"5.00" andyfq:@"6.00"];
    [scvback addSubview:viewyouhui];
    
    [scvback setContentSize:CGSizeMake(0, viewyouhui.bottom)];
    
    UIView *viewbottom = [self drawbottom:CGRectMake(0, scvback.bottom, viewaddress.width, 60)];
    [self addSubview:viewbottom];
    [viewbottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self);
        make.height.offset(60);
    }];
}

#pragma mark - 地址信息 AddressListModel
-(UIView *)drawAddress:(CGRect)rect andvalue:(id)value
{
    UIView *view = [[UIView alloc] initWithFrame:rect];
    [view setBackgroundColor:[UIColor whiteColor]];
    [view setUserInteractionEnabled:YES];
    
    
    if(value == nil)
    {
        UIImageView *imgvadd = [[UIImageView alloc] initWithFrame:CGRectMake(15, 17, 15, 15)];
        [imgvadd setImage:[UIImage imageNamed:@"dingdan_address"]];
        [view addSubview:imgvadd];
        
        UILabel *lbtext = [[UILabel alloc] initWithFrame:CGRectMake(imgvadd.right+8, imgvadd.top-5, 150, 25)];
        [lbtext setText:@"添加收货地址"];
        [lbtext setTextColor:RGB(102,102,102)];
        [lbtext setTextAlignment:NSTextAlignmentLeft];
        [lbtext setFont:[UIFont systemFontOfSize:14]];
        [view addSubview:lbtext];
        
        
        
        [view setHeight:49];
    }
    else
    {
        
        UILabel *lbtext = [[UILabel alloc] initWithFrame:CGRectMake(12, 17, view.width-60, 18)];
//        [lbtext setText:[NSString stringWithFormat:@"%@，%@",value.strname,value.strphone]];
        [lbtext setTextColor:RGB(102,102,102)];
        [lbtext setTextAlignment:NSTextAlignmentLeft];
        [lbtext setFont:[UIFont systemFontOfSize:14]];
        [view addSubview:lbtext];
        
        UILabel *lbtext1 = [[UILabel alloc] initWithFrame:CGRectMake(lbtext.left, lbtext.bottom, lbtext.width, 25)];
//        [lbtext1 setText:value.straddress];
        [lbtext1 setTextColor:RGB(102,102,102)];
        [lbtext1 setTextAlignment:NSTextAlignmentLeft];
        [lbtext1 setFont:[UIFont systemFontOfSize:14]];
        [lbtext1 setNumberOfLines:2];
        [lbtext1 sizeToFit];
        [view addSubview:lbtext1];
        [view setHeight:lbtext1.bottom+17];
        
        
    }
    
    UIImageView *imgvnext= [[UIImageView alloc] initWithFrame:CGRectMake(view.width-25, 15, 15, 15)];
    [imgvnext setImage:[UIImage imageNamed:@"next_next_graw"]];
    [imgvnext setCenter:CGPointMake(0, view.height/2.0)];
    [imgvnext setRight:view.width-10];
    [view addSubview:imgvnext];
    
    UIView *viewlin = [[UIView alloc] initWithFrame:CGRectMake(0, view.height-1,view.width , 1)];
    [viewlin setBackgroundColor:RGB(218,218,218)];
    [view addSubview:viewlin];
    
    [view setUserInteractionEnabled:YES];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addressAction)];
    [view addGestureRecognizer:tap];
    
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
    
    NSArray *arrtitle = @[@"商品金额",@"运费（申通快递）"];
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
        if([arrvalue[i] floatValue]<=0)
        {
            [lbyouhuimoney setText:@"暂无可用"];
        }
        else
        {
            [lbyouhuimoney setText:[NSString nullToString:[NSString stringWithFormat:@"￥%@",arrvalue[i]]]];
        }
        
        [lbyouhuimoney setTextColor:RGB(102,102,102)];
        [lbyouhuimoney setTextAlignment:NSTextAlignmentRight];
        [lbyouhuimoney setFont:[UIFont systemFontOfSize:13]];
        [view addSubview:lbyouhuimoney];
        
    }
    [view setHeight:80];
    return view;
}


#pragma mark - 商品优惠
/**
 优惠券模块

 @param rect 大小
 @param stryhqmoney 优惠券金额
 @param stryfqmoney 运费券金额
 @return view
 */
-(UIView *)drawYouHuis:(CGRect)rect andyhu:(NSString *)stryhqmoney andyfq:(NSString *)stryfqmoney
{
    UIView *view = [[UIView alloc] initWithFrame:rect];
    [view setBackgroundColor:[UIColor whiteColor]];
    
    UIView *viewyhq = [self drawGoodsYouHui:CGRectMake(0, 0, view.width, 40) andtitle:@"优惠券" andmoney:@"￥101.00"];
    [view addSubview:viewyhq];
    
    UIView *viewyfq = [self drawGoodsYouHui:CGRectMake(0, 40, view.width, 40) andtitle:@"免邮券" andmoney:@"￥6.00"];
    [view addSubview:viewyfq];
    
    [view setHeight:viewyfq.bottom];
    
    return view;
}
-(UIView *)drawGoodsYouHui:(CGRect)rect andtitle:(NSString *)title andmoney:(NSString *)strmoney
{
    
    UIView *view = [[UIView alloc] initWithFrame:rect];
    [view setBackgroundColor:[UIColor whiteColor]];
    [view setUserInteractionEnabled:YES];
    UITapGestureRecognizer *tapv = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(youhuiAction:)];
    [view addGestureRecognizer:tapv];
    
    UILabel *lbtext = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, view.height)];
    [lbtext setText:title];
    [lbtext setTextColor:RGB(102,102,102)];
    [lbtext setTextAlignment:NSTextAlignmentLeft];
    [lbtext setFont:[UIFont systemFontOfSize:14]];
    [view addSubview:lbtext];
    
    
    UILabel *lbyouhuimoney = [[UILabel alloc] initWithFrame:CGRectMake(view.width-135, 0, 100, view.height)];
    if(strmoney==nil)
    {
        [lbyouhuimoney setText:@"暂无可用"];
    }
    else
    {
        [lbyouhuimoney setText:[NSString nullToString:[NSString stringWithFormat:@"￥%@",strmoney]]];
    }
    
    [lbyouhuimoney setTextColor:RGB(102,102,102)];
    [lbyouhuimoney setTextAlignment:NSTextAlignmentRight];
    [lbyouhuimoney setFont:[UIFont systemFontOfSize:13]];
    [view addSubview:lbyouhuimoney];
    
    
    UIImageView *imgvnext=[[UIImageView alloc] initWithFrame:CGRectMake(lbyouhuimoney.right+5, (view.height-15)/2.0, 15, 15)];
    [imgvnext setImage:[UIImage imageNamed:@"next_next_graw"]];
    [view addSubview:imgvnext];
    
    return view;
}

-(UIView *)drawbottom:(CGRect)rect
{
    UIView *view = [[UIView alloc] initWithFrame:rect];
    [view setBackgroundColor:[UIColor whiteColor]];
    
    UILabel *lbkd = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, view.height)];
    [lbkd setText:@"总计: "];
    [lbkd setTextColor:RGB(51,51,51)];
    [lbkd setTextAlignment:NSTextAlignmentLeft];
    [lbkd setFont:[UIFont systemFontOfSize:15]];
    [lbkd sizeToFit];
    [lbkd setHeight:view.height];
    [view addSubview:lbkd];
    
    UILabel *lbprice = [[UILabel alloc] initWithFrame:CGRectMake(lbkd.right, lbkd.top, 150, lbkd.height)];
    [lbprice setText:@"￥0.0"];
    [lbprice setTextColor:RGB(253,122,14)];
    [lbprice setTextAlignment:NSTextAlignmentLeft];
    [lbprice setFont:[UIFont fontWithName:@"Arial_BlodMT" size:15]];
    [view addSubview:lbprice];
    
    
    
    UIButton *btsend = [[UIButton alloc] initWithFrame:CGRectMake(view.width-120, 0, 120, view.height)];
    [btsend setTitle:@"提交订单" forState:UIControlStateNormal];
    [btsend setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btsend.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [btsend addTarget:self action:@selector(sendAction) forControlEvents:UIControlEventTouchUpInside];
    [btsend setBackgroundColor:RGB(253,122,14)];
    [view addSubview:btsend];
    
    return view;
}


#pragma mark - 添加修改地址
-(void)addressAction
{
    
}

#pragma mark - 优惠券选择
-(void)youhuiAction:(UIGestureRecognizer *)gesture
{
    
}

#pragma mark - 提交订单
-(void)sendAction
{
    
}

@end
