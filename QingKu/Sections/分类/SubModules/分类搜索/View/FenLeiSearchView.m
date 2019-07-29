//
//  FenLeiSearchView.m
//  QingKu
//
//  Created by mdb-losaic on 2019/7/29.
//  Copyright © 2019 mcxzfa. All rights reserved.
//

#import "FenLeiSearchView.h"
#import "JianLeKeBaiCaiMainItemScrollView.h"
#import "FenLeiSearchTableView.h"

@interface FenLeiSearchView () <JianLeKeBaiCaiMainItemScrollViewDelegate,UIScrollViewDelegate>
{
    JianLeKeBaiCaiMainItemScrollView *jview;
    UIScrollView *scvback;
    
    NSMutableArray *arralltabview;
}
@end

@implementation FenLeiSearchView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        [self drawUI];
    }
    return self;
}

-(void)drawUI
{
    
    jview = [[JianLeKeBaiCaiMainItemScrollView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenW, 50*kScale)];
    [jview setDelegate:self];
    [jview bindListData:@[@"全部",@"价格从低到高",@"销量",@"库存"]];
    [self addSubview:jview];
    
    scvback = [[UIScrollView alloc] init];
    [self addSubview:scvback];
    [scvback mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self->jview);
        make.top.equalTo(self->jview.mas_bottom);
        make.bottom.equalTo(self);
    }];
    [scvback setContentSize:CGSizeMake(kMainScreenW*4, 0)];
    [scvback setPagingEnabled:YES];
    [scvback setDelegate:self];
    [scvback setTag:110];
    
    arralltabview = [NSMutableArray new];
    for(int i = 0 ; i <4; i++)
    {
        FenLeiSearchTableView *jvc = [[FenLeiSearchTableView alloc] initWithFrame:CGRectMake(kMainScreenW*i, 0, kMainScreenW, kMainScreenH-kTopHeight-50*kScale) andtype:@"1"];
        [scvback addSubview:jvc];
        [arralltabview addObject:jvc];
    }
    
}


#pragma mark - JianLeKeBaiCaiMainItemScrollViewDelegate
-(void)btNowSelectItem:(NSInteger)item
{
    if(item>=0&&item<arralltabview.count)
    {
        [scvback setContentOffset:CGPointMake(kMainScreenW*item, 0)];
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if(scrollView.tag==110)
    {
        int inum = scrollView.contentOffset.x/kMainScreenW;
        if(inum>=0&&inum<arralltabview.count)
        {
            [jview btselectItem:inum];
        }
    }
}

@end
