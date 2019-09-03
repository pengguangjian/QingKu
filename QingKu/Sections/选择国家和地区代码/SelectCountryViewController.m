//
//  SelectCountryViewController.m
//  QingKu
//
//  Created by 彭光静 on 2019/9/1.
//  Copyright © 2019 mcxzfa. All rights reserved.
//

#import "SelectCountryViewController.h"

@interface SelectCountryViewController ()
{
    UIButton *btnowselect;
}
@end

@implementation SelectCountryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = [MDB_UserDefault getSetStringNmae:@"xuanzheguojiahediqudaima"];
    
    [self drawUI];
    
}

-(void)drawUI
{
    UIView *viewback = [[UIView alloc] init];
    viewback.lee_theme.LeeConfigBackgroundColor(@"main_write_color");
    [self.view addSubview:viewback];
    [viewback mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
            make.left.equalTo(self.view.mas_safeAreaLayoutGuideLeft);
            make.right.equalTo(self.view.mas_safeAreaLayoutGuideRight);
            make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        }else{
            make.edges.equalTo(self.view).insets(kPaddingNav);
        }
    }];
    
    NSArray *arrname = @[[MDB_UserDefault getSetStringNmae:@"miandian"],[MDB_UserDefault getSetStringNmae:@"zhongguo"]];
    NSArray *arrnumber = @[@"+95",@"+86"];
    
    if(self.inomoselect>1)
    {
        self.inomoselect = 0;
    }
    
    for(int i = 0 ; i < arrname.count; i++)
    {
        UIButton *btitem = [[UIButton alloc] init];
        [btitem setTag:i];
        [btitem addTarget:self action:@selector(itemAction:) forControlEvents:UIControlEventTouchUpInside];
        [viewback addSubview:btitem];
        [btitem mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(viewback);
            make.height.offset(45);
            make.top.offset(45*i);
        }];
        
        UIImageView *imgv = [[UIImageView alloc] init];
        [imgv setImage:[UIImage imageNamed:@"select_yuan_no"]];
        [imgv setTag:10110];
        [btitem addSubview:imgv];
        [imgv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(btitem);
            make.left.offset(15);
            make.size.sizeOffset(CGSizeMake(12, 12));
        }];
        
        UILabel *lbname = [[UILabel alloc] init];
        [lbname setText:arrname[i]];
        lbname.lee_theme.LeeConfigTextColor(@"main_textblack01_color");
        [lbname setFont:[UIFont systemFontOfSize:14]];
        [lbname setTextAlignment:NSTextAlignmentLeft];
        [btitem addSubview:lbname];
        [lbname setTag:1000];
        [lbname mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(imgv.mas_right).offset(10);
            make.top.bottom.equalTo(btitem);
            make.width.offset(200);
        }];
        
        UILabel *lbnumber = [[UILabel alloc] init];
        [lbnumber setText:arrnumber[i]];
        lbnumber.lee_theme.LeeConfigTextColor(@"main_textblack01_color");
        [lbnumber setFont:[UIFont systemFontOfSize:14]];
        [lbnumber setTextAlignment:NSTextAlignmentRight];
        [lbnumber setTag:10000];
        [btitem addSubview:lbnumber];
        [lbnumber mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(btitem).offset(-20);
            make.top.bottom.equalTo(btitem);
            make.width.offset(100);
        }];
        
        if(i == 0)
        {
            UIView *viewline = [[UIView alloc] init];
            viewline.lee_theme.LeeConfigBackgroundColor(@"main_line_color");
            [btitem addSubview:viewline];
            [viewline mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.offset(1);
                make.bottom.equalTo(btitem);
                make.left.equalTo(lbname);
                make.right.equalTo(lbnumber);
            }];
        }
        if(i == self.inomoselect)
        {
            btnowselect = btitem;
            [imgv setImage:[UIImage imageNamed:@"select_yuan_yes"]];
        }
    }
    
}

-(void)itemAction:(UIButton *)sender
{
    if(sender.tag==btnowselect.tag)return;
    if(btnowselect!=nil)
    {
        UIImageView *imgv = [btnowselect viewWithTag:10110];
        [imgv setImage:[UIImage imageNamed:@"select_yuan_no"]];
    }
    
    
    btnowselect = sender;
    UIImageView *imgv1 = [sender viewWithTag:10110];
    [imgv1 setImage:[UIImage imageNamed:@"select_yuan_yes"]];
    
    
    [self.delegete selectCountry:sender.tag];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
