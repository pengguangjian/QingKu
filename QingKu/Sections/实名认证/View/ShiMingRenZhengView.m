//
//  ShiMingRenZhengView.m
//  QingKu
//
//  Created by mdb-losaic on 2019/9/2.
//  Copyright © 2019 mcxzfa. All rights reserved.
//

#import "ShiMingRenZhengView.h"

@interface ShiMingRenZhengView ()
{
    
    
}
@end

@implementation ShiMingRenZhengView

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
    
    
    UILabel *lbtop = [[UILabel alloc] init];
    [lbtop setText:[MDB_UserDefault getSetStringNmae:@"shimingrenzhentop"]];
    [lbtop setTextColor:RGB(20, 20, 20)];
    [lbtop setFont:[UIFont systemFontOfSize:14]];
    [lbtop setTextAlignment:NSTextAlignmentLeft];
    [scvback addSubview:lbtop];
    [lbtop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.top.offset(10);
        make.width.offset(300);
        make.height.offset(30);
    }];
    
    UILabel *lbtopmin = [[UILabel alloc] init];
    [lbtopmin setText:[MDB_UserDefault getSetStringNmae:@"shimingrenzhentopmin"]];
    [lbtopmin setTextColor:RGB(150, 150, 150)];
    [lbtopmin setFont:[UIFont systemFontOfSize:13]];
    [lbtopmin setTextAlignment:NSTextAlignmentLeft];
    [lbtopmin setNumberOfLines:0];
    [lbtopmin sizeToFit];
    [scvback addSubview:lbtopmin];
    [lbtopmin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lbtop);
        make.width.offset(kMainScreenW-30);
        make.top.equalTo(lbtop.mas_bottom);
    }];
    
    float fitemw = (kMainScreenW-50)/2.0;
    UIImageView *imgvzhenmian = [[UIImageView alloc] init];
    [imgvzhenmian setImage:[UIImage imageNamed:@"shenfenzhen_zhenmian"]];
    [scvback addSubview:imgvzhenmian];
    [imgvzhenmian mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.top.equalTo(lbtopmin.mas_bottom).offset(5);
        make.size.sizeOffset(CGSizeMake(fitemw, fitemw*0.9));
    }];
    
    UIImageView *imgvfanmian = [[UIImageView alloc] init];
    [imgvfanmian setImage:[UIImage imageNamed:@"shenfenzhen_fanmian"]];
    [scvback addSubview:imgvfanmian];
    [imgvfanmian mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imgvzhenmian.mas_right).offset(20);
        make.top.equalTo(imgvzhenmian);
        make.size.equalTo(imgvzhenmian);
    }];
    
    
    UIView *viewinfo = [[UIView alloc] init];
    [scvback addSubview:viewinfo];
    [viewinfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.width.offset(kMainScreenW);
        make.top.equalTo(imgvzhenmian.mas_bottom).offset(20);
    }];
    
    [self drawInfoView:viewinfo];
    
    
    ////
    UIButton *btok = [[UIButton alloc] init];
    [btok setTitle:[MDB_UserDefault getSetStringNmae:@"queding"] forState:UIControlStateNormal];
    btok.lee_theme.LeeConfigBackgroundColor(@"main_main_color");
    btok.lee_theme.LeeConfigButtonTitleColor(@"main_write_color", UIControlStateNormal);
    [btok.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [scvback addSubview:btok];
    [btok mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.right.equalTo(self).offset(-15);
        make.top.equalTo(viewinfo.mas_bottom).offset(30);
        make.height.offset(45*kScale);
    }];
    [btok.layer setMasksToBounds:YES];
    [btok.layer setCornerRadius:45*kScale/2.0];
    
    [scvback mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(btok.mas_bottom).offset(20);
    }];
    
}


-(void)drawInfoView:(UIView *)view
{
    
    
    
}


@end
