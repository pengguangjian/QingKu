//
//  ChangeLanguage.h
//  QingKu
//
//  Created by mdb-losaic on 2019/8/26.
//  Copyright © 2019 mcxzfa. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ChangeLanguage : NSObject


+ (NSBundle *)bundle;//获取当前资源文件

+ (void)initUserLanguage;//初始化语言文件

+ (NSString *)userLanguage;//获取应用当前语言
////en zh-Hans  my
+ (void)setUserLanguage:(NSString *)language;//设置当前语言

@end

NS_ASSUME_NONNULL_END
