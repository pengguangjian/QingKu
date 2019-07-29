//
//  MDB_UserDefault.m
//  QingKu
//
//  Created by mdb-losaic on 2019/7/29.
//  Copyright © 2019 mcxzfa. All rights reserved.
//

#import "MDB_UserDefault.h"
#import <MBProgressHUD/MBProgressHUD.h>


static BOOL kIsRightInit = NO;


@implementation MDB_UserDefault

+ (instancetype)defaultInstance {
    static dispatch_once_t onceToken;
    static MDB_UserDefault * singleTon = nil;
    kIsRightInit = YES;
    dispatch_once(&onceToken, ^{
        singleTon = [[self alloc] init];
    });
    
    kIsRightInit = NO;
    return singleTon;
}
//提示
+(void)showNotifyHUDwithtext:(NSString *)notify_str inView:(UIView *)view{
    if([notify_str isEqual:[NSNull null]])
    {
        notify_str = @"";
    }
    notify_str = [NSString nullToString:notify_str];
    if (notify_str) {
        if(view==nil)return;
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.margin = 10;
        hud.bezelView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.8];
        hud.bezelView.layer.cornerRadius = 4.f;
        hud.detailsLabel.text = notify_str;
        hud.detailsLabel.font = [UIFont systemFontOfSize:14.f];
        hud.detailsLabel.textColor = [UIColor whiteColor];
        [hud hideAnimated:YES afterDelay:2.5];
    }
}



@end
