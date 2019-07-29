//
//  GoodsDetailView.m
//  QingKu
//
//  Created by mdb-losaic on 2019/7/29.
//  Copyright © 2019 mcxzfa. All rights reserved.
//

#import "GoodsDetailView.h"

#import "MDBwebVIew.h"

@interface GoodsDetailView ()<MDBwebDelegate>
{
    UIScrollView *scvback;
    
    MDBwebVIew *webview;
    
}
@end

@implementation GoodsDetailView

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
        make.bottom.equalTo(self).offset(-55*kScale);
        make.top.equalTo(self);
        make.left.offset(0);
        make.width.offset(kMainScreenW);
    }];
    
    
    ///图片
    UIImageView *viewhead = [[UIImageView alloc] init];
    [viewhead setContentMode:UIViewContentModeScaleAspectFit];
    [viewhead setBackgroundColor:[UIColor grayColor]];
    [scvback addSubview:viewhead];
    [viewhead mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self->scvback);
        make.width.offset(kMainScreenW);
        make.height.offset(180*kScale);
    }];
    
    
    ///
    UIView *viewgoodsinfo = [[UIView alloc] init];
    [viewgoodsinfo setBackgroundColor:[UIColor whiteColor]];
    [scvback addSubview:viewgoodsinfo];
    [viewgoodsinfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(viewhead);
        make.top.equalTo(viewhead.mas_bottom);
    }];
    [self drawGoodsInfo:viewgoodsinfo];
    
    
    
    ////商品详情介绍
    UIView *viewdetail = [[UIView alloc] init];
    [viewdetail setBackgroundColor:[UIColor whiteColor]];
    [scvback addSubview:viewdetail];
    [viewdetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(viewgoodsinfo);
        make.top.equalTo(viewgoodsinfo.mas_bottom);
    }];
    [self drawDetailView:viewdetail];
    
    
    [scvback mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(viewdetail.mas_bottom).offset(20);
    }];
    
//    [scvback setContentSize:CGSizeMake(0, 1500)];
    
    UIView *viewbottom = [[UIView alloc] init];
    [viewbottom setBackgroundColor:RGB(246, 246, 246)];
    [self addSubview:viewbottom];
    [viewbottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(viewdetail);
        make.top.equalTo(self->scvback.mas_bottom);
        make.height.offset(55*kScale);
    }];
    [self drawBottomView:viewbottom];
    
}
////价格标题等
-(void)drawGoodsInfo:(UIView *)view
{
    UIView *viewline = [[UIView alloc] init];
    [viewline setBackgroundColor:RGB(240, 240, 240)];
    [view addSubview:viewline];
    [viewline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(view);
        make.height.offset(1);
    }];
    ///标题
    UILabel *lbtitle = [[UILabel alloc] init];
    [lbtitle setText:@"商品标题商品标题商品标题商品标题商品标题商品标题商品标题商品标题"];
    [lbtitle setTextColor:RGB(30, 30, 30)];
    [lbtitle setTextAlignment:NSTextAlignmentLeft];
    [lbtitle setNumberOfLines:2];
    [lbtitle setFont:[UIFont systemFontOfSize:15]];
    [view addSubview:lbtitle];
    [lbtitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.right.equalTo(view).offset(-15);
        make.top.offset(10);
    }];
    //价格
    UILabel *lbprice = [[UILabel alloc] init];
    [lbprice setText:@"￥126.00"];
    [lbprice setTextColor:RGB(255, 93, 0)];
    [lbprice setTextAlignment:NSTextAlignmentLeft];
    [lbprice setFont:[UIFont systemFontOfSize:15]];
    [view addSubview:lbprice];
    [lbprice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbtitle.mas_bottom).offset(10);
        make.left.equalTo(lbtitle);
    }];
    ///原价
    UILabel *lblastprice = [[UILabel alloc] init];
    [lblastprice setText:@"原价：￥126.00"];
    [lblastprice setTextColor:RGB(150, 150, 150)];
    [lblastprice setTextAlignment:NSTextAlignmentLeft];
    [lblastprice setFont:[UIFont systemFontOfSize:14]];
    [view addSubview:lblastprice];
    [lblastprice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbprice);
        make.left.equalTo(lbprice.mas_right).offset(10);
        make.bottom.equalTo(lbprice);
    }];
    
    ///已售多少件
    UILabel *lbsellnum = [[UILabel alloc] init];
    [lbsellnum setText:@"已售100件"];
    [lbsellnum setTextColor:RGB(150, 150, 150)];
    [lbsellnum setTextAlignment:NSTextAlignmentRight];
    [lbsellnum setFont:[UIFont systemFontOfSize:14]];
    [view addSubview:lbsellnum];
    [lbsellnum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbprice);
        make.right.equalTo(view.mas_right).offset(-15);
        make.bottom.equalTo(lbprice);
    }];
    
    
    ////其他信息
    UILabel *lbotherinfo = [[UILabel alloc] init];
    [lbotherinfo setText:@"全场￥99.00包邮   48小时发货"];
    [lbotherinfo setTextColor:RGB(150, 150, 150)];
    [lbotherinfo setTextAlignment:NSTextAlignmentLeft];
    [lbotherinfo setFont:[UIFont systemFontOfSize:14]];
    [view addSubview:lbotherinfo];
    [lbotherinfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbprice.mas_bottom).offset(10);
        make.left.equalTo(lbprice);
    }];
    
    
    ///首单0元购
    UILabel *lbnullbuy = [[UILabel alloc] init];
    [lbnullbuy setText:@"首单“0”元购"];
    [lbnullbuy setTextColor:[UIColor whiteColor]];
    [lbnullbuy setTextAlignment:NSTextAlignmentCenter];
    [lbnullbuy setBackgroundColor:[UIColor redColor]];
    [lbnullbuy setFont:[UIFont systemFontOfSize:14]];
    [lbnullbuy.layer setMasksToBounds:YES];
    [lbnullbuy.layer setCornerRadius:2];
    [view addSubview:lbnullbuy];
    [lbnullbuy mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(lbotherinfo);
        make.right.equalTo(view).offset(-15);
        make.height.offset(22);
        make.width.offset(95);
    }];
    
    UIView *viewline1 = [[UIView alloc] init];
    [viewline1 setBackgroundColor:RGB(240, 240, 240)];
    [view addSubview:viewline1];
    [viewline1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(view);
        make.height.offset(1);
        make.top.equalTo(lbotherinfo.mas_bottom).offset(20);
    }];
    
    UIView *viewline2 = [[UIView alloc] init];
    [viewline2 setBackgroundColor:RGB(245, 245, 245)];
    [view addSubview:viewline2];
    [viewline2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(view);
        make.height.offset(10);
        make.top.equalTo(viewline1.mas_bottom);
    }];
    
    UIView *viewline3 = [[UIView alloc] init];
    [viewline3 setBackgroundColor:RGB(240, 240, 240)];
    [view addSubview:viewline3];
    [viewline3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(view);
        make.height.offset(1);
        make.top.equalTo(viewline2.mas_bottom);
    }];
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(viewline3.mas_bottom);
    }];
    
}

////商品详情
-(void)drawDetailView:(UIView *)view
{
    UILabel *lbshangxingqing = [[UILabel alloc] init];
    [lbshangxingqing setText:@"商品详情："];
    [lbshangxingqing setTextColor:RGB(30, 30, 30)];
    [lbshangxingqing setTextAlignment:NSTextAlignmentLeft];
    [lbshangxingqing setFont:[UIFont systemFontOfSize:14]];
    [view addSubview:lbshangxingqing];
    [lbshangxingqing mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(20);
        make.left.offset(15);
    }];
    
    webview = [[MDBwebVIew alloc] init];
//    [webview setDelegate:self];
    [view addSubview:webview];
    [webview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(view);
        make.top.equalTo(lbshangxingqing.mas_bottom).offset(10);
        make.height.offset(1000);
    }];
    [webview loadWebByURL:@"https://www.baidu.com/"];
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self->webview.mas_bottom);
    }];
    
}

-(void)drawBottomView:(UIView *)view
{
    UIButton *btcollect = [[UIButton alloc] init];
    [btcollect setTitle:@"收藏" forState:UIControlStateNormal];
    [btcollect setTitleColor:RGB(120, 120, 120) forState:UIControlStateNormal];
    [btcollect.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [btcollect setImage:[UIImage imageNamed:@"discount_collect_normal"] forState:UIControlStateNormal];
    [view addSubview:btcollect];
    [btcollect mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.top.bottom.equalTo(view);
        make.width.equalTo(view.mas_height);
    }];
    [self drawButtonImageAndtitleSize:btcollect];
    
    
    ////
    UIButton *btbuy = [[UIButton alloc] init];
    [btbuy setTitle:@"立即购买" forState:UIControlStateNormal];
    [btbuy setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    [btbuy.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [btbuy setBackgroundColor:RGB(254, 110, 17)];
    [btbuy.layer setMasksToBounds:YES];
    [btbuy.layer setCornerRadius:2];
    [view addSubview:btbuy];
    [btbuy mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(8);
        make.right.equalTo(view).offset(-15);
        make.bottom.equalTo(view).offset(-8);
        make.width.offset(100);
    }];
    
    UIButton *btaddcar = [[UIButton alloc] init];
    [btaddcar setTitle:@"加入购物车" forState:UIControlStateNormal];
    [btaddcar setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    [btaddcar.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [btaddcar setBackgroundColor:RGB(9, 186, 104)];
    [btaddcar.layer setMasksToBounds:YES];
    [btaddcar.layer setCornerRadius:2];
    [view addSubview:btaddcar];
    [btaddcar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.width.equalTo(btbuy);
        make.right.equalTo(btbuy.mas_left).offset(-10);
        
    }];
    
    
}
///设置按钮图片上，文字下
-(void)drawButtonImageAndtitleSize:(UIButton *)bt
{
    float imgW = bt.imageView.frame.size.width;
    float imgH = bt.imageView.frame.size.height;
    float lblW = bt.titleLabel.frame.size.width;
    float lblH = bt.titleLabel.frame.size.height;
    float margin = 5;
    bt.imageEdgeInsets = UIEdgeInsetsMake(-lblH-margin/2.0, 0, 0, -lblW);
    bt.titleEdgeInsets = UIEdgeInsetsMake(imgH+margin/2.0, -imgW, 0, 0);
}


#pragma mark - MDBwebDelegate
-(void)webViewDidFinishLoad:(float)h webview:(MDBwebVIew *)webView
{
    [webview mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.offset(h);
    }];
    
    
    
}
-(void)webViewDidPreseeUrlWithLink:(NSString *)link webview:(MDBwebVIew *)webView
{
    
}

@end
