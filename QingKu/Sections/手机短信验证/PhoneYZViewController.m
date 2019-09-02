//
//  PhoneYZViewController.m
//  QingKu
//
//  Created by 彭光静 on 2019/9/1.
//  Copyright © 2019 mcxzfa. All rights reserved.
//

#import "PhoneYZViewController.h"

#import "SelectCountryViewController.h"

@interface PhoneYZViewController ()<SelectCountryViewControllerDelegete>

@end

@implementation PhoneYZViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = [MDB_UserDefault getSetStringNmae:@"shoujiduanxinyanzhen"];
    
    [self drawUI];
    
}

-(void)drawUI
{
    self.view.lee_theme.LeeConfigBackgroundColor(@"main_write_color");
    
    
    [self.lbtopyzm setText:[MDB_UserDefault getSetStringNmae:@"shoujiyanzhenma"]];
    self.lbtopyzm.lee_theme.LeeConfigTextColor(@"main_textblack_color");
    
    
    [self.lbtopminyzm setText:[MDB_UserDefault getSetStringNmae:@"qingshuruyanzhenma"]];
    self.lbtopminyzm.lee_theme.LeeConfigTextColor(@"main_textGraw_color");
    
    [self.lbcountry setText:[MDB_UserDefault getSetStringNmae:@"miandian"]];
    [self.lbcountry setText:@"China"];
    [self.lbcountry sizeToFit];
    self.lbcountry.lee_theme.LeeConfigTextColor(@"main_textblack_color");
    
    [self.imgvCountry setLeft:self.lbcountry.right+3];
    
    [self.fieldPhone setPlaceholder:[MDB_UserDefault getSetStringNmae:@"qingshurunindeshoujihao"]];
    self.fieldPhone.lee_theme.LeeConfigTextColor(@"main_textblack_color");
    
    [self.fieldCode setPlaceholder:[MDB_UserDefault getSetStringNmae:@"qingshurunindeyanzhenma"]];
    self.fieldCode.lee_theme.LeeConfigTextColor(@"main_textblack_color");
    
    [self.btCode setTitle:[MDB_UserDefault getSetStringNmae:@"huoquyanzhenma"] forState:UIControlStateNormal];
    
    [self.btok setTitle:[MDB_UserDefault getSetStringNmae:@"queding"] forState:UIControlStateNormal];
    
    [self.btok.layer setMasksToBounds:YES];
    [self.btok.layer setCornerRadius:self.btok.height/2.0];
    
    [self.viewSelectCountry setUserInteractionEnabled:YES];
    UITapGestureRecognizer *tapview = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(conuntryAction)];
    [self.viewSelectCountry addGestureRecognizer:tapview];
//    [self.viewSelectCountry setWidth:90];
}

-(void)conuntryAction
{
    SelectCountryViewController *svc = [[SelectCountryViewController alloc] init];
    [svc setDelegete:self];
    svc.inomoselect = 0;
    [self.navigationController pushViewController:svc animated:YES];
}
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
    
    [self.lbcountry setText:arrname[iselect]];
    
}

- (IBAction)codeAction:(id)sender {
    
    NSLog(@"获取验证码");
}
- (IBAction)okAction:(id)sender {
    
    NSLog(@"确定");
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
