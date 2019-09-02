//
//  ForgetPasswordView.m
//  QingKu
//
//  Created by 彭光静 on 2019/9/1.
//  Copyright © 2019 mcxzfa. All rights reserved.
//

#import "ForgetPasswordView.h"

#import "SelectCountryViewController.h"

@interface ForgetPasswordView ()<SelectCountryViewControllerDelegete>
{
    ///国家
    UILabel *lbselectcountry;
    
}
@end


@implementation ForgetPasswordView

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
    scvback.lee_theme.LeeConfigBackgroundColor(@"main_write_color");
    [self addSubview:scvback];
    [scvback mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.top.equalTo(self);
        make.left.offset(0);
        make.width.offset(kMainScreenW);
        
    }];
    
    
    ///
    UILabel *lbtop = [[UILabel alloc] init];
    [lbtop setText:[MDB_UserDefault getSetStringNmae:@"zhaohuimima"]];
    lbtop.lee_theme.LeeConfigTextColor(@"main_textblack_color");
    [lbtop setFont:[UIFont systemFontOfSize:18]];
    [lbtop setTextAlignment:NSTextAlignmentLeft];
    [scvback addSubview:lbtop];
    [lbtop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(20);
        make.top.offset(30);
        make.width.offset(200);
        make.height.offset(25);
    }];
    
    UILabel *lbtopmin = [[UILabel alloc] init];
    [lbtopmin setText:[MDB_UserDefault getSetStringNmae:@"qingshuruxinmimayanzsjh"]];
    lbtopmin.lee_theme.LeeConfigTextColor(@"main_textGraw_color");
    [lbtopmin setFont:[UIFont systemFontOfSize:13]];
    [lbtopmin setTextAlignment:NSTextAlignmentLeft];
    [scvback addSubview:lbtopmin];
    [lbtopmin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lbtop);
        make.top.equalTo(lbtop.mas_bottom);
        make.width.offset(300);
        make.height.offset(15);
    }];
    
    ////////
    UIButton *btselect = [[UIButton alloc] init];
    [btselect addTarget:self action:@selector(countryAction) forControlEvents:UIControlEventTouchUpInside];
    [scvback addSubview:btselect];
    [btselect mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lbtop);
        make.top.equalTo(lbtopmin.mas_bottom).offset(20);
        make.height.offset(40);
    }];
    UILabel *lbnumber = [[UILabel alloc] init];
    [lbnumber setText:@"+95"];
    lbnumber.lee_theme.LeeConfigTextColor(@"main_textblack01_color");
    [lbnumber setFont:[UIFont systemFontOfSize:14]];
    [lbnumber setTextAlignment:NSTextAlignmentLeft];
    [btselect addSubview:lbnumber];
    [lbnumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(btselect);
        make.top.bottom.equalTo(btselect);
        make.width.offset(30);
    }];
    
    UILabel *lbcountry = [[UILabel alloc] init];
    [lbcountry setText:[MDB_UserDefault getSetStringNmae:@"miandian"]];
    lbcountry.lee_theme.LeeConfigTextColor(@"main_textblack01_color");
    [lbcountry setFont:[UIFont systemFontOfSize:11]];
    [lbcountry setTextAlignment:NSTextAlignmentLeft];
    [btselect addSubview:lbcountry];
    [lbcountry mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lbnumber.mas_right);
        make.top.bottom.equalTo(btselect);
    }];
    [lbcountry sizeToFit];
    lbselectcountry = lbcountry;
    
    UIImageView *imgvdown = [[UIImageView alloc] init];
    [imgvdown setImage:[UIImage imageNamed:@"next_down"]];
    [btselect addSubview:imgvdown];
    [imgvdown mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(btselect);
        make.size.sizeOffset(CGSizeMake(10, 10));
        make.left.equalTo(lbcountry.mas_right).offset(3);
    }];
    [btselect mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(imgvdown.mas_right).offset(3);
    }];
    
    
    ///
    UITextField *fieldphone = [[UITextField alloc] init];
    fieldphone.lee_theme.LeeConfigTextColor(@"main_textblack01_color");
    [fieldphone setTextAlignment:NSTextAlignmentLeft];
    [fieldphone setFont:[UIFont systemFontOfSize:14]];
    [fieldphone setPlaceholder:[MDB_UserDefault getSetStringNmae:@"qingshurunindeshoujihao"]];
    [scvback addSubview:fieldphone];
    [fieldphone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(btselect.mas_right).offset(10);
        make.centerY.equalTo(btselect);
        make.right.equalTo(self).offset(-20);
        make.height.offset(40);
    }];
    
    
    ////
    UITextField *fieldpass = [[UITextField alloc] init];
    fieldpass.lee_theme.LeeConfigTextColor(@"main_textblack01_color");
    [fieldpass setTextAlignment:NSTextAlignmentLeft];
    [fieldpass setFont:[UIFont systemFontOfSize:14]];
    [fieldpass setPlaceholder:[MDB_UserDefault getSetStringNmae:@"qingshuruxindemima"]];
    [fieldpass setSecureTextEntry:YES];
    [scvback addSubview:fieldpass];
    [fieldpass mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lbtopmin);
        make.top.equalTo(fieldphone.mas_bottom).offset(10);
        make.right.height.equalTo(fieldphone);
    }];
    
    UIView *viewline0 = [[UIView alloc] init];
    viewline0.lee_theme.LeeConfigBackgroundColor(@"main_line_color");
    [scvback addSubview:viewline0];
    [viewline0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(fieldpass);
        make.top.equalTo(fieldpass.mas_bottom);
        make.height.offset(1);
    }];
    
    
    
    
    
    
    
    ///
    UITextField *fieldcode = [[UITextField alloc] init];
    fieldcode.lee_theme.LeeConfigTextColor(@"main_textblack01_color");
    [fieldcode setTextAlignment:NSTextAlignmentLeft];
    [fieldcode setFont:[UIFont systemFontOfSize:14]];
    [fieldcode setPlaceholder:[MDB_UserDefault getSetStringNmae:@"qingshurunindeyanzhenma"]];
    [scvback addSubview:fieldcode];
    [fieldcode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.height.equalTo(fieldpass);
        make.top.equalTo(viewline0.mas_bottom).offset(10);
        make.right.equalTo(viewline0).offset(-90);
    }];
    UIView *viewline1 = [[UIView alloc] init];
    viewline1.lee_theme.LeeConfigBackgroundColor(@"main_line_color");
    [scvback addSubview:viewline1];
    [viewline1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(viewline0);
        make.height.offset(1);
        make.top.equalTo(fieldcode.mas_bottom);
    }];
    ///

    UIButton *btcode = [[UIButton alloc] init];
    [btcode setTitle:[MDB_UserDefault getSetStringNmae:@"huoquyanzhenma"] forState:UIControlStateNormal];
    btcode.lee_theme.LeeConfigButtonTitleColor(@"main_main_color", UIControlStateNormal);
    [btcode.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [scvback addSubview:btcode];
    [btcode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(viewline1);
        make.width.offset(90);
        make.height.equalTo(fieldpass);
        make.centerY.equalTo(fieldcode);
    }];

    ////
    UILabel *lbshuoming = [[UILabel alloc] init];
    [lbshuoming setText:[MDB_UserDefault getSetStringNmae:@"zhaohuimimashuomingms"]];
    lbshuoming.lee_theme.LeeConfigTextColor(@"main_main_color");
    [lbshuoming setFont:[UIFont systemFontOfSize:12]];
    [lbshuoming setTextAlignment:NSTextAlignmentLeft];
    [scvback addSubview:lbshuoming];
    [lbshuoming mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewline1);
        make.top.equalTo(viewline1.mas_bottom).offset(20);
        make.right.equalTo(viewline1);
        make.height.offset(20);
    }];

    ///

    UIButton *btok = [[UIButton alloc] init];
    [btok setTitle:[MDB_UserDefault getSetStringNmae:@"queding"] forState:UIControlStateNormal];
    btok.lee_theme.LeeConfigBackgroundColor(@"main_main_color");
    btok.lee_theme.LeeConfigButtonTitleColor(@"main_write_color", UIControlStateNormal);
    [btok.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [scvback addSubview:btok];
    [btok mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(viewline1);
        make.top.equalTo(lbshuoming.mas_bottom).offset(20);
        make.height.offset(45*kScale);
    }];
    [btok.layer setMasksToBounds:YES];
    [btok.layer setCornerRadius:45*kScale/2.0];

    [scvback mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(btok.mas_bottom).offset(20);
    }];
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self endEditing:NO];
}

#pragma mark - 选择国家
-(void)countryAction
{
    SelectCountryViewController *svc = [[SelectCountryViewController alloc] init];
    svc.delegete = self;
    svc.inomoselect = 0;
    [self.viewController.navigationController pushViewController:svc animated:YES];
    
}
////缅甸0 中国1
-(void)selectCountry:(NSInteger)iselect
{
    if(iselect<0)
    {
        iselect = 0;
    }
    if(iselect>1)
    {
        iselect = 1;
    }
    NSArray *arrname = @[[MDB_UserDefault getSetStringNmae:@"miandian"],[MDB_UserDefault getSetStringNmae:@"zhongguo"]];
    [lbselectcountry setText:arrname[iselect]];
}

@end
