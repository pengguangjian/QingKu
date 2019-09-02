//
//  ZhiWenYanZhenView.m
//  QingKu
//
//  Created by mdb-losaic on 2019/9/2.
//  Copyright © 2019 mcxzfa. All rights reserved.
//

#import "ZhiWenYanZhenView.h"
#import <LocalAuthentication/LAContext.h>
#import <CoreImage/CoreImage.h>


@implementation ZhiWenYanZhenView

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
        
        [self zhiwenYanZhen];
    }
    return self;
}

-(void)drawUI
{
    [self setBackgroundColor:[UIColor whiteColor]];
    
    UIImageView *imgvzhiwen = [[UIImageView alloc] init];
    [imgvzhiwen setContentMode:UIViewContentModeScaleAspectFit];
    [imgvzhiwen setImage:[UIImage imageNamed:@"zhiwen"]];
    [self addSubview:imgvzhiwen];
    [imgvzhiwen mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.offset(110*kScale);
        make.size.sizeOffset(CGSizeMake(110*kScale, 110*kScale));
    }];
    
    UILabel *lbbottommin = [[UILabel alloc] init];
    [lbbottommin setText:[MDB_UserDefault getSetStringNmae:@"kaitongmimazhifuqingyanhiwen"]];
    [lbbottommin setTextColor:RGB(150, 150, 150)];
    [lbbottommin setTextAlignment:NSTextAlignmentCenter];
    [lbbottommin setFont:[UIFont systemFontOfSize:14]];
    [self addSubview:lbbottommin];
    [lbbottommin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(imgvzhiwen.mas_bottom).offset(30);
        make.height.offset(20);
    }];
    
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


@end
