//
//  MDB_UserDefault.m
//  QingKu
//
//  Created by mdb-losaic on 2019/7/29.
//  Copyright © 2019 mcxzfa. All rights reserved.
//

#import "MDB_UserDefault.h"
#import <MBProgressHUD/MBProgressHUD.h>

#import "ChangeLanguage.h"

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

//lb计算文本的宽和高
+(CGSize)countTextSize:(CGSize)size andtextfont:(UIFont *)font andtext:(NSString *)str
{
    CGSize detailsLabSize = size;
    NSDictionary *detailsLabAttribute = @{NSFontAttributeName: font};
    //ios7方法，获取文本需要的size
    CGSize  msize =[str boundingRectWithSize:detailsLabSize options:NSStringDrawingUsesLineFragmentOrigin  attributes:detailsLabAttribute context:nil].size;
    return msize;
}

///设置一行显示不同字体 颜色
+(NSMutableAttributedString *)arrstring:(NSString *)str andstart:(int)istart andend:(int)length andfont:(UIFont *)font andcolor:(UIColor *)color
{
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc]initWithString:str];
    @try {
        [noteStr addAttribute:NSFontAttributeName value:font range:NSMakeRange(istart, length)];
        
        [noteStr addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(istart, length)];
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
    
    return noteStr;
}

///为文字添加横线 icenter 1 中横线
+(NSMutableAttributedString *)arrstring:(NSString *)str andstart:(int)istart andend:(int)length andNSAttributedStringKey:(int)icenter
{
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc]initWithString:str];
    @try {
        if(icenter==1)
        {
            [noteStr addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(istart, length)];
        }
        else
        {
            [noteStr addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(istart, length)];
        }
        
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
    
    return noteStr;
}
////获取本地设置文字
+(NSString *)getSetStringNmae:(NSString *)strname
{
    NSBundle *bundle = [ChangeLanguage bundle];
    
    NSString *str = [bundle localizedStringForKey:strname value:nil table:@"Localizable"];
    return str;
}


@end
