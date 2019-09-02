//
//  SetNewPayPasswordView.m
//  QingKu
//
//  Created by mdb-losaic on 2019/9/2.
//  Copyright © 2019 mcxzfa. All rights reserved.
//

#import "SetNewPayPasswordView.h"

#import "ZhiWenYanZhenViewController.h"

@implementation SetNewPayPasswordView

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
    
    
    UILabel *lbtop = [[UILabel alloc] init];
    [lbtop setText:[MDB_UserDefault getSetStringNmae:@"shezhixinmima"]];
    [lbtop setTextColor:[UIColor blackColor]];
    [lbtop setTextAlignment:NSTextAlignmentLeft];
    [lbtop setFont:[UIFont systemFontOfSize:30]];
    [self addSubview:lbtop];
    [lbtop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(25);
        make.top.offset(35*kScale);
        make.height.offset(40);
    }];
    
    UILabel *lbtopmin = [[UILabel alloc] init];
    [lbtopmin setText:[MDB_UserDefault getSetStringNmae:@"shurugerenxinxi"]];
    [lbtopmin setTextColor:RGB(150, 150, 150)];
    [lbtopmin setTextAlignment:NSTextAlignmentLeft];
    [lbtopmin setFont:[UIFont systemFontOfSize:13]];
    [self addSubview:lbtopmin];
    [lbtopmin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lbtop);
        make.top.equalTo(lbtop.mas_bottom);
        make.height.offset(20);
    }];
    
    UITextField *fieldname = [[UITextField alloc] init];
    [fieldname setTextColor:[UIColor blackColor]];
    [fieldname setTextAlignment:NSTextAlignmentLeft];
    [fieldname setFont:[UIFont systemFontOfSize:14]];
    [fieldname setPlaceholder:[MDB_UserDefault getSetStringNmae:@"qingshuruzhenshiname"]];
    [self addSubview:fieldname];
    [fieldname mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lbtop);
        make.top.equalTo(lbtopmin.mas_bottom).offset(20);
        make.right.equalTo(self).offset(-25);
        make.height.offset(40);
    }];
    
    UIView *viewline0 = [[UIView alloc] init];
    [viewline0 setBackgroundColor:RGB(236, 236, 236)];
    [self addSubview:viewline0];
    [viewline0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(fieldname);
        make.top.equalTo(fieldname.mas_bottom);
        make.height.offset(1);
    }];
    
    ////
    UITextField *fieldnumber = [[UITextField alloc] init];
    [fieldnumber setTextColor:[UIColor blackColor]];
    [fieldnumber setTextAlignment:NSTextAlignmentLeft];
    [fieldnumber setFont:[UIFont systemFontOfSize:14]];
    [fieldnumber setPlaceholder:[MDB_UserDefault getSetStringNmae:@"qingshurushenfenzhennumber"]];
    [self addSubview:fieldnumber];
    [fieldnumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(viewline0);
        make.top.equalTo(viewline0.mas_bottom).offset(20);
        make.height.offset(40);
    }];
    
    UIView *viewline1 = [[UIView alloc] init];
    [viewline1 setBackgroundColor:RGB(236, 236, 236)];
    [self addSubview:viewline1];
    [viewline1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(fieldnumber);
        make.top.equalTo(fieldnumber.mas_bottom);
        make.height.offset(1);
    }];
    
    ///
    UIButton *btnext = [[UIButton alloc] init];
    [btnext setTitle:[MDB_UserDefault getSetStringNmae:@"xiayibu"] forState:UIControlStateNormal];
    btnext.lee_theme.LeeConfigButtonTitleColor(@"main_write_color", UIControlStateNormal);
    [btnext.titleLabel setFont:[UIFont systemFontOfSize:15]];
    btnext.lee_theme.LeeConfigBackgroundColor(@"main_main_color");
    [self addSubview:btnext];
    [btnext mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(viewline1);
        make.top.equalTo(viewline1.mas_bottom).offset(60*kScale);
        make.height.offset(50*kScale);
    }];
    [btnext.layer setMasksToBounds:YES];
    [btnext.layer setCornerRadius:50*kScale/2.0];
    [btnext addTarget:self action:@selector(nextAction) forControlEvents:UIControlEventTouchUpInside];
    
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self endEditing:NO];
    
}

#pragma mark - 下一步
-(void)nextAction
{
    ZhiWenYanZhenViewController *zvc = [[ZhiWenYanZhenViewController alloc] init];
    [self.viewController.navigationController pushViewController:zvc animated:YES];
}
@end
