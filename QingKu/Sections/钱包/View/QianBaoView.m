//
//  QianBaoView.m
//  QingKu
//
//  Created by mdb-losaic on 2019/9/2.
//  Copyright © 2019 mcxzfa. All rights reserved.
//

#import "QianBaoView.h"

#import "ChongZhiViewController.h"
#import "ChongZhiJiLuTableViewController.h"
#import "XiaoFeiJiLuTableViewController.h"

@interface QianBaoView ()
{
    
    
}
@end

@implementation QianBaoView

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
    [self setBackgroundColor:[UIColor whiteColor]];
    
    UIScrollView *scvback = [[UIScrollView alloc] init];
    [scvback setShowsVerticalScrollIndicator:NO];
    [self addSubview:scvback];
    [scvback mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self);
        make.width.offset(kMainScreenW);
        make.bottom.equalTo(self);
    }];
    
    UIImageView *imgvbc = [[UIImageView alloc] init];
    UIImage *image = [UIImage imageNamed:@"qianbao_topback"];
    [imgvbc setImage:image];
    [imgvbc setContentMode:UIViewContentModeScaleAspectFit];
    [scvback addSubview:imgvbc];
    [imgvbc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.top.offset(10);
        make.width.offset(kMainScreenW-30);
        make.height.offset(image.size.height*(kMainScreenW-30)/image.size.width);
    }];
    
    UILabel *lbtime = [[UILabel alloc] init];
    [lbtime setText:@"2019-09-02"];
    lbtime.lee_theme.LeeConfigTextColor(@"main_textblack_color");
    [lbtime setFont:[UIFont systemFontOfSize:14]];
    [lbtime setTextAlignment:NSTextAlignmentRight];
    [imgvbc addSubview:lbtime];
    [lbtime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(imgvbc).offset(-15*kScale);
        make.top.offset(20*kScale);
        make.width.offset(120);
        make.height.offset(20);
    }];
    
    
    UILabel *lbnumber = [[UILabel alloc] init];
    [lbnumber setText:@"NO.8888.8888.8888.8888"];
    lbnumber.lee_theme.LeeConfigTextColor(@"main_textblack_color");
    [lbnumber setFont:[UIFont systemFontOfSize:14]];
    [lbnumber setTextAlignment:NSTextAlignmentLeft];
    [imgvbc addSubview:lbnumber];
    [lbnumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imgvbc).offset(15*kScale);
        make.bottom.equalTo(imgvbc).offset(-20*kScale);
        make.width.offset(300);
        make.height.offset(20);
    }];
    
    
    UIView *viewline = [[UIView alloc] init];
    viewline.lee_theme.LeeConfigBackgroundColor(@"main_line_color");
    [scvback addSubview:viewline];
    [viewline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.top.equalTo(imgvbc.mas_bottom).offset(10);
        make.width.offset(kMainScreenW);
        make.height.offset(1);
    }];
    
    
    UILabel *lbyue = [[UILabel alloc] init];
    [lbyue setText:@"20000.00"];
    lbyue.lee_theme.LeeConfigTextColor(@"main_main_color");
    [lbyue setFont:[UIFont systemFontOfSize:28]];
    [lbyue setTextAlignment:NSTextAlignmentCenter];
    [scvback addSubview:lbyue];
    [lbyue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(imgvbc);
        make.top.equalTo(viewline.mas_bottom).offset(15);
        make.height.offset(30);
    }];
    
    UILabel *lbyuetext = [[UILabel alloc] init];
    [lbyuetext setText:[NSString stringWithFormat:@"%@（MMK）",[MDB_UserDefault getSetStringNmae:@"zhanghuyue"]]];
    lbyuetext.lee_theme.LeeConfigTextColor(@"main_textblack01_color");
    [lbyuetext setFont:[UIFont systemFontOfSize:14]];
    [lbyuetext setTextAlignment:NSTextAlignmentCenter];
    [scvback addSubview:lbyuetext];
    [lbyuetext mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(imgvbc);
        make.top.equalTo(lbyue.mas_bottom);
        make.height.offset(20);
    }];
    
    UIView *viewline1 = [[UIView alloc] init];
    [viewline1 setBackgroundColor:RGB(234, 234, 234)];
    [scvback addSubview:viewline1];
    [viewline1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.top.equalTo(lbyuetext.mas_bottom).offset(10);
        make.width.offset(kMainScreenW);
        make.height.offset(10);
    }];
    
    
    NSArray *arrimages = @[@"qianbao_chongzhi",@"qianbao_chongzhijilu",@"qianbao_xiaofeijilu",@"qianbao_changjianwenti"];
    NSArray *arrtext = @[[MDB_UserDefault getSetStringNmae:@"chongzhi"],
                         [MDB_UserDefault getSetStringNmae:@"chongzhijilu"],
                         [MDB_UserDefault getSetStringNmae:@"xiaofeijilu"],
                         [MDB_UserDefault getSetStringNmae:@"changjianwenti"]];
    
    UIView *viewlast = nil;
    for(int i = 0 ; i < arrimages.count; i++)
    {
        UIButton *btitem = [[UIButton alloc] init];
        [btitem setTag:i];
        [btitem addTarget:self action:@selector(iteAction:) forControlEvents:UIControlEventTouchUpInside];
        [scvback addSubview:btitem];
        [btitem mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(viewline1);
            make.top.equalTo(viewline1.mas_bottom).offset(55*kScale*i);
            make.height.offset(55*kScale);
        }];
        
        UIImageView *imgvitem = [[UIImageView alloc] init];
        [imgvitem setImage:[UIImage imageNamed:arrimages[i]]];
        [btitem addSubview:imgvitem];
        [imgvitem mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(15);
            make.centerY.equalTo(btitem);
            make.size.sizeOffset(CGSizeMake(20, 20));
        }];
        
        UILabel *lbitem =[[UILabel alloc] init];
        [lbitem setText:arrtext[i]];
        [lbitem setTextColor:RGB(50, 50, 50)];
        [lbitem setFont:[UIFont systemFontOfSize:14]];
        [lbitem setTextAlignment:NSTextAlignmentLeft];
        [btitem addSubview:lbitem];
        [lbitem mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(imgvitem.mas_right).offset(10);
            make.top.bottom.equalTo(btitem);
        }];
        
        UIView *viewlineitem = [[UIView alloc] init];
        viewlineitem.lee_theme.LeeConfigBackgroundColor(@"main_line_color");
        [btitem addSubview:viewlineitem];
        [viewlineitem mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(lbitem);
            make.bottom.equalTo(btitem.mas_bottom);
            make.right.equalTo(btitem);
            make.height.offset(1);
        }];
        
        
        viewlast = btitem;
    }
    
    [scvback mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(viewlast.mas_bottom).offset(20);
    }];
    
}

-(void)iteAction:(UIButton *)sender
{
    
    switch (sender.tag) {
        case 0:
        {///充值
            ChongZhiViewController *vc = [[ChongZhiViewController alloc] init];
            [self.viewController.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:
        {///充值记录
            ChongZhiJiLuTableViewController *vc = [[ChongZhiJiLuTableViewController alloc] init];
            [self.viewController.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2:
        {///消费记录
            XiaoFeiJiLuTableViewController *vc = [[XiaoFeiJiLuTableViewController alloc] init];
            [self.viewController.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 3:
        {///常见问题
            
        }
            break;
        default:
            break;
    }
}

@end
