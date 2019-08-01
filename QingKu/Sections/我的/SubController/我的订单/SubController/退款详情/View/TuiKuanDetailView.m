//
//  TuiKuanDetailView.m
//  QingKu
//
//  Created by mdb-losaic on 2019/8/1.
//  Copyright © 2019 mcxzfa. All rights reserved.
//

#import "TuiKuanDetailView.h"

@implementation TuiKuanDetailView

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
    [self addSubview:scvback];
    [scvback mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self);
        make.width.offset(kMainScreenW);
        make.bottom.equalTo(self);
    }];
    
    ///
    UIView *viewtop = [self drawtop:CGRectMake(0, 0, kMainScreenW, 100) andtype:1];
    [scvback addSubview:viewtop];
    
    ///
    UIView *viewtkmoney = [self drawTKMoney:CGRectMake(0, viewtop.bottom, viewtop.width, 100) andisone:YES];
    [scvback addSubview:viewtkmoney];
    
    ///
    NSDictionary *dicvalue = @{@"cancel_reason":@"退款原因",@"amount":@"20.00",@"batch_no":@"4587545654564123"};
    UIView *viewtk = [self drawTuiKuanInfo:CGRectMake(0, viewtkmoney.bottom, viewtop.width, 100) andisone:YES andvalue:dicvalue];
    [scvback addSubview: viewtk];
    
    ///
    UIView *viewbotom = [self drawordermessage:CGRectMake(0, viewtk.bottom, viewtop.width, 100)];
    [scvback addSubview:viewbotom];
    
    [scvback mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(viewbotom.mas_bottom);
    }];
    
    
    
    
}


#pragma mark - 头部订单状态 type 1显示2行 其他1行
-(UIView *)drawtop:(CGRect)rect andtype:(int)type
{
    UIView *view = [[UIView alloc] initWithFrame:rect];
    [view setBackgroundColor:RGB(248, 248, 248)];
    
    UILabel *lbname = [[UILabel alloc] initWithFrame:CGRectMake(38, 20, 250, 20)];
    [lbname setText:@"退款中"];
    [lbname setTextColor:RGB(30,30,30)];
    [lbname setTextAlignment:NSTextAlignmentLeft];
    [lbname setFont:[UIFont systemFontOfSize:14]];
    [view addSubview:lbname];
    
    
    UILabel *lbother = [[UILabel alloc] initWithFrame:CGRectMake(lbname.left, lbname.bottom+5, 250, 20)];
//    [lbother setText:[MDB_UserDefault strTimefromData:[[dictuikuan objectForKey:@"successtime"] integerValue] dataFormat:@"yyyy.MM.dd HH:mm:ss"]];
    [lbother setText:@"2019.08.01 10:32:20"];
    [lbother setTextColor:RGB(180,180,180)];
    [lbother setTextAlignment:NSTextAlignmentLeft];
    [lbother setFont:[UIFont systemFontOfSize:12]];
    [view addSubview:lbother];
    
    [view setHeight:lbother.bottom+20];
    
    return view;
}

#pragma mark - 退款金额的方式
-(UIView *)drawTKMoney:(CGRect)rect andisone:(BOOL)isone
{
    UIView *view = [[UIView alloc] initWithFrame:rect];
    [view setBackgroundColor:[UIColor whiteColor]];
    
    UILabel *lbname = [[UILabel alloc] initWithFrame:CGRectMake(38, 20, 150, 20)];
    [lbname setText:@"退款金额"];
    [lbname setTextColor:RGB(102,102,102)];
    [lbname setTextAlignment:NSTextAlignmentLeft];
    [lbname setFont:[UIFont systemFontOfSize:12]];
    [view addSubview:lbname];
    
    UILabel *lbvalue = [[UILabel alloc] initWithFrame:CGRectMake(38, lbname.top, 150, lbname.height)];
    [lbvalue setText:@"50.00"];
    [lbvalue setTextColor:RGB(230,56,47)];
    [lbvalue setTextAlignment:NSTextAlignmentRight];
    [lbvalue setFont:[UIFont systemFontOfSize:12]];
    [lbvalue setRight:view.width-38];
    [view addSubview:lbvalue];
    
    UILabel *lbname1 = [[UILabel alloc] initWithFrame:CGRectMake(lbname.left, lbname.bottom+8, 150, 20)];
    [lbname1 setText:@"退款方式"];
    [lbname1 setTextColor:RGB(102,102,102)];
    [lbname1 setTextAlignment:NSTextAlignmentLeft];
    [lbname1 setFont:[UIFont systemFontOfSize:12]];
    [view addSubview:lbname1];
    
    UILabel *lbvalue1 = [[UILabel alloc] initWithFrame:CGRectMake(38, lbname1.top, 150, lbname1.height)];
    [lbvalue1 setText:@"原路退回"];
    [lbvalue1 setTextColor:RGB(102,102,102)];
    [lbvalue1 setTextAlignment:NSTextAlignmentRight];
    [lbvalue1 setFont:[UIFont systemFontOfSize:12]];
    [lbvalue1 setRight:view.width-38];
    [view addSubview:lbvalue1];
    
    
    UIView *viewline = [[UIView alloc] initWithFrame:CGRectMake(0, lbname1.bottom+20, view.width, 1)];
    [viewline setBackgroundColor:RGB(238,238,238)];
    [view addSubview:viewline];

    
    UIView *viewline1 = [[UIView alloc] initWithFrame:CGRectMake(0, viewline.bottom, view.width, 10)];
    [viewline1 setBackgroundColor:RGB(244,244,244)];
    [view addSubview:viewline1];
    
    [view setHeight:viewline1.bottom];
    
    return view;
}

#pragma mark - 退款信息
-(UIView *)drawTuiKuanInfo:(CGRect )rect andisone:(BOOL)isone andvalue:(NSDictionary *)dicvalue
{
    UIView *view = [[UIView alloc] initWithFrame:rect];
    [view setBackgroundColor:RGB(248, 248, 248)];
    
    
    
    UIView *vieworder = [[UIView alloc] initWithFrame:CGRectMake(0, 5, view.width, 100)];
    [vieworder setBackgroundColor:RGB(248,248,248)];
    [view addSubview:vieworder];
    NSString *stryuany = [dicvalue objectForKey:@"cancel_reason"];
    if(stryuany.length<1){
        stryuany = @"无";
    }
    NSMutableArray *arrvalue = [NSMutableArray arrayWithObjects:
                                [NSString stringWithFormat:@"退款原因：%@",stryuany],nil];
    if([[NSString nullToString:[dicvalue objectForKey:@"amount"]] floatValue]>0)
    {
        [arrvalue addObject: [NSString stringWithFormat:@"退款金额：¥%@",[NSString nullToString:[dicvalue objectForKey:@"amount"]]]];
    }
    if(isone)
    {
        if([[NSString nullToString:[dicvalue objectForKey:@"batch_no"]] length]>0)
        {
            [arrvalue addObject: [NSString stringWithFormat:@"退款编号：%@",[NSString nullToString:[dicvalue objectForKey:@"batch_no"]]]];
        }
    }
    
    if(dicvalue == nil)
    {
        arrvalue = [NSMutableArray arrayWithObjects:
                    [NSString stringWithFormat:@"退款原因：%@",stryuany],nil];
    }
    
//    if([[NSString nullToString:[dicvalue objectForKey:@"re_status"]] length]>0)
//    {
//        [arrvalue addObject:[NSString stringWithFormat:@"退款状态：%@",[NSString nullToString:[dicvalue objectForKey:@"re_status"]]]];
//    }
//    else
//    {
//        [arrvalue addObject:[NSString stringWithFormat:@"退款状态：%@",@"退款失败，请联系客服"]];
//    }
    
    float fbottom = 0.0;
    for(int i = 0 ; i < arrvalue.count; i++)
    {
        UILabel *lb = [self draworderlb:CGRectMake(20, 5+20*i, vieworder.width-40, 20) andvalue:arrvalue[i]];
        [vieworder addSubview:lb];
        fbottom = lb.bottom+5;
    }
    [vieworder setHeight:fbottom+5];
    
    [view setHeight:vieworder.bottom];
    
    return view;
}
-(UILabel *)draworderlb:(CGRect)rect andvalue:(NSString *)strvalue
{
    UILabel *lbname = [[UILabel alloc] initWithFrame:rect];
    [lbname setText:strvalue];
    [lbname setTextColor:RGB(153,153,153)];
    [lbname setTextAlignment:NSTextAlignmentLeft];
    [lbname setFont:[UIFont systemFontOfSize:12]];
    [lbname setNumberOfLines:0];
    [lbname sizeToFit];
    if(lbname.height<20)
    {
        [lbname setHeight:20];
    }
    
    
    return lbname;
}

#pragma mark - 订单信息
-(UIView *)drawordermessage:(CGRect)rect
{
    UIView *view = [[UIView alloc] initWithFrame:rect];
    [view setBackgroundColor:RGB(255,255,255)];
    
    UILabel *lbname = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, view.width-20, 75)];
    [lbname setText:[NSString stringWithFormat:@"联系没得比客服：QQ %@",@"56418915498"]];
    [lbname setTextColor:RGB(102,102,102)];
    [lbname setTextAlignment:NSTextAlignmentCenter];
    [lbname setFont:[UIFont systemFontOfSize:12]];
    [lbname setBackgroundColor:[UIColor whiteColor]];
    [view addSubview:lbname];
    [lbname setUserInteractionEnabled:YES];
//    UITapGestureRecognizer *tapname = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(QQAction)];
//    [lbname addGestureRecognizer:tapname];
    
    [view setHeight:lbname.bottom];
    
    return view;
}

@end
