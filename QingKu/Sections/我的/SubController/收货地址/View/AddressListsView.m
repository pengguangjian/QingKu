//
//  AddressListsView.m
//  QingKu
//
//  Created by mdb-losaic on 2019/7/31.
//  Copyright © 2019 mcxzfa. All rights reserved.
//

#import "AddressListsView.h"
#import "AddressListsTableViewCell.h"
#import "AddressAddViewController.h"

@interface AddressListsView () <UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tabview;
    
}
@end

@implementation AddressListsView

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
    
    tabview = [[UITableView alloc] init];
    [tabview setDelegate:self];
    [tabview setDataSource:self];
    [tabview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self addSubview:tabview];
    [tabview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self);
        make.width.offset(kMainScreenW);
        make.bottom.equalTo(self).offset(-120);
    }];
    
    UIButton *addAddressBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:addAddressBtn];
    [addAddressBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(180 *kScale, 51 *kScale));
        make.bottom.equalTo(self.mas_bottom).offset(-40 *kScale);
    }];
    addAddressBtn.layer.cornerRadius = 4;
    addAddressBtn.clipsToBounds = YES;
    addAddressBtn.backgroundColor = RadMenuColor;
    [addAddressBtn setTitle:@"新增地址" forState:UIControlStateNormal];
    [addAddressBtn.titleLabel setFont:[UIFont systemFontOfSize:16.f]];
    [addAddressBtn setTitleColor:[UIColor whiteColor]
                         forState:UIControlStateNormal];
    [addAddressBtn addTarget:self
                       action:@selector(respondsToBtnEvents)
             forControlEvents:UIControlEventTouchUpInside];
    
}

#pragma mark - 新增地址
-(void)respondsToBtnEvents
{
    AddressAddViewController *avc = [[AddressAddViewController alloc] init];
    [self.viewController.navigationController pushViewController:avc animated:YES];
    
}

#pragma mark - UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *strcell = @"AddressListsTableViewCell";
    AddressListsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strcell];
    if(!cell)
    {
        cell = [[AddressListsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strcell];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 156;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
}

@end
