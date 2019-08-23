//
//  TaoXunMainViewController.m
//  QingKu
//
//  Created by mdb-losaic on 2019/6/29.
//  Copyright © 2019 mcxzfa. All rights reserved.
//

#import "GouWuCheMainViewController.h"
#import "GouWuCheMainTableView.h"

@interface GouWuCheMainViewController ()

@end


@implementation GouWuCheMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"购物车";
    
    [self drawUI];
    
}

-(void)drawUI
{
    
    GouWuCheMainTableView *jview = [[GouWuCheMainTableView alloc] init];
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
/*
 夜里造了美丽的噩梦
 想清醒我却抵不过心动
 梦里你是无底的黑洞
 我无力抗拒失重
 我的 意识自 控脉搏流 动
 全被你神秘引力操控
 亲爱的你是危险的迷宫
 我找不到出口
 you took my heart away away away away
 my head is blown away away away away
 你就是传说来自天堂的魔鬼
 you took my heart away away
 away away away away away away
 拜托别对我细心问候
 这是你也不察觉的阴谋
 我讨厌你无心的微笑
 我快无可救药
 你像一个漩涡慢慢让我
 无法抽离一直地坠落
 亲爱的你是优雅的恶魔
 一点一点把握吞没
 you took my heart away away away
 my head is blown away away away
 你就是传说来自天堂的魔鬼
 you took my heart away away
 away away away
 如果你是蛇的诱惑
 你存心迷惑 我才能软弱
 但你是牛顿头上那颗
 若无其事的苹果
 you took my heart away away away
 you took my heart away away away
 you took my heart away away away
 my head is blown away away away
 你就是传说来自天堂的魔鬼
 you took my heart away away away
 away away away away
 */

@end
