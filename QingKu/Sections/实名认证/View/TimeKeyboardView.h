//
//  TimeKeyboardView.h
//  JWT
//
//  Created by MACPRO  on 16/7/20.
//  Copyright © 2016年 com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TimeKeyboardViewDegelate <NSObject>

-(void)changeValue:(NSString *)strvalue;

@end

@interface TimeKeyboardView : UIView<UIPickerViewDelegate,UIPickerViewDataSource>
{
    
    NSArray *arrnowtime;
    
    
    NSMutableArray *arryear;
    NSMutableArray *arrmouth;
    NSMutableArray *arrday;
    NSMutableArray *arrhouar;
    NSMutableArray *arrmintes;
    
    NSString *stryear;
    NSString *strmouth;
    NSString *strday;
    NSString *strhouar;
    NSString *strmintes;
    
    
    UIButton *btqueding;
    UIButton *btquxiao;
    
    UIView *viewline00;
    UIView *viewline01;
    
}
@property (nonatomic , retain) UIView *viewselect;

@property (nonatomic , retain) UIView *viewline1;

@property (nonatomic , retain) UIView *viewline2;

@property (nonatomic , retain) UIPickerView *pickview;

@property (nonatomic , retain) UILabel *lbyear;

@property (nonatomic , retain) UILabel *lbmouth;

@property (nonatomic , retain) UILabel *lbday;

@property (nonatomic , retain) UILabel *lbhouar;

@property (nonatomic , retain) UILabel *lbmintes;

@property (nonatomic , retain) id<TimeKeyboardViewDegelate>degelate;

////多少列  最多5列
@property (nonatomic , assign) int iline;
///是否到当前时间 默认是no
@property (nonatomic , assign) BOOL isNotnowtime;


@end
