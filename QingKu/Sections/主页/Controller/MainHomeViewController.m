//
//  MainHomeViewController.m
//  QingKu
//
//  Created by mdb-losaic on 2019/8/26.
//  Copyright © 2019 mcxzfa. All rights reserved.
//

#import "MainHomeViewController.h"
#import "ChangeLanguage.h"
#import <LocalAuthentication/LAContext.h>

@interface MainHomeViewController ()
{
    UIButton *btchange;
    
}
@end

@implementation MainHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.lee_theme.LeeConfigBackgroundColor(@"common_bg_color_1");
    
    btchange = [[UIButton alloc] init];
    [btchange.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [self.view addSubview:btchange];
    [btchange mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.sizeOffset(CGSizeMake(80*kScale, 45*kScale));
    }];
    [btchange addTarget:self action:@selector(changeAction) forControlEvents:UIControlEventTouchUpInside];
    btchange.lee_theme.LeeConfigButtonTitleColor(@"common_bg_color_2", UIControlStateNormal);
    btchange.lee_theme.LeeConfigBackgroundColor(@"common_bg_color_1");
    
    
    NSArray *arr = @[@"中文",@"英文",@"缅甸文",@"指纹验证"];
    for(int i = 0; i < 4; i++)
    {
        UIButton *btitem = [[UIButton alloc] init];
        [btitem setTitle:arr[i] forState:UIControlStateNormal];
        [btitem setBackgroundColor:[UIColor redColor]];
        [btitem setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btitem setTag:i];
        [self.view addSubview:btitem];
        [btitem mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view);
            make.centerY.equalTo(self.view).offset(60*kScale+50*i);
            make.size.sizeOffset(CGSizeMake(80*kScale,45));
        }];
        [btitem addTarget:self action:@selector(itemAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    [self setAllTextValue];
    
}

-(void)setAllTextValue
{
    [btchange setTitle:[self getStringNmae:@"bottomName"] forState:UIControlStateNormal];
}

-(NSString *)getStringNmae:(NSString *)strname
{
    NSBundle *bundle = [ChangeLanguage bundle];
    
    NSString *str = [bundle localizedStringForKey:@"bottomName" value:nil table:@"Localizable"];
    return str;
}

///更改语言
-(void)itemAction:(UIButton *)sender
{
    if(sender.tag==0)
    {
        [ChangeLanguage setUserLanguage:@"zh-Hans"];
    }
    else if(sender.tag==1)
    {
        [ChangeLanguage setUserLanguage:@"en"];
    }
    if(sender.tag==2)
    {
        [ChangeLanguage setUserLanguage:@"my"];///my_ZG  my_MM
    }
    if(sender.tag<3)
    {
        [self setAllTextValue];
    }
    else if (sender.tag == 3)
    {///指纹验证
        LAContext *myContext = [[LAContext alloc] init];
        NSError *authError = nil;
        NSString *myLocalizedReasonString = @"我们需要验证您的指纹来确认你的身份";
        // 判断设备是否支持指纹识别
        if ([myContext canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&authError]) {
            // 指纹识别只判断当前用户是否机主
            [myContext evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
                      localizedReason:myLocalizedReasonString
                                reply:^(BOOL success, NSError *error) {
                                    if (success) {
                                        // User authenticated successfully, take appropriate action
                                        NSLog(@"指纹认证成功");
                                        
                                        
                                    } else {
                                        // User did not authenticate successfully, look at error and take appropriate action
                                        NSLog(@"指纹认证失败，%@",error.description);
                                        // 错误码 error.code
                                        // -1: 连续三次指纹识别错误
                                        // -2: 在TouchID对话框中点击了取消按钮
                                        // -3: 在TouchID对话框中点击了输入密码按钮
                                        // -4: TouchID对话框被系统取消，例如按下Home或者电源键
                                        // -8: 连续五次指纹识别错误，TouchID功能被锁定，下一次需要输入系统密码
                                    }
                                }];
            
        } else {
            // Could not evaluate policy; look at authError and present an appropriate message to user
            NSLog(@"TouchID设备不可用");
            // TouchID没有设置指纹
            // 关闭密码（系统如果没有设置密码TouchID无法启用）
            
        }
        
        
    }
    
    
    /*对于所有界面的刷新最方便的就是重新设置rootViewController
     
     将keyWindow先变黑，假装loading个几秒，再变回来即可。
     
     如果需要再次回到之前所在页面，再添加相应的跳转VC的方法
     */
}

-(void)changeAction
{
    // 切换主题
    
    if ([[LEETheme currentThemeTag] isEqualToString:@"day"]) {
        
        [LEETheme startTheme:@"night"];
        
    } else {
        
        [LEETheme startTheme:@"day"];
    }
    
    
    
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
