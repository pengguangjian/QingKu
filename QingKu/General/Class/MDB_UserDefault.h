//
//  MDB_UserDefault.h
//  QingKu
//
//  Created by mdb-losaic on 2019/7/29.
//  Copyright © 2019 mcxzfa. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MDB_UserDefault : NSObject

+ (instancetype)defaultInstance;

//提示
+(void)showNotifyHUDwithtext:(NSString *)notify_str inView:(UIView *)view;

//lb计算文本的宽和高
+(CGSize)countTextSize:(CGSize)size andtextfont:(UIFont *)font andtext:(NSString *)str;

@end

NS_ASSUME_NONNULL_END
