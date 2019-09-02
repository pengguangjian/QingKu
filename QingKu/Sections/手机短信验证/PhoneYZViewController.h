//
//  PhoneYZViewController.h
//  QingKu
//
//  Created by 彭光静 on 2019/9/1.
//  Copyright © 2019 mcxzfa. All rights reserved.
//

#import "RootViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface PhoneYZViewController : RootViewController
@property (weak, nonatomic) IBOutlet UILabel *lbtopyzm;
@property (weak, nonatomic) IBOutlet UILabel *lbtopminyzm;
@property (weak, nonatomic) IBOutlet UILabel *lbcountrynumber;
@property (weak, nonatomic) IBOutlet UILabel *lbcountry;
@property (weak, nonatomic) IBOutlet UIImageView *imgvCountry;

@property (weak, nonatomic) IBOutlet UIView *viewSelectCountry;
@property (weak, nonatomic) IBOutlet UITextField *fieldPhone;
@property (weak, nonatomic) IBOutlet UITextField *fieldCode;
@property (weak, nonatomic) IBOutlet UIButton *btCode;
@property (weak, nonatomic) IBOutlet UIButton *btok;

@end

NS_ASSUME_NONNULL_END
