//
//  JianLeKeBaiCaiMainScrollView.m
//  QingKu
//
//  Created by mdb-losaic on 2019/7/26.
//  Copyright © 2019 mcxzfa. All rights reserved.
//

#import "JianLeKeBaiCaiMainScrollView.h"
#import "JianLeKeBaiCaiMainItemScrollView.h"


@interface JianLeKeBaiCaiMainScrollView ()<JianLeKeBaiCaiMainTableViewDelegate>
{
    UIScrollView *scvback;
    JianLeKeBaiCaiMainItemScrollView *itemview;
    
    NSMutableArray *arralltabview;
    
}
@end

@implementation JianLeKeBaiCaiMainScrollView

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
    itemview = [[JianLeKeBaiCaiMainItemScrollView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenW, 50*kScale)];
    [self addSubview:itemview];
    
    
    scvback = [[UIScrollView alloc] init];
    [self addSubview:scvback];
    [scvback mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self->itemview);
        make.top.equalTo(self->itemview.mas_bottom);
        make.bottom.equalTo(self);
    }];
    
    arralltabview = [NSMutableArray new];
    for(int i = 0 ; i <6; i++)
    {
        JianLeKeBaiCaiMainTableView *jvc = [[JianLeKeBaiCaiMainTableView alloc] initWithFrame:CGRectMake(kMainScreenW*i, 0, kMainScreenW, kMainScreenH-kTopHeight-kTabBarHeight-50*kScale) andtype:@"1"];
        [scvback addSubview:jvc];
        [jvc setListDelegate:self];
        [jvc setScrollEnabled:NO];
        [arralltabview addObject:jvc];
    }
    _subItemView = arralltabview[0];
    
}
-(void)setAllScrollEnabled:(BOOL)able
{
    for(JianLeKeBaiCaiMainTableView *jvc in arralltabview)
    {
        [jvc setScrollEnabled:able];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    self.contentOffsetc = scrollView.contentOffset;
    [self.scoDelegate scrollViewDidScroll:scrollView];
}

//-(void)setItemContOffset:(CGPoint)point
//{
//    [_subItemView setContentOffset:point];
//}

@end
