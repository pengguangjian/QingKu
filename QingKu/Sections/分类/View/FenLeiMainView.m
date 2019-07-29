//
//  FenLeiMainView.m
//  QingKu
//
//  Created by mdb-losaic on 2019/7/29.
//  Copyright © 2019 mcxzfa. All rights reserved.
//

#import "FenLeiMainView.h"
#import "FenLeiMainTableViewCell.h"
#import "FenLeiMainCollectionViewCell.h"

#import "FenLeiSearchViewController.h"

@interface FenLeiMainView ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource>
{
    
    NSInteger iselecenow;
    UICollectionView *collectview;
}
@end

@implementation FenLeiMainView

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
        iselecenow = 0;
        [self drawUI];
    }
    return self;
}

-(void)drawUI
{
    
    UITableView *tabview = [[UITableView alloc] init];
    [tabview setDelegate:self];
    [tabview setDataSource:self];
    [tabview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [tabview setBackgroundColor:RGB(245, 245, 245)];
    [self addSubview:tabview];
    [tabview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self);
        if(kMainScreenW*0.25<90)
        {
            make.width.offset(90);
        }
        else
        {
            make.width.offset(kMainScreenW*0.25);
        }
    }];
    
    
    float ftempww = kMainScreenW*0.25;
    if(kMainScreenW*0.25<90)
    {
        ftempww = 90;
    }
    UIView *viewline = [[UIView alloc] initWithFrame:CGRectMake(ftempww-1, 55*kScale*5, 1, 1000)];
    [viewline setBackgroundColor:RGB(231, 231, 231)];
    [tabview addSubview:viewline];
    
    
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    collectview = [[UICollectionView alloc] initWithFrame:CGRectMake(ftempww, 0, kMainScreenW-ftempww, kMainScreenH-kTopHeight-kTabBarHeight) collectionViewLayout:layout];
    [collectview setDelegate:self];
    [collectview setDataSource:self];
    [collectview setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:collectview];
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 1;///间距
    [collectview registerClass:[FenLeiMainCollectionViewCell class] forCellWithReuseIdentifier:@"FenLeiMainCollectionViewCell"];
    
}


#pragma mark - UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
 
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *strcell = @"FenLeiMainTableViewCell";
    FenLeiMainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strcell];
    if(!cell)
    {
        cell = [[FenLeiMainTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strcell];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    if(indexPath.row == iselecenow)
    {
        [cell setIsselect:YES];
    }
    else
    {
        [cell setIsselect:NO];
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55*kScale;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    iselecenow = indexPath.row;
    [tableView reloadData];
    [collectview reloadData];
}


#pragma mark - UICollectionViewDelegate && UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return 8;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FenLeiMainCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FenLeiMainCollectionViewCell" forIndexPath:indexPath];
    
    
    
    return cell;
}
//item大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if(kMainScreenW*0.25<90)
    {
        return CGSizeMake((kMainScreenW - 90)/3.1, (kMainScreenW - 90)/3.1*1.3);
    }
    else
    {
        return CGSizeMake((kMainScreenW - kMainScreenW*0.25)/3.1, (kMainScreenW - kMainScreenW*0.25)/3.1*1.3);
    }
}
//调节item边距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(1, 1, 1, 1);
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld",indexPath.row);
    FenLeiSearchViewController *fvc = [[FenLeiSearchViewController alloc] init];
    [self.viewController.navigationController pushViewController:fvc animated:YES];
}

@end
