//
//  MainHomeBangDingTiShiView.m
//  QingKu
//
//  Created by 彭光静 on 2019/9/1.
//  Copyright © 2019 mcxzfa. All rights reserved.
//

#import "MainHomeBangDingTiShiView.h"

@implementation MainHomeBangDingTiShiView

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
    [self setBackgroundColor:[UIColor clearColor]];
    
    UIView *viewcenter = [[UIView alloc] init];
    viewcenter.lee_theme.LeeConfigBackgroundColor(@"main_write_color");
    [self addSubview:viewcenter];
    [viewcenter mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(50*kScale);
        make.right.equalTo(self).offset(-50*kScale);
        make.center.equalTo(self);
    }];
    
    
    
    UILabel *lbtishi = [[UILabel alloc] init];
    [lbtishi setText:[MDB_UserDefault getSetStringNmae:@"tishi"]];
    lbtishi.lee_theme.LeeConfigTextColor(@"main_textblack_color");
    [lbtishi setTextAlignment:NSTextAlignmentLeft];
    [lbtishi setFont:[UIFont systemFontOfSize:16]];
    [viewcenter addSubview:lbtishi];
    [lbtishi mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.top.offset(10);
        make.height.offset(30);
        make.width.offset(100);
    }];
    
    
    UIButton *btx = [[UIButton alloc] init];
    [btx addTarget:self action:@selector(xAction) forControlEvents:UIControlEventTouchUpInside];
    [viewcenter addSubview:btx];
    [btx mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(viewcenter).offset(-5);
        make.top.equalTo(lbtishi);
        make.size.sizeOffset(CGSizeMake(30, 30));
    }];
    UIImageView *imgvx = [[UIImageView alloc] init];
    [imgvx setImage:[UIImage imageNamed:@"del_X"]];
    [btx addSubview:imgvx];
    [imgvx mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(btx);
        make.size.sizeOffset(CGSizeMake(15, 15));
    }];
    
    
    
    
    UILabel *lbtishicontent = [[UILabel alloc] init];
    [lbtishicontent setText:[MDB_UserDefault getSetStringNmae:@"tishicontent"]];
    lbtishicontent.lee_theme.LeeConfigTextColor(@"main_textblack01_color");
    [lbtishicontent setTextAlignment:NSTextAlignmentLeft];
    [lbtishicontent setFont:[UIFont systemFontOfSize:14]];
    [lbtishicontent setNumberOfLines:0];
    [viewcenter addSubview:lbtishicontent];
    [lbtishicontent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lbtishi);
        make.top.equalTo(lbtishi.mas_bottom).offset(10);
        make.right.equalTo(viewcenter).offset(-10);
    }];
    
    UIButton *btbd = [[UIButton alloc] init];
    [btbd setTitle:[MDB_UserDefault getSetStringNmae:@"tishibingding"] forState:UIControlStateNormal];
    [btbd.titleLabel setFont:[UIFont systemFontOfSize:15]];
    btbd.lee_theme.LeeConfigButtonTitleColor(@"main_main_color", UIControlStateNormal);
    [viewcenter addSubview:btbd];
    [btbd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(viewcenter).offset(-10);
        make.top.equalTo(lbtishicontent.mas_bottom).offset(20);
        make.height.offset(30);
        
    }];
    [btbd addTarget:self action:@selector(bangdingAction) forControlEvents:UIControlEventTouchUpInside];
    
    [viewcenter mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(btbd.mas_bottom).offset(20);
    }];
}

-(void)bangdingAction
{
    [self xAction];
    
    
    
}

-(void)xAction
{
    [self removeFromSuperview];
}

@end
