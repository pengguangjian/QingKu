//
//  UserInfoView.m
//  QingKu
//
//  Created by mdb-losaic on 2019/9/2.
//  Copyright © 2019 mcxzfa. All rights reserved.
//

#import "UserInfoView.h"
#import "ChangePhoneViewController.h"
#import "SetPayPasswordViewController.h"
#import "ShiMingRenZhengViewController.h"
#import "ImageCorpperViewController.h"
#import <Photos/Photos.h>

@interface UserInfoView ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate,ImageCorpperViewControllerDelegate>
{
    NSArray *arrname;
    
    UIImageView *imgvHead;
    
}
@end
@implementation UserInfoView

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
    
    arrname = @[
                @[[MDB_UserDefault getSetStringNmae:@"touxiang"],
                [MDB_UserDefault getSetStringNmae:@"zhanghao"]],
                @[[MDB_UserDefault getSetStringNmae:@"shimingrenzheng"],
                [MDB_UserDefault getSetStringNmae:@"chongzhizhifumima"],
                [MDB_UserDefault getSetStringNmae:@"genghuanshoujihao"]]];
    
    
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
    
    [tabview reloadData];
}
#pragma mark - 头像点击 更换头像
-(void)headAction:(UITapGestureRecognizer *)gesture
{
    UIAlertController *alter = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if([self canUserCamear])
        {
            UIImagePickerController * Imagepicker = [[UIImagePickerController alloc] init];
            Imagepicker.delegate=self;
            //拍照
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                Imagepicker.sourceType = UIImagePickerControllerSourceTypeCamera;
                [self.viewController presentViewController:Imagepicker animated:YES completion:nil];
            }
        }
        
         
    }];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"从手机相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerController * Imagepicker = [[UIImagePickerController alloc] init] ;
        Imagepicker.delegate=self;
        //从手机相册选择
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            Imagepicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self.viewController presentViewController:Imagepicker animated:YES completion:nil];
        }
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alter addAction:action];
    [alter addAction:action1];
    [alter addAction:action2];
    
    [self.viewController presentViewController:alter animated:YES completion:^{
        
    }];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
        ////选取部分图片
        ImageCorpperViewController *imgCor=[[ImageCorpperViewController alloc] initWithNibName:nil bundle:nil];
        imgCor.img=[info objectForKey:@"UIImagePickerControllerOriginalImage"];
        imgCor.delegate=self;
        [picker pushViewController:imgCor animated:YES];
}

-(void)loadimvImage:(UIImage *)image
{
    imgvHead.image = image;
    
    
    
    
}

#pragma mark - 检查相机权限
- (BOOL)canUserCamear{
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusDenied) {
        UIAlertController *alter = [UIAlertController alertControllerWithTitle:@"请打开相机权限" message:@"设置-隐私-相机" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:0 handler:^(UIAlertAction * _Nonnull action) {
            NSURL * url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            
            if([[UIApplication sharedApplication] canOpenURL:url]) {
                
                [[UIApplication sharedApplication] openURL:url];
                
            }
        }];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:0 handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alter addAction:action];
        [alter addAction:action1];
        [self.viewController presentViewController:alter animated:YES completion:nil];
        
        
        return NO;
    }
    else{
        return YES;
    }
    return YES;
}

#pragma mark - UITableView
///
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return arrname.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *arritem = arrname[section];
    return arritem.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *arritem = arrname[indexPath.section];
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.textLabel.text = arritem[indexPath.row];
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
    if(indexPath.row == 0 && indexPath.section == 0)
    {
        
        UIImageView *imgvitem = [[UIImageView alloc] init];
        [imgvitem setBackgroundColor:[UIColor grayColor]];
        [cell addSubview:imgvitem];
        [imgvitem mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(cell.mas_centerY);
            make.right.equalTo(cell.mas_right).offset(-38 *kScale);
            make.size.sizeOffset(CGSizeMake(55*kScale, 55*kScale));
        }];
        [imgvitem.layer setMasksToBounds:YES];
        [imgvitem.layer setCornerRadius:55*kScale/2.0];
        [imgvitem setUserInteractionEnabled:YES];
        UITapGestureRecognizer *tapimg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headAction:)];
        [imgvitem addGestureRecognizer:tapimg];
        imgvHead = imgvitem;
    }
    else if (indexPath.row == 1 && indexPath.section == 0)
    {
        UILabel *versionLabel = [[UILabel alloc] init];
        versionLabel.text = @"用户名";
        versionLabel.textAlignment = NSTextAlignmentRight;
        versionLabel.backgroundColor = [UIColor whiteColor];
        versionLabel.font = [UIFont systemFontOfSize:14];
        versionLabel.lee_theme.LeeConfigTextColor(@"main_main_color");
        [cell addSubview:versionLabel];
        [versionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(cell.mas_centerY);
            make.right.equalTo(cell.mas_right).offset(-10 *kScale);
//            make.left.equalTo(cell).offset(10);
            make.width.offset(120);
        }];
    }
    else if (indexPath.row == 0 && indexPath.section == 1)
    {
        UILabel *versionLabel = [[UILabel alloc] init];
        versionLabel.text = @"是否认证";
        versionLabel.textAlignment = NSTextAlignmentRight;
        versionLabel.font = [UIFont systemFontOfSize:14];
        versionLabel.textColor = RGB(191, 28, 48);
        [cell addSubview:versionLabel];
        [versionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(cell.mas_centerY);
            make.right.equalTo(cell.mas_right).offset(-38 *kScale);
            make.left.equalTo(cell).offset(10);
        }];
    }
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row==0 && indexPath.section == 0)
    {
        return 110*kScale;
        
    }
    else if(indexPath.row==0)
    {
        
        return 60*kScale+10;
    }
    else
    {
        return 60*kScale;
    }
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenW, 1)];
    [view setBackgroundColor:RGB(255, 255, 255)];
    
    return view;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenW, 10)];
    [view setBackgroundColor:RGB(234, 234, 234)];
    
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
    {
        switch (indexPath.row) {
            case 0:
            {///头像
                
            }
                break;
            case 1:
            {///账号
                
            }
                break;
            default:
                break;
        }
    }
    else if (indexPath.section == 1)
    {
        switch (indexPath.row) {
            case 0:
            {///实名认证
                ShiMingRenZhengViewController *vc = [[ShiMingRenZhengViewController alloc] init];
                [self.viewController.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 1:
            {///重置支付密码
                SetPayPasswordViewController *vc = [[SetPayPasswordViewController alloc] init];
                [self.viewController.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 2:
            {///更换手机号
                ChangePhoneViewController *vc = [[ChangePhoneViewController alloc] init];
                [self.viewController.navigationController pushViewController:vc animated:YES];
            }
                break;
            default:
                break;
        }
    }
    
    
}


@end
