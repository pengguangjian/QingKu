//
//  ChongZhiViewController.m
//  QingKu
//
//  Created by mdb-losaic on 2019/9/2.
//  Copyright © 2019 mcxzfa. All rights reserved.
//

#import "ChongZhiViewController.h"
#import "ChongZhiView.h"

@interface ChongZhiViewController ()

@end

@implementation ChongZhiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = [MDB_UserDefault getSetStringNmae:@"chongzhima"];
    [self drawrightNav];
    
    [self drawUI];
}

-(void)drawrightNav
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 44)];
    view.backgroundColor = [UIColor clearColor];
    
    UIButton *firstButton = [UIButton buttonWithType:UIButtonTypeCustom];
    firstButton.frame = CGRectMake(0, 0, 40, 44);
    [firstButton setImage:[UIImage imageNamed:@"nav_wenhao"] forState:UIControlStateNormal];
    [firstButton addTarget:self action:@selector(rightBarBut) forControlEvents:UIControlEventTouchUpInside];
    firstButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [firstButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -3 *kScale)];
    
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:firstButton];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}

-(void)rightBarBut
{
    
}

-(void)drawUI
{
    ChongZhiView *view = [[ChongZhiView alloc] init];
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
            make.left.equalTo(self.view.mas_safeAreaLayoutGuideLeft);
            make.right.equalTo(self.view.mas_safeAreaLayoutGuideRight);
            make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        }else{
            make.edges.equalTo(self.view).insets(kPaddingNav);
        }
    }];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
