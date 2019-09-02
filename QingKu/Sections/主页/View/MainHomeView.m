//
//  MainHomeView.m
//  QingKu
//
//  Created by 彭光静 on 2019/9/1.
//  Copyright © 2019 mcxzfa. All rights reserved.
//

#import "MainHomeView.h"

#import "MainHomeBangDingTiShiView.h"

#import "SetPayPasswordViewController.h"
#import "SetViewController.h"
#import "UserInfoViewController.h"

#import "FuKuanMaViewController.h"
#import "YuEChaXunViewController.h"
#import "QianBaoViewController.h"
#import "ChongZhiViewController.h"

@interface MainHomeView ()
{
    ///余额
    UILabel *lbyueMoney;
    
}
@end

@implementation MainHomeView

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
        make.top.equalTo(self);
        make.left.offset(0);
        make.width.offset(kMainScreenW);
        make.bottom.equalTo(self);
    }];
    
    UIView *viewScrooView = [[UIView alloc] init];
    [viewScrooView setBackgroundColor:[UIColor grayColor]];
    [scvback addSubview:viewScrooView];
    [viewScrooView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(scvback);
        make.width.offset(kMainScreenW);
        make.height.offset(150*kScale);
    }];
    
    ///
    UIImageView *imgvbc = [[UIImageView alloc] init];
    [imgvbc setUserInteractionEnabled:YES];
    UIImage *image = [UIImage imageNamed:@"home_back_image"];
    [imgvbc setImage:image];
    [scvback addSubview:imgvbc];
    [imgvbc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(viewScrooView);
        make.top.equalTo(viewScrooView.mas_bottom);
        make.height.offset(kMainScreenW*image.size.height/image.size.width);
    }];
    [self drawcenterView:imgvbc];
    
    ///
    [self drawTiShiView:imgvbc];
    
    ///
    UIImageView *imgvbc01 = [[UIImageView alloc] init];
    [imgvbc01 setImage:[UIImage imageNamed:@"home_back_color"]];
    [imgvbc01 setContentMode:UIViewContentModeScaleToFill];
    [imgvbc01 setUserInteractionEnabled:YES];
    [scvback addSubview:imgvbc01];
    [imgvbc01 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(imgvbc);
        make.top.equalTo(imgvbc.mas_bottom);
        make.bottom.equalTo(self);
    }];
    [self drawFunctionView:imgvbc01];
    
    
}
///余额
-(void)drawcenterView:(UIImageView *)view
{
    UILabel *lbmmk = [[UILabel alloc] init];
    [lbmmk setText:@"MMK"];
    lbmmk.lee_theme.LeeConfigTextColor(@"main_homemoney_color");
    [lbmmk setTextAlignment:NSTextAlignmentLeft];
    [lbmmk setFont:[UIFont systemFontOfSize:25]];
    [view addSubview:lbmmk];
    [lbmmk mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.top.offset(45*kScale);
        make.height.offset(25);
    }];
    
    UIButton *btchakan = [[UIButton alloc] init];
    [btchakan addTarget:self action:@selector(chakanAction:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btchakan];
    [btchakan mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lbmmk.mas_right);
        make.top.bottom.equalTo(lbmmk);
        make.width.offset(40);
    }];
    UIImageView *imgvchakan = [[UIImageView alloc] init];
    [imgvchakan setImage:[UIImage imageNamed:@"home_chakan_yan"]];
    [imgvchakan setContentMode:UIViewContentModeScaleAspectFit];
    [imgvchakan setTag:100];
    [btchakan addSubview:imgvchakan];
    [imgvchakan mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.sizeOffset(CGSizeMake(25*kScale, 25*kScale));
        make.center.equalTo(btchakan);
    }];
    
    UILabel *lbyue = [[UILabel alloc] init];
    [lbyue setText:@"0.00"];
    lbyue.lee_theme.LeeConfigTextColor(@"main_write_color");
    [lbyue setTextAlignment:NSTextAlignmentLeft];
    [lbyue setFont:[UIFont systemFontOfSize:35]];
    [view addSubview:lbyue];
    [lbyue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lbmmk);
        make.top.equalTo(lbmmk.mas_bottom);
        make.width.offset(200);
    }];
    lbyueMoney = lbyue;
    
}

-(void)drawTiShiView:(UIImageView *)view
{
    UIView *viewtishi = [[UIView alloc] init];
    viewtishi.lee_theme.LeeConfigBackgroundColor(@"main_homenav_color");
    [view addSubview:viewtishi];
    [viewtishi mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(view);
        make.height.offset(30*kScale);
    }];
    [viewtishi setUserInteractionEnabled:YES];
    UITapGestureRecognizer *tapview = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tishiAction)];
    [viewtishi addGestureRecognizer:tapview];
    
    UILabel *lbtishi = [[UILabel alloc] init];
    [lbtishi setText:[MDB_UserDefault getSetStringNmae:@"homeshimingrengzhengtishi"]];
    lbtishi.lee_theme.LeeConfigTextColor(@"main_hometishi_color");
    [lbtishi setTextAlignment:NSTextAlignmentLeft];
    [lbtishi setFont:[UIFont systemFontOfSize:13]];
    [viewtishi addSubview:lbtishi];
    [lbtishi mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.top.bottom.equalTo(viewtishi);
    }];
    
    UIImageView *imgvnext = [[UIImageView alloc] init];
    [imgvnext setImage:[UIImage imageNamed:@"next_right_whrite"]];
    [viewtishi addSubview:imgvnext];
    [imgvnext mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(viewtishi).offset(-15);
        make.centerY.equalTo(viewtishi);
        make.size.sizeOffset(CGSizeMake(15, 15));
    }];
    
}

///功能
-(void)drawFunctionView:(UIImageView *)view
{
    
    NSArray *arrimages = @[@"home_kaitongzhanghu",@"home_shezhi",@"home_wode"];
    NSArray *arrnames = @[[MDB_UserDefault getSetStringNmae:@"kaitongzhenghu"],
                          [MDB_UserDefault getSetStringNmae:@"shezhi"],
                          [MDB_UserDefault getSetStringNmae:@"wode"]];
    
    arrimages = @[@"home_fukuanma",@"home_yuechaxun",@"home_qianbao",@"home_chongzhi",@"home_shezhi",@"home_wode"];
    arrnames = @[[MDB_UserDefault getSetStringNmae:@"fukuanma"],
                 [MDB_UserDefault getSetStringNmae:@"yuechaxun"],
                 [MDB_UserDefault getSetStringNmae:@"qianbao"],
                 [MDB_UserDefault getSetStringNmae:@"chongzhi"],
                 [MDB_UserDefault getSetStringNmae:@"shezhi"],
                 [MDB_UserDefault getSetStringNmae:@"wode"]];
    
    NSInteger iline = arrnames.count/3;
    float fitemw = kMainScreenW/3.0;
    float fitemh = kMainScreenW/3.0*0.8;
    for(int i = 0 ; i < iline; i++)
    {
        for(int j = 0 ; j < 3; j++)
        {
            UIButton *btitem = [[UIButton alloc] init];
            [btitem setTag:j+i*3];
            [btitem addTarget:self action:@selector(functionAction:) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:btitem];
            [btitem mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.offset(fitemw*j);
                make.top.offset(10+fitemh*i);
                make.size.sizeOffset(CGSizeMake(fitemw, fitemh));
            }];
            
            UIImageView *imgv = [[UIImageView alloc] init];
            [imgv setImage:[UIImage imageNamed:arrimages[j+i*3]]];
            [btitem addSubview:imgv];
            [imgv mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(btitem);
                make.centerY.equalTo(btitem).offset(-10);
                make.size.sizeOffset(CGSizeMake(fitemh*0.5, fitemh*0.5));
            }];
            
            UILabel *lbitem = [[UILabel alloc] init];
            [lbitem setText:arrnames[j+i*3]];
            lbitem.lee_theme.LeeConfigTextColor(@"main_main_color");
            [lbitem setTextAlignment:NSTextAlignmentCenter];
            [lbitem setFont:[UIFont systemFontOfSize:13]];
            [btitem addSubview:lbitem];
            [lbitem mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(imgv.mas_bottom);
                make.left.right.equalTo(btitem);
                make.height.offset(20);
            }];
            
        }
    }
    
    
}

#pragma mark - 隐藏和查看余额
-(void)chakanAction:(UIButton *)sender
{
    UIImageView *imgv = [sender viewWithTag:100];
    [imgv setImage:[UIImage imageNamed:@"home_chakan_no"]];
    [lbyueMoney setText:@"****.**"];
}

#pragma mark - 点击弹出提示框
-(void)tishiAction
{
    MainHomeBangDingTiShiView *view = [[MainHomeBangDingTiShiView alloc] init];
    [self addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
}

#pragma mark - 功能点击
-(void)functionAction:(UIButton *)sender
{
    NSArray *arrimages = @[@"",@"",@""];
    
    arrimages = @[@"",@"",@"",@"",@"",@""];
    if(arrimages.count == 3)
    {
        switch (sender.tag) {
            case 0:
            {///开通账户
                SetPayPasswordViewController *svc = [[SetPayPasswordViewController alloc]init];
                [self.viewController.navigationController pushViewController:svc animated:YES];
            }
                break;
            case 1:
            {///设置
                SetViewController *svc = [[SetViewController alloc]init];
                [self.viewController.navigationController pushViewController:svc animated:YES];
            }
                break;
            case 2:
            {///我的
                UserInfoViewController *svc = [[UserInfoViewController alloc]init];
                [self.viewController.navigationController pushViewController:svc animated:YES];
            }
                break;
            default:
                break;
        }
    }
    else
    {
        switch (sender.tag) {
            case 0:
            {///付款码
                FuKuanMaViewController *svc = [[FuKuanMaViewController alloc]init];
                [self.viewController.navigationController pushViewController:svc animated:YES];
            }
                break;
            case 1:
            {///余额查询
                YuEChaXunViewController *svc = [[YuEChaXunViewController alloc]init];
                [self.viewController.navigationController pushViewController:svc animated:YES];
            }
                break;
            case 2:
            {///钱包
                QianBaoViewController *svc = [[QianBaoViewController alloc]init];
                [self.viewController.navigationController pushViewController:svc animated:YES];
            }
                break;
            case 3:
            {///充值
                ChongZhiViewController *svc = [[ChongZhiViewController alloc]init];
                [self.viewController.navigationController pushViewController:svc animated:YES];
            }
                break;
            case 4:
            {///我的
                SetViewController *svc = [[SetViewController alloc]init];
                [self.viewController.navigationController pushViewController:svc animated:YES];
            }
                break;
            case 5:
            {///我的
                UserInfoViewController *svc = [[UserInfoViewController alloc]init];
                [self.viewController.navigationController pushViewController:svc animated:YES];
            }
                break;
            default:
                break;
        }
    }
    
    
}

@end
