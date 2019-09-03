//
//  YuEChaXunView.m
//  QingKu
//
//  Created by mdb-losaic on 2019/9/2.
//  Copyright © 2019 mcxzfa. All rights reserved.
//

#import "YuEChaXunView.h"


@interface YuEChaXunView ()
{
    
}
@end

@implementation YuEChaXunView

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
    UIImage *image = [UIImage imageNamed:@"qianbao_back_shili"];
    [imgvbc setImage:image];
    [imgvbc setContentMode:UIViewContentModeScaleAspectFit];
    [scvback addSubview:imgvbc];
    [imgvbc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.top.offset(10);
        make.width.offset(kMainScreenW-30);
        make.height.offset(image.size.height*(kMainScreenW-30)/image.size.width);
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
    
    
    UITextField *fieldnumber = [[UITextField alloc] init];
    [fieldnumber setTextAlignment:NSTextAlignmentLeft];
    [fieldnumber setFont:[UIFont systemFontOfSize:14]];
    [fieldnumber setTextColor:RGB(50, 50, 50)];
    [fieldnumber setPlaceholder:[MDB_UserDefault getSetStringNmae:@"qingshurujiaotongkahao"]];
    [scvback addSubview:fieldnumber];
    [fieldnumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(25);
        make.right.equalTo(viewline).offset(-25);
        make.height.offset(45*kScale);
        make.top.equalTo(viewline.mas_bottom);
    }];
    
    
    UIView *viewline1 = [[UIView alloc] init];
    [viewline1 setBackgroundColor:RGB(252, 248, 233)];
    [scvback addSubview:viewline1];
    [viewline1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.top.equalTo(fieldnumber.mas_bottom);
        make.width.offset(kMainScreenW-30);
        make.height.offset(1);
    }];
    
    UIButton *btok = [[UIButton alloc] init];
    [btok setTitle:[MDB_UserDefault getSetStringNmae:@"queding"] forState:UIControlStateNormal];
    btok.lee_theme.LeeConfigBackgroundColor(@"main_main_color");
    btok.lee_theme.LeeConfigButtonTitleColor(@"main_write_color", UIControlStateNormal);
    [btok.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [scvback addSubview:btok];
    [btok mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(viewline1);
        make.top.equalTo(viewline1.mas_bottom).offset(20);
        make.height.offset(45*kScale);
    }];
    [btok.layer setMasksToBounds:YES];
    [btok.layer setCornerRadius:45*kScale/2.0];
    
    
    UILabel *lbshuoming = [[UILabel alloc] init];
    [lbshuoming setText:[MDB_UserDefault getSetStringNmae:@"yuechaxunshuomingtishi"]];
    lbshuoming.lee_theme.LeeConfigTextColor(@"main_main_color");
    [lbshuoming setFont:[UIFont systemFontOfSize:12]];
    [lbshuoming setTextAlignment:NSTextAlignmentLeft];
    [lbshuoming setNumberOfLines:2];
    [scvback addSubview:lbshuoming];
    [lbshuoming mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewline1);
        make.top.equalTo(btok.mas_bottom).offset(10);
        make.right.equalTo(viewline1);
    }];
    
    
    UIView *viewline2 = [[UIView alloc] init];
    [viewline2 setBackgroundColor:RGB(234, 234, 234)];
    [scvback addSubview:viewline2];
    [viewline2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.top.equalTo(lbshuoming.mas_bottom).offset(10);
        make.width.offset(kMainScreenW);
        make.height.offset(10);
    }];
    
    ///历史卡号
    UIView *viewlishikahao = [[UIView alloc] init];
    [scvback addSubview:viewlishikahao];
    [viewlishikahao mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(viewline);
        make.top.equalTo(viewline2.mas_bottom);
        
    }];
    [self drawlishikaohao:viewlishikahao];
    
    
    [scvback mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(viewlishikahao.mas_bottom);
    }];

}

-(void)drawlishikaohao:(UIView *)view
{
    UILabel *lbtop = [[UILabel alloc] init];
    [lbtop setText:[MDB_UserDefault getSetStringNmae:@"xuanzhelishikaohao"]];
    lbtop.lee_theme.LeeConfigTextColor(@"main_textblack_color");
    [lbtop setFont:[UIFont systemFontOfSize:14]];
    [lbtop setTextAlignment:NSTextAlignmentLeft];
    [view addSubview:lbtop];
    [lbtop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.top.offset(0);
        make.height.offset(40);
    }];
    
    NSArray *arritems = @[@"873192831928731",@"873192831928731",@"873192831928731",@"873192831928731",@"873192831928731",@"873192831928731",];
    
    NSInteger iline = arritems.count/4;
    if(arritems.count%4!=0)
    {
        iline+=1;
    }
    
    
    float fitemw = (kMainScreenW-60)/4.0;
    float fitemh = 40*kScale;
    
    for(int i = 0; i < iline; i++)
    {
        for(int j = 0 ; j < 4; j++)
        {
            if(j+i*4>=arritems.count)break;
            UIView *viewitem = [[UIView alloc] init];
            [viewitem.layer setBorderColor:RadMenuColor.CGColor];
            [viewitem.layer setBorderWidth:1];
            [view addSubview:viewitem];
            [viewitem mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.offset(15+(10+fitemw)*j);
                make.top.offset(40+(fitemh+15)*i);
                make.size.sizeOffset(CGSizeMake(fitemw, fitemh));
            }];
            [viewitem.layer setMasksToBounds:YES];
            [viewitem.layer setCornerRadius:fitemh/2.0];
            
            
            UILabel *lbitem = [[UILabel alloc] init];
            [lbitem setText:arritems[j+i*3]];
            lbitem.lineBreakMode = NSLineBreakByTruncatingMiddle;
            lbitem.lee_theme.LeeConfigTextColor(@"main_main_color");
            [lbitem setFont:[UIFont systemFontOfSize:12]];
            [lbitem setTextAlignment:NSTextAlignmentCenter];
            [viewitem addSubview:lbitem];
            [lbitem mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.offset(10);
                make.top.bottom.equalTo(viewitem);
                make.right.equalTo(viewitem).offset(-10);
            }];
            
            
        }
    }
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(40 + iline*(fitemh+15)+20);
    }];
    
}


@end
