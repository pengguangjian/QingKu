//
//  LoginView.m
//  QingKu
//
//  Created by 彭光静 on 2019/8/31.
//  Copyright © 2019 mcxzfa. All rights reserved.
//

#import "LoginView.h"
#import "PhoneYZViewController.h"
#import "ForgetPasswordViewController.h"

#import "MainHomeViewController.h"


#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "SUCache.h"
#import <UIKit/UIKit.h>
#import "UIImageView+CreateByUrl.h"

#import <GoogleSignIn/GoogleSignIn.h>


@interface LoginView ()<GIDSignInDelegate>
{
    ///头部当前选中
    UIButton *btnowSeletc;
    
    
    
}
@end

@implementation LoginView

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
        
        ///获取Facebook登陆缓存
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(_updateContent:)
                                                     name:FBSDKProfileDidChangeNotification
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(_accessTokenChanged:)
                                                     name:FBSDKAccessTokenDidChangeNotification
                                                   object:nil];
        
        
        SUCacheItem *item = [SUCache itemForSlot:0];
        [self labelDisplayWithProfile:item.profile];
        
        
    }
    return self;
}

-(void)drawUI
{
    UIScrollView *scvback = [[UIScrollView alloc] init];
    [scvback setShowsVerticalScrollIndicator:NO];
    [self addSubview:scvback];
    [scvback mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    if (@available(iOS 11.0, *)) {
        scvback.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    UIImageView *imgvbc = [[UIImageView alloc] init];
    UIImage *image = [UIImage imageNamed:@"login_back"];
    [imgvbc setImage:image];
    [imgvbc setContentMode:UIViewContentModeScaleAspectFit];
    [scvback addSubview:imgvbc];
    [imgvbc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.offset(0);
        make.width.offset(kMainScreenW);
        make.height.offset(image.size.height*kMainScreenW/image.size.width);
    }];
    
    
    NSArray *arrtitle = @[@"缅甸文",@"简体中文",@"English"];
    for(int i = 0 ; i < 3; i++)
    {
        UIButton *btitem = [[UIButton alloc] init];
        [btitem setTitle:arrtitle[i] forState:UIControlStateNormal];
        [btitem setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btitem.titleLabel setFont:[UIFont systemFontOfSize:16]];
        [btitem setTag:i];
        [btitem addTarget:self action:@selector(topItemAction:) forControlEvents:UIControlEventTouchUpInside];
        [scvback addSubview:btitem];
        [btitem mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(imgvbc).offset(-10);
            make.left.offset(kMainScreenW/3.0*i);
            make.width.offset(kMainScreenW/3.0);
            make.height.offset(50*kScale);
            
        }];
        
        UIView *viewline = [[UIView alloc] init];
        [viewline setBackgroundColor:[UIColor whiteColor]];
        [viewline setTag:100];
        [btitem addSubview:viewline];
        [viewline mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(btitem);
            make.bottom.equalTo(btitem);
            make.height.offset(2);
            make.width.offset(80);
        }];
        [viewline.layer setMasksToBounds:YES];
        [viewline.layer setCornerRadius:1];
        [viewline setHidden:YES];
        if(i==1)
        {
            btnowSeletc = btitem;
            [viewline setHidden:NO];
            [btitem.titleLabel setFont:[UIFont boldSystemFontOfSize:20]];
        }
    }
    
    ///
    UIView *viewcenter = [[UIView alloc] init];
    [viewcenter setBackgroundColor:[UIColor whiteColor]];
    [viewcenter.layer setMasksToBounds:NO];
    [viewcenter.layer setCornerRadius:5];
    viewcenter.layer.shadowColor = RGBAlpha(0, 0, 0, 0.5).CGColor;
    // 设置阴影偏移量
    viewcenter.layer.shadowOffset = CGSizeMake(0,0);
    // 设置阴影透明度
    viewcenter.layer.shadowOpacity = 1;
    // 设置阴影半径
    viewcenter.layer.shadowRadius = 3;
    [scvback addSubview:viewcenter];
    [viewcenter mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(30);
        make.right.equalTo(self).offset(-30);
        make.top.equalTo(self->btnowSeletc.mas_bottom).offset(35);
    }];
    [self drawCenterView:viewcenter];
    ///
    
    
    [scvback mas_makeConstraints:^(MASConstraintMaker *make) {
        
        if(kMainScreenH<600)
        {
            make.bottom.equalTo(viewcenter.mas_bottom).offset(100);
        }
        else
        {
            make.height.offset(kMainScreenH);
            
        }
    }];
    
    UILabel *lbcomp = [[UILabel alloc] init];
    [lbcomp setText:[MDB_UserDefault getSetStringNmae:@"kaifagongshi"]];
    lbcomp.lee_theme.LeeConfigTextColor(@"main_textGraw_color");
    [lbcomp setTextAlignment:NSTextAlignmentCenter];
    [lbcomp setFont:[UIFont systemFontOfSize:10]];
    [scvback addSubview:lbcomp];
    [lbcomp mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(15);
        make.left.offset(10);
        make.width.offset(kMainScreenW - 20);
        make.bottom.equalTo(scvback.mas_bottom).offset(-25);
    }];
    
    UILabel *lbcompother = [[UILabel alloc] init];
    [lbcompother setText:@"Copright@2018-2019,jtktkj.All Rights Reserved"];
    lbcompother.lee_theme.LeeConfigTextColor(@"main_textGraw_color");
    [lbcompother setTextAlignment:NSTextAlignmentCenter];
    [lbcompother setFont:[UIFont systemFontOfSize:10]];
    [scvback addSubview:lbcompother];
    [lbcompother mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbcomp.mas_bottom);
        make.height.left.right.equalTo(lbcomp);
    }];
    
}

-(void)drawCenterView:(UIView *)view
{
    
    UIView *viewline = [[UIView alloc] init];
    viewline.lee_theme.LeeConfigBackgroundColor(@"main_main_color");
    [view addSubview:viewline];
    [viewline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(40);
        make.left.offset(50);
        make.right.equalTo(view).offset(-50);
        make.height.offset(1);
    }];
    
    UILabel *lbname = [[UILabel alloc] init];
    [lbname setText:[MDB_UserDefault getSetStringNmae:@"denglu"]];
    lbname.lee_theme.LeeConfigTextColor(@"main_main_color");
    [lbname setTextAlignment:NSTextAlignmentCenter];
    [lbname setFont:[UIFont systemFontOfSize:15]];
    [lbname setBackgroundColor:[UIColor whiteColor]];
    [view addSubview:lbname];
    [lbname mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(viewline);
        make.width.offset(40);
    }];
    
    ///
    UIImageView *imgvname = [[UIImageView alloc] init];
    [imgvname setImage:[UIImage imageNamed:@"login_user"]];
    [view addSubview:imgvname];
    [imgvname mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(20);
        make.top.equalTo(viewline.mas_bottom).offset(50);
        make.size.sizeOffset(CGSizeMake(20, 20));
    }];

    
    UITextField *fieldname = [[UITextField alloc] init];
    [fieldname setTextAlignment:NSTextAlignmentLeft];
    [fieldname setFont:[UIFont systemFontOfSize:14]];
    [fieldname setTextColor:RGB(50, 50, 50)];
    [fieldname setPlaceholder:[MDB_UserDefault getSetStringNmae:@"qingshuruyonhum"]];
    [view addSubview:fieldname];
    [fieldname mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imgvname.mas_right).offset(15);
        make.centerY.equalTo(imgvname);
        make.right.equalTo(view).offset(-10);
        make.height.offset(40);
    }];
    
    UIView *viewline1 = [[UIView alloc] init];
    viewline1.lee_theme.LeeConfigBackgroundColor(@"main_line_color");
    [view addSubview:viewline1];
    [viewline1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(fieldname);
        make.height.offset(1);
    }];
    
    ///
    UIImageView *imgvpass = [[UIImageView alloc] init];
    [imgvpass setImage:[UIImage imageNamed:@"login_mima"]];
    [view addSubview:imgvpass];
    [imgvpass mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imgvname);
        make.top.equalTo(viewline1.mas_bottom).offset(30);
        make.size.equalTo(imgvname);
    }];
    
    UITextField *fieldpass = [[UITextField alloc] init];
    [fieldpass setTextAlignment:NSTextAlignmentLeft];
    [fieldpass setFont:[UIFont systemFontOfSize:14]];
    [fieldpass setTextColor:RGB(50, 50, 50)];
    [fieldpass setPlaceholder:[MDB_UserDefault getSetStringNmae:@"qingshurumima"]];
    [fieldpass setSecureTextEntry:YES];
    [view addSubview:fieldpass];
    [fieldpass mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imgvpass.mas_right).offset(15);
        make.centerY.equalTo(imgvpass);
        make.right.height.equalTo(fieldname);
    }];
    
    UIView *viewline2 = [[UIView alloc] init];
    viewline2.lee_theme.LeeConfigBackgroundColor(@"main_line_color");
    [view addSubview:viewline2];
    [viewline2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(fieldpass);
        make.height.offset(1);
    }];
    
    ////
    UIButton *btwangjimima = [[UIButton alloc] init];
    [btwangjimima setTitle:[MDB_UserDefault getSetStringNmae:@"wangjimima"] forState:UIControlStateNormal];
    btwangjimima.lee_theme.LeeConfigButtonTitleColor(@"main_main_color", UIControlStateNormal);
    [btwangjimima.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [btwangjimima addTarget:self action:@selector(wangjimmAction) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btwangjimima];
    [btwangjimima mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewline2.mas_bottom);
        make.right.equalTo(view).offset(-10);
        make.height.offset(40);
    }];
    
    UIButton *btlogin = [[UIButton alloc] init];
    [btlogin setTitle:[MDB_UserDefault getSetStringNmae:@"denglu"] forState:UIControlStateNormal];
    btlogin.lee_theme.LeeConfigButtonTitleColor(@"main_write_color", UIControlStateNormal);
    btlogin.lee_theme.LeeConfigBackgroundColor(@"main_main_color");
    [btlogin.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [btlogin addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btlogin];
    [btlogin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(btwangjimima.mas_bottom).offset(10);
        make.left.offset(12);
        make.height.offset(45*kScale);
        make.right.equalTo(view).offset(-12);
    }];
    [btlogin.layer setMasksToBounds:YES];
    [btlogin.layer setCornerRadius:45*kScale/2.0];
    
    
    UILabel *lbother = [[UILabel alloc] init];
    [lbother setText:[MDB_UserDefault getSetStringNmae:@"otherdenglufs"]];
    lbother.lee_theme.LeeConfigTextColor(@"main_textGraw_color");
    [lbother setTextAlignment:NSTextAlignmentCenter];
    [lbother setFont:[UIFont systemFontOfSize:13]];
    [view addSubview:lbother];
    [lbother mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(btlogin.mas_bottom).offset(30);
        make.width.offset(250);
        make.centerX.equalTo(view);
        make.height.offset(20);
    }];
    
    NSArray *arrimages = @[@"login_facebook",@"login_google",@"login_duanxin"];
    NSArray *arrtitles = @[[MDB_UserDefault getSetStringNmae:@"Facebook"],[MDB_UserDefault getSetStringNmae:@"google"],[MDB_UserDefault getSetStringNmae:@"shoujiduanxin"]];
    UIView *viewleft = nil;
    for(int i = 0; i < arrimages.count; i++)
    {
        UIButton *btitem = [[UIButton alloc] init];
        [btitem setImage:[UIImage imageNamed:arrimages[i]] forState:UIControlStateNormal];
        [btitem setTitle:arrtitles[i] forState:UIControlStateNormal];
        btitem.lee_theme.LeeConfigButtonTitleColor(@"main_textGraw_color", UIControlStateNormal);
        [btitem.titleLabel setFont:[UIFont systemFontOfSize:13]];
//        [btitem setTitleEdgeInsets:UIEdgeInsetsMake(0, -4, 0, 0)];
        [btitem setTag:i];
        [view addSubview:btitem];
        [btitem addTarget:self action:@selector(otherLoginAction:) forControlEvents:UIControlEventTouchUpInside];
        float fitemw = (kMainScreenW-60)/3.0;
        [btitem mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lbother.mas_bottom).offset(20);
            make.height.offset(35);
            make.width.offset(fitemw);
            make.left.offset(fitemw*i);
            
        }];
        viewleft = btitem;
    }
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(viewleft.mas_bottom).offset(20);
    }];
    
}


#pragma mark - 语言选择
-(void)topItemAction:(UIButton *)sender
{
    if(sender.tag == btnowSeletc.tag)return;
    [btnowSeletc.titleLabel setFont:[UIFont systemFontOfSize:16]];
    UIView *viewline = [btnowSeletc viewWithTag:100];
    [viewline setHidden:YES];
    
    btnowSeletc = sender;
    [btnowSeletc.titleLabel setFont:[UIFont boldSystemFontOfSize:20]];
    UIView *viewlinen = [btnowSeletc viewWithTag:100];
    [viewlinen setHidden:NO];
    
    
    
}
#pragma mark - 忘记密码
-(void)wangjimmAction
{
    ForgetPasswordViewController *fvc = [[ForgetPasswordViewController alloc] init];
    [self.viewController.navigationController pushViewController:fvc animated:YES];
}
#pragma mark - 登陆
-(void)loginAction
{
    MainHomeViewController *mvc = [[MainHomeViewController alloc] init];
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:mvc];
    [self.window setRootViewController:nvc];
}
#pragma mark - 其它登陆方式
-(void)otherLoginAction:(UIButton *)sender
{
    switch (sender.tag) {
        case 0:
        {
            [self facebookLogin];
        }
            break;
        case 1:
        {
            [self googleLogin];
        }
            break;
        case 2:
        {
            PhoneYZViewController *pvc = [[PhoneYZViewController alloc] init];
            [self.viewController.navigationController pushViewController:pvc animated:YES];
        }
            break;
        default:
            break;
    }
}

#pragma mark -///google登录
-(void)googleLogin
{
    GIDSignIn* signIn = [GIDSignIn sharedInstance];
    signIn.clientID = @"564164296159-0lpeiinen6cfitlt6t8n60nembpmbe4b.apps.googleusercontent.com";
    signIn.shouldFetchBasicProfile = YES;
    signIn.delegate = self;
    signIn.presentingViewController = self.viewController;
    [GIDSignIn sharedInstance].scopes = @[ @"email" ];
    
    [[GIDSignIn sharedInstance] signIn];
    
}

- (void)signIn:(GIDSignIn *)signIn
didSignInForUser:(GIDGoogleUser *)user
     withError:(NSError *)error
{
    ///成功
    NSLog(@"%@",user.userID);
}
- (void)signIn:(GIDSignIn *)signIn
didDisconnectWithUser:(GIDGoogleUser *)user
     withError:(NSError *)error
{
    ///失败
    
}

#pragma mark -///facebook登录
-(void)facebookLogin
{
    NSInteger slot = 0;
    FBSDKAccessToken *token = [SUCache itemForSlot:slot].token;
    if (token) {
        [self autoLoginWithToken:token];
    }
    else {
        [self newLogin];
    }
    
}

- (void)autoLoginWithToken:(FBSDKAccessToken *)token {
    [FBSDKAccessToken setCurrentAccessToken:token];
    FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:nil];
    [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
        //token过期，删除存储的token和profile
        if (error) {
            NSLog(@"The user token is no longer valid.");
            NSInteger slot = 0;
            [SUCache deleteItemInSlot:slot];
            [FBSDKAccessToken setCurrentAccessToken:nil];
            [FBSDKProfile setCurrentProfile:nil];
        }
        //做登录完成的操作
        else {
            
        }
    }];
}

- (void)newLogin {
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login
     logInWithReadPermissions: @[@"public_profile"]
     fromViewController:self.viewController
     handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
         NSLog(@"facebook login result.grantedPermissions = %@,error = %@",result.grantedPermissions,error);
         if (error) {
             NSLog(@"Process error");
         } else if (result.isCancelled) {
             NSLog(@"Cancelled");
         } else {
             NSLog(@"Logged in");
         }
     }];
}



#pragma mark - Notification

- (void)_updateContent:(NSNotification *)notification {
    FBSDKProfile *profile = notification.userInfo[FBSDKProfileChangeNewKey];
    [self labelDisplayWithProfile:profile];
}

- (void)_accessTokenChanged:(NSNotification *)notification
{
    FBSDKAccessToken *token = notification.userInfo[FBSDKAccessTokenChangeNewKey];
    if (!token) {
        [FBSDKAccessToken setCurrentAccessToken:nil];
        [FBSDKProfile setCurrentProfile:nil];
    } else {
        NSInteger slot = 0;
        SUCacheItem *item = [SUCache itemForSlot:slot] ?: [[SUCacheItem alloc] init];
        if (![item.token isEqualToAccessToken:token]) {
            item.token = token;
            [SUCache saveItem:item slot:slot];
        }
    }
}

#pragma mark - other
//这是facebook sdk中自带的button样式
- (void)addFacebookButton {
    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
    loginButton.center = self.center;
    [self addSubview:loginButton];
}

- (void)labelDisplayWithProfile:(FBSDKProfile *)profile{
    NSInteger slot = 0;
    if (profile) {
        SUCacheItem *cacheItem = [SUCache itemForSlot:slot];
        cacheItem.profile = profile;
        [SUCache saveItem:cacheItem slot:slot];
        //        self.infoLabel.text = [NSString stringWithFormat:@"name = %@,userID = %@",cacheItem.profile.name,cacheItem.profile.userID];
        //       NSURL *imgURL = [profile imageURLForPictureMode:FBSDKProfilePictureModeNormal size:self.pictureView.frame.size];
        //        [self.pictureView setImageByUrl:[NSString stringWithFormat:@"%@",imgURL]];
        
    }
}

@end
