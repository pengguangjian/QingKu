//
//  SetView.m
//  QingKu
//
//  Created by mdb-losaic on 2019/9/2.
//  Copyright © 2019 mcxzfa. All rights reserved.
//

#import "SetView.h"

@interface SetView () <UITableViewDelegate,UITableViewDataSource>
{
    NSArray *arrname;
    
}
@end

@implementation SetView

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
    [self setBackgroundColor:[UIColor whiteColor]];
    
    arrname = @[[MDB_UserDefault getSetStringNmae:@"yuyanqiehuan"],
                [MDB_UserDefault getSetStringNmae:@"zhutiqiehuan"],
                [MDB_UserDefault getSetStringNmae:@"banbengengxin"],
                [MDB_UserDefault getSetStringNmae:@"guanyuwomen"],
                [MDB_UserDefault getSetStringNmae:@"qingchuhuancun"],
                [MDB_UserDefault getSetStringNmae:@"lianxikefu"]];
    
    
    UITableView *tabview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenW, kMainScreenH-kTopHeight) style:UITableViewStyleGrouped];
    [tabview setDelegate:self];
    [tabview setDataSource:self];
    [tabview setBackgroundColor:RGB(234, 234, 234)];
    tabview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:tabview];
    [tabview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self);
        make.width.offset(kMainScreenW);
        make.bottom.equalTo(self);
    }];
    [self drawheaderView:tabview];
    
    [tabview reloadData];
}

-(void)drawheaderView:(UITableView *)tabview
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenW, 110+kMainScreenW/4.0)];
    [view setBackgroundColor:RGB(234, 234, 234)];
    [tabview setTableHeaderView:view];
    
    UIImageView *imgv = [[UIImageView alloc] init];
    UIImage *image = [UIImage imageNamed:@"qidongtu_back02"];
    [imgv setImage:image];
    [imgv setContentMode:UIViewContentModeScaleAspectFit];
    [view addSubview:imgv];
    [imgv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.sizeOffset(CGSizeMake(kMainScreenW/3.0, kMainScreenW/3.0*image.size.height/image.size.width));
        make.centerX.equalTo(view);
        make.top.offset(35);
    }];
    
    
    UILabel *lbbottommin = [[UILabel alloc] init];
    [lbbottommin setText:[NSString stringWithFormat:@"MoMo V%@",[self applicationVersion]]];
    [lbbottommin setTextColor:RGB(50, 50, 50)];
    [lbbottommin setTextAlignment:NSTextAlignmentCenter];
    [lbbottommin setFont:[UIFont systemFontOfSize:15]];
    [self addSubview:lbbottommin];
    [lbbottommin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(imgv.mas_bottom).offset(30);
        make.height.offset(20);
    }];
    
    
//    [view mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(lbbottommin.mas_bottom).offset(30);
//    }];
    
    
}

- (NSString *)applicationVersion {
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    CFShow((__bridge CFTypeRef)(infoDic));
    NSString * applicationVersion = [infoDic objectForKey:@"CFBundleShortVersionString"];
    return applicationVersion;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrname.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.textLabel.text = arrname[indexPath.row];
    cell.textLabel.textColor = [UIColor colorWithHexString:@"#666666"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UIView *lineV = [[UIView alloc] init];
    [cell addSubview:lineV];
    lineV.backgroundColor = [UIColor colorWithHexString:@"#F4F4F4"];
    [lineV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(cell);
        make.height.offset(1);
    }];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if(indexPath.row == 0)
    {
        
        UILabel *versionLabel = [[UILabel alloc] init];
        versionLabel.text = [MDB_UserDefault getSetStringNmae:@"zhongwen"];
        versionLabel.textAlignment = NSTextAlignmentRight;
        versionLabel.font = [UIFont systemFontOfSize:14];
        versionLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        [cell addSubview:versionLabel];
        [versionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(cell.mas_centerY);
            make.right.equalTo(cell.mas_right).offset(-38 *kScale);
            make.left.equalTo(cell).offset(10);
        }];
        
    }
    else if (indexPath.row == 1)
    {
        UILabel *versionLabel = [[UILabel alloc] init];
        versionLabel.text = [MDB_UserDefault getSetStringNmae:@"baitian"];
        versionLabel.textAlignment = NSTextAlignmentRight;
        versionLabel.font = [UIFont systemFontOfSize:14];
        versionLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        [cell addSubview:versionLabel];
        [versionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(cell.mas_centerY);
            make.right.equalTo(cell.mas_right).offset(-38 *kScale);
            make.left.equalTo(cell).offset(10);
        }];
    }
    else if (indexPath.row == 4)
    {
        
        UILabel *versionLabel = [[UILabel alloc] init];
        versionLabel.text = @"0.00M";
        versionLabel.textAlignment = NSTextAlignmentRight;
        versionLabel.font = [UIFont systemFontOfSize:14];
        versionLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        [cell addSubview:versionLabel];
        [versionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(cell.mas_centerY);
            make.right.equalTo(cell.mas_right).offset(-38 *kScale);
            make.left.equalTo(cell).offset(10);
        }];
        
        
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//            float tmpSize=[[MDB_UserDefault defaultInstance] checkTmpSize];
//            dispatch_async(dispatch_get_main_queue(), ^{
//                numLabel.hidden = NO;
//                numLabel.text=[NSString stringWithFormat:@"%.2f M",tmpSize];
//            });
//        });
        
    }
    
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55*kScale;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 55*kScale+10;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenW, 55*kScale)];
    [view setBackgroundColor:RGB(234, 234, 234)];
    
    UIButton *bttuichu = [[UIButton alloc] initWithFrame:CGRectMake(0, 10, view.width, 45*kScale)];
    [bttuichu setBackgroundColor:[UIColor whiteColor]];
    [bttuichu setTitle:[MDB_UserDefault getSetStringNmae:@"tuichudenglu"] forState:UIControlStateNormal];
    [bttuichu setTitleColor:RGB(190, 43, 54) forState:UIControlStateNormal];
    [bttuichu.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [view addSubview:bttuichu];
    [bttuichu addTarget:self action:@selector(tuichuAction) forControlEvents:UIControlEventTouchUpInside];
    
    return view;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    switch (indexPath.row) {
        case 0:
        {///语言切换
            
        }
            break;
        case 1:
        {///主题切换
            
        }
            break;
        case 2:
        {///版本更新
            
        }
            break;
        case 3:
        {///关于我们
            
        }
            break;
        case 4:
        {///清除缓存
            
        }
            break;
        case 5:
        {///联系客服
            
        }
            break;
        default:
            break;
    }
    
}

#pragma mark - 退出登录
-(void)tuichuAction
{
    
}

@end
