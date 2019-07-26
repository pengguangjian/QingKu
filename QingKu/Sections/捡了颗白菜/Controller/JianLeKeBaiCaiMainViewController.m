//
//  JingXuanMainViewController.m
//  QingKu
//
//  Created by mdb-losaic on 2019/6/29.
//  Copyright © 2019 mcxzfa. All rights reserved.
//

#import "JianLeKeBaiCaiMainViewController.h"
#import "JianLeKeBaiCaiMainView.h"


@interface JianLeKeBaiCaiMainViewController ()

@end

@implementation JianLeKeBaiCaiMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"捡了颗白菜";
    
    
    [self drawUI];
}

-(void)drawUI
{
    JianLeKeBaiCaiMainView *jview = [[JianLeKeBaiCaiMainView alloc] init];
    [self.view  addSubview:jview];
    float ftopheith =  kStatusBarHeight+44;
    float fother = 0.0;
    if(ftopheith<66)
    {
        ftopheith = 64;
        fother = 0;
    }
    [jview mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
            make.left.equalTo(self.view.mas_safeAreaLayoutGuideLeft);
            make.right.equalTo(self.view.mas_safeAreaLayoutGuideRight);
            make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        }else{
            make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(kTopHeight, 0, 0, 0));
        }
    }];
    
}

@end
