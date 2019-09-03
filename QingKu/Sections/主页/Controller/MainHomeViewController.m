//
//  MainHomeViewController.m
//  QingKu
//
//  Created by mdb-losaic on 2019/8/26.
//  Copyright © 2019 mcxzfa. All rights reserved.
//

#import "MainHomeViewController.h"
//#import "ChangeLanguage.h"
//#import <LocalAuthentication/LAContext.h>
//#import <CoreImage/CoreImage.h>


#import "MainHomeView.h"


@interface MainHomeViewController ()
{
    UIView *viewnavs;
    MainHomeView *mHomeView;
}
@end

@implementation MainHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self drawnav];
    [self drawUI];
}

-(void)drawnav
{
    UIView *viewtop = [[UIView alloc] init];
    viewtop.lee_theme.LeeConfigBackgroundColor(@"main_homenav_color");
    [self.navigationController.navigationBar addSubview:viewtop];
    [viewtop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.navigationController.navigationBar);
    }];
    viewnavs = viewtop;
    
    
    UILabel *lbmomo = [[UILabel alloc] init];
    [lbmomo setText:@"MOMO"];
    lbmomo.lee_theme.LeeConfigTextColor(@"main_main_color");
    [lbmomo setTextAlignment:NSTextAlignmentLeft];
    [lbmomo setFont:[UIFont systemFontOfSize:24]];
    [viewtop addSubview:lbmomo];
    [lbmomo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.top.bottom.equalTo(viewtop);
        make.width.offset(200);
    }];
}

-(void)viewWillAppear:(BOOL)animated
{
    [viewnavs setHidden:NO];
    
    if(mHomeView!=nil)
    {
        [mHomeView loadLbText];
    }
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [viewnavs setHidden:YES];
}

-(void)drawUI
{
    MainHomeView *mview = [[MainHomeView alloc] init];
    [self.view addSubview:mview];
    [mview mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
            make.left.equalTo(self.view.mas_safeAreaLayoutGuideLeft);
            make.right.equalTo(self.view.mas_safeAreaLayoutGuideRight);
            make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        }else{
            make.edges.equalTo(self.view).insets(kPaddingNav);
        }
    }];
    mHomeView = mview;
}

//
//-(void)setAllTextValue
//{
//    [btchange setTitle:[self getStringNmae:@"bottomName"] forState:UIControlStateNormal];
//}
//
//-(NSString *)getStringNmae:(NSString *)strname
//{
//    NSBundle *bundle = [ChangeLanguage bundle];
//
//    NSString *str = [bundle localizedStringForKey:strname value:nil table:@"Localizable"];
//    return str;
//}
//
/////更改语言
//-(void)itemAction:(UIButton *)sender
//{
//    if(sender.tag==0)
//    {
//        [ChangeLanguage setUserLanguage:@"zh-Hans"];
//    }
//    else if(sender.tag==1)
//    {
//        [ChangeLanguage setUserLanguage:@"en"];
//    }
//    if(sender.tag==2)
//    {
//        [ChangeLanguage setUserLanguage:@"my"];///my_ZG  my_MM
//    }
//    if(sender.tag<3)
//    {
//        [self setAllTextValue];
//    }
//    else if (sender.tag == 3)
//    {///指纹验证
//
//
////        [self showerWeiMa];
//
////        [self zhiwenYanZhen];
//
//        return;
//
//    }
//
//
//    /*对于所有界面的刷新最方便的就是重新设置rootViewController
//
//     将keyWindow先变黑，假装loading个几秒，再变回来即可。
//
//     如果需要再次回到之前所在页面，再添加相应的跳转VC的方法
//     */
//}
//
//////手机指纹验证
//-(void)zhiwenYanZhen
//{
//    LAContext *myContext = [[LAContext alloc] init];
//    NSError *authError = nil;
//    NSString *myLocalizedReasonString = @"我们需要验证您的指纹来确认你的身份";
//    // 判断设备是否支持指纹识别
//    if ([myContext canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&authError]) {
//        // 指纹识别只判断当前用户是否机主
//        [myContext evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
//                  localizedReason:myLocalizedReasonString
//                            reply:^(BOOL success, NSError *error) {
//                                if (success) {
//                                    // User authenticated successfully, take appropriate action
//                                    NSLog(@"指纹认证成功");
//
//
//                                } else {
//                                    // User did not authenticate successfully, look at error and take appropriate action
//                                    NSLog(@"指纹认证失败，%@",error.description);
//                                    // 错误码 error.code
//                                    // -1: 连续三次指纹识别错误
//                                    // -2: 在TouchID对话框中点击了取消按钮
//                                    // -3: 在TouchID对话框中点击了输入密码按钮
//                                    // -4: TouchID对话框被系统取消，例如按下Home或者电源键
//                                    // -8: 连续五次指纹识别错误，TouchID功能被锁定，下一次需要输入系统密码
//                                }
//                            }];
//
//    } else {
//        // Could not evaluate policy; look at authError and present an appropriate message to user
//        NSLog(@"TouchID设备不可用");
//        // TouchID没有设置指纹
//        // 关闭密码（系统如果没有设置密码TouchID无法启用）
//
//    }
//}
//////生成二维码
//- (void)showerWeiMa{
//    // 1. 创建一个二维码滤镜实例(CIFilter)
//    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
//    // 滤镜恢复默认设置
//    [filter setDefaults];
//
//    // 2. 给滤镜添加数据
//    NSString *string = @"www.baidu.com";
//    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
//    // 使用KVC的方式给filter赋值
//    [filter setValue:data forKeyPath:@"inputMessage"];
//
//    // 3. 生成二维码
//    CIImage *image = [filter outputImage];
//
//    //4.在中心增加一张图片
//    UIImage *img = [self createNonInterpolatedUIImageFormCIImage:image withSize:kMainScreenW*0.7];
//
//    //5.把中央图片划入二维码里面
//    //5.1开启图形上下文
//    UIGraphicsBeginImageContext(img.size);
//    //5.2将二维码的图片画入
//    [img drawInRect:CGRectMake(0, 0, img.size.width, img.size.height)];
//    UIImage *centerImg = [UIImage imageNamed:@"home_Share_item0"];
//    CGFloat centerW=img.size.width*0.3;
//    CGFloat centerH=centerW;
//    CGFloat centerX=(img.size.width-centerW)*0.5;
//    CGFloat centerY=(img.size.height -centerH)*0.5;
//    [centerImg drawInRect:CGRectMake(centerX, centerY, centerW, centerH)];
//    //5.3获取绘制好的图片
//    UIImage *finalImg=UIGraphicsGetImageFromCurrentImageContext();
//    //5.4关闭图像上下文
//    UIGraphicsEndImageContext();
//
//    ///显示
//    UIImageView *imgvc = [[UIImageView alloc] init];
//    [self.view addSubview:imgvc];
//    [imgvc mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.equalTo(self.view);
//        make.size.sizeOffset(CGSizeMake(kMainScreenW*0.7, kMainScreenW*0.7));
//    }];
//    imgvc.image = finalImg;
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [imgvc removeFromSuperview];
//    });
//    //6.显示最终二维码
////    self.imageView.image = finalImg;
//}
///**
// *  调用该方法处理图像变清晰
// *  根据CIImage生成指定大小的UIImage
// *
// *  @param image CIImage
// *  @param size  图片宽度以及高度
// */
//- (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size
//{
//    CGRect extent = CGRectIntegral(image.extent);
//    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
//
//    //1.创建bitmap;
//    size_t width = CGRectGetWidth(extent) * scale;
//    size_t height = CGRectGetHeight(extent) * scale;
//    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
//    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
//    CIContext *context = [CIContext contextWithOptions:nil];
//    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
//    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
//    CGContextScaleCTM(bitmapRef, scale, scale);
//    CGContextDrawImage(bitmapRef, extent, bitmapImage);
//
//    //2.保存bitmap到图片
//    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
//    CGContextRelease(bitmapRef);
//    CGImageRelease(bitmapImage);
//    return [UIImage imageWithCGImage:scaledImage];
//}
//
//-(void)changeAction
//{
//    // 切换主题
//
//    if ([[LEETheme currentThemeTag] isEqualToString:@"day"]) {
//
//        [LEETheme startTheme:@"night"];
//
//    } else {
//
//        [LEETheme startTheme:@"day"];
//    }
//
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
