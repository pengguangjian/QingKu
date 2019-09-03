//
//  MDB_UserDefault.h
//  QingKu
//
//  Created by mdb-losaic on 2019/7/29.
//  Copyright © 2019 mcxzfa. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


static UIEdgeInsets kPaddingNav = {64,0,0,0};

@interface MDB_UserDefault : NSObject

+ (instancetype)defaultInstance;

//提示
+(void)showNotifyHUDwithtext:(NSString *)notify_str inView:(UIView *)view;

//lb计算文本的宽和高
+(CGSize)countTextSize:(CGSize)size andtextfont:(UIFont *)font andtext:(NSString *)str;

///设置一行显示不同字体 颜色
+(NSMutableAttributedString *)arrstring:(NSString *)str andstart:(int)istart andend:(int)length andfont:(UIFont *)font andcolor:(UIColor *)color;

///为文字添加横线 icenter 1 中横线
+(NSMutableAttributedString *)arrstring:(NSString *)str andstart:(int)istart andend:(int)length andNSAttributedStringKey:(int)icenter;

////获取本地设置文字
+(NSString *)getSetStringNmae:(NSString *)strname;


@end

NS_ASSUME_NONNULL_END
