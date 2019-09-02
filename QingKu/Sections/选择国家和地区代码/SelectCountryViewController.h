//
//  SelectCountryViewController.h
//  QingKu
//
//  Created by 彭光静 on 2019/9/1.
//  Copyright © 2019 mcxzfa. All rights reserved.
//

#import "RootViewController.h"

NS_ASSUME_NONNULL_BEGIN

@protocol SelectCountryViewControllerDelegete <NSObject>
////缅甸0 中国1
-(void)selectCountry:(NSInteger)iselect;

@end

@interface SelectCountryViewController : RootViewController

@property (nonatomic, weak)id<SelectCountryViewControllerDelegete>delegete;
///默认选中 缅甸0 中国1
@property (nonatomic, assign) int inomoselect;

@end

NS_ASSUME_NONNULL_END
