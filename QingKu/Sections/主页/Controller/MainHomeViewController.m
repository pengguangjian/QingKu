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
#import <CoreImage/CoreImage.h>

#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "SUCache.h"
#import <UIKit/UIKit.h>
#import "UIImageView+CreateByUrl.h"

#import <GoogleSignIn/GoogleSignIn.h>

@interface MainHomeViewController ()<GIDSignInDelegate>
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
        
        
//        [self showerWeiMa];
        
//        [self zhiwenYanZhen];
        
//        [self otherLogin];
        
        [self googleLogin];
        
        return;
        
    }
    
    
    /*对于所有界面的刷新最方便的就是重新设置rootViewController
     
     将keyWindow先变黑，假装loading个几秒，再变回来即可。
     
     如果需要再次回到之前所在页面，再添加相应的跳转VC的方法
     */
}

////手机指纹验证
-(void)zhiwenYanZhen
{
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

#pragma mark -///google登录
-(void)googleLogin
{
    GIDSignIn* signIn = [GIDSignIn sharedInstance];
    signIn.clientID = @"564164296159-0lpeiinen6cfitlt6t8n60nembpmbe4b.apps.googleusercontent.com";
    signIn.shouldFetchBasicProfile = YES;
    signIn.delegate = self;
    signIn.presentingViewController = self;
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
-(void)otherLogin
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
     fromViewController:self
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
    loginButton.center = self.view.center;
    [self.view addSubview:loginButton];
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

/////


////生成二维码
- (void)showerWeiMa{
    // 1. 创建一个二维码滤镜实例(CIFilter)
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // 滤镜恢复默认设置
    [filter setDefaults];
    
    // 2. 给滤镜添加数据
    NSString *string = @"www.baidu.com";
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    // 使用KVC的方式给filter赋值
    [filter setValue:data forKeyPath:@"inputMessage"];
    
    // 3. 生成二维码
    CIImage *image = [filter outputImage];
    
    //4.在中心增加一张图片
    UIImage *img = [self createNonInterpolatedUIImageFormCIImage:image withSize:kMainScreenW*0.7];
    
    //5.把中央图片划入二维码里面
    //5.1开启图形上下文
    UIGraphicsBeginImageContext(img.size);
    //5.2将二维码的图片画入
    [img drawInRect:CGRectMake(0, 0, img.size.width, img.size.height)];
    UIImage *centerImg = [UIImage imageNamed:@"home_Share_item0"];
    CGFloat centerW=img.size.width*0.3;
    CGFloat centerH=centerW;
    CGFloat centerX=(img.size.width-centerW)*0.5;
    CGFloat centerY=(img.size.height -centerH)*0.5;
    [centerImg drawInRect:CGRectMake(centerX, centerY, centerW, centerH)];
    //5.3获取绘制好的图片
    UIImage *finalImg=UIGraphicsGetImageFromCurrentImageContext();
    //5.4关闭图像上下文
    UIGraphicsEndImageContext();
    
    ///显示
    UIImageView *imgvc = [[UIImageView alloc] init];
    [self.view addSubview:imgvc];
    [imgvc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.sizeOffset(CGSizeMake(kMainScreenW*0.7, kMainScreenW*0.7));
    }];
    imgvc.image = finalImg;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [imgvc removeFromSuperview];
    });
    //6.显示最终二维码
//    self.imageView.image = finalImg;
}
/**
 *  调用该方法处理图像变清晰
 *  根据CIImage生成指定大小的UIImage
 *
 *  @param image CIImage
 *  @param size  图片宽度以及高度
 */
- (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size
{
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    //1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    //2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
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
