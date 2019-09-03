//
//  ShiMingRenZhengView.m
//  QingKu
//
//  Created by mdb-losaic on 2019/9/2.
//  Copyright © 2019 mcxzfa. All rights reserved.
//

#import "ShiMingRenZhengView.h"

#import "SelectCountryViewController.h"

#import "PersonalAlertView.h"

#import "TimeKeyboardView.h"

#import "DDPhotoViewController.h"


@interface ShiMingRenZhengView () <SelectCountryViewControllerDelegete,PersonalAlertViewDelegate,TimeKeyboardViewDegelate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    UILabel *lbselectcountry;
    
    UIImageView *imgvZM;
    UIImageView *imgvFM;
    UIImageView *imgvNowSelect;
    
}
@end

@implementation ShiMingRenZhengView

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
    
    UIScrollView *scvback = [[UIScrollView alloc] init];
    [scvback setShowsVerticalScrollIndicator:NO];
    [self addSubview:scvback];
    [scvback mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self);
        make.width.offset(kMainScreenW);
        make.bottom.equalTo(self);
    }];
    
    UIView *viewtop = [[UIView alloc] init];
    [scvback addSubview:viewtop];
    [viewtop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.top.offset(10);
        make.width.offset(kMainScreenW-30);
        make.height.offset(40);
    }];
    [self drawTopView:viewtop andtype:1];
    
    UILabel *lbtopmin = [[UILabel alloc] init];
    [lbtopmin setText:[MDB_UserDefault getSetStringNmae:@"shimingrenzhentopmin"]];
    [lbtopmin setTextColor:RGB(150, 150, 150)];
    [lbtopmin setFont:[UIFont systemFontOfSize:13]];
    [lbtopmin setTextAlignment:NSTextAlignmentLeft];
    [lbtopmin setNumberOfLines:0];
    [lbtopmin sizeToFit];
    [scvback addSubview:lbtopmin];
    [lbtopmin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewtop);
        make.width.offset(kMainScreenW-30);
        make.top.equalTo(viewtop.mas_bottom);
    }];
    
    float fitemw = (kMainScreenW-50)/2.0;
    UIImageView *imgvzhenmian = [[UIImageView alloc] init];
    [imgvzhenmian setImage:[UIImage imageNamed:@"shenfenzhen_zhenmian"]];
    [scvback addSubview:imgvzhenmian];
    [imgvzhenmian mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.top.equalTo(lbtopmin.mas_bottom).offset(5);
        make.size.sizeOffset(CGSizeMake(fitemw, fitemw*0.9));
    }];
    [imgvzhenmian setTag:1];
    [imgvzhenmian setUserInteractionEnabled:YES];
    UITapGestureRecognizer *tapzm = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(photoAction:)];
    [imgvzhenmian addGestureRecognizer:tapzm];
    imgvZM = imgvzhenmian;
    
    
    UIImageView *imgvfanmian = [[UIImageView alloc] init];
    [imgvfanmian setImage:[UIImage imageNamed:@"shenfenzhen_fanmian"]];
    [scvback addSubview:imgvfanmian];
    [imgvfanmian mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imgvzhenmian.mas_right).offset(20);
        make.top.equalTo(imgvzhenmian);
        make.size.equalTo(imgvzhenmian);
    }];
    [imgvfanmian setTag:2];
    [imgvfanmian setUserInteractionEnabled:YES];
    UITapGestureRecognizer *tapfm = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(photoAction:)];
    [imgvfanmian addGestureRecognizer:tapfm];
    imgvFM = imgvfanmian;
    
    
    
    UIView *viewinfo = [[UIView alloc] init];
    [scvback addSubview:viewinfo];
    [viewinfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.width.offset(kMainScreenW);
        make.top.equalTo(imgvzhenmian.mas_bottom).offset(20);
    }];
    
    [self drawInfoView:viewinfo];
    
    
    ////
    UIButton *btok = [[UIButton alloc] init];
    [btok setTitle:[MDB_UserDefault getSetStringNmae:@"queding"] forState:UIControlStateNormal];
    btok.lee_theme.LeeConfigBackgroundColor(@"main_main_color");
    btok.lee_theme.LeeConfigButtonTitleColor(@"main_write_color", UIControlStateNormal);
    [btok.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [scvback addSubview:btok];
    [btok mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.right.equalTo(self).offset(-15);
        make.top.equalTo(viewinfo.mas_bottom).offset(30);
        make.height.offset(45*kScale);
    }];
    [btok.layer setMasksToBounds:YES];
    [btok.layer setCornerRadius:45*kScale/2.0];
    
    [scvback mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(btok.mas_bottom).offset(20);
    }];
    
}


-(void)drawTopView:(UIView *)view andtype:(NSInteger)type
{
    if(type==0)
    {
        UILabel *lbtop = [[UILabel alloc] init];
        [lbtop setText:[MDB_UserDefault getSetStringNmae:@"shimingrenzhentop"]];
        [lbtop setTextColor:RGB(20, 20, 20)];
        [lbtop setFont:[UIFont systemFontOfSize:14]];
        [lbtop setTextAlignment:NSTextAlignmentLeft];
        [lbtop setNumberOfLines:2];
        [view addSubview:lbtop];
        [lbtop mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(view);
        }];
    }
    else
    {
        UIImageView *imgv = [[UIImageView alloc] init];
        [imgv setImage:[UIImage imageNamed:@"shimingrenzhengcuowu"]];
        [view addSubview:imgv];
        [imgv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(view);
            make.size.sizeOffset(CGSizeMake(13, 13));
            make.left.offset(0);
        }];
        
        UILabel *lbtop = [[UILabel alloc] init];
        [lbtop setText:[MDB_UserDefault getSetStringNmae:@"shenimagehenumberbuyizhi"]];
        [lbtop setTextColor:RGB(184, 5, 28)];
        [lbtop setFont:[UIFont systemFontOfSize:14]];
        [lbtop setTextAlignment:NSTextAlignmentLeft];
        [lbtop setNumberOfLines:2];
        [view addSubview:lbtop];
        [lbtop mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.top.bottom.equalTo(view);
            make.left.equalTo(imgv.mas_right).offset(10);
        }];
        
    }
    
}

-(void)drawInfoView:(UIView *)view
{
    ///真实姓名
    UILabel *lbname = [[UILabel alloc] init];
    [lbname setText:[MDB_UserDefault getSetStringNmae:@"zhenshixingming"]];
    [lbname setTextColor:RGB(20, 20, 20)];
    [lbname setFont:[UIFont systemFontOfSize:14]];
    [lbname setTextAlignment:NSTextAlignmentLeft];
    [view addSubview:lbname];
    [lbname mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.top.offset(15);
        make.width.offset(75);
        make.height.offset(45*kScale);
    }];
    
    UITextField *fieldname = [[UITextField alloc] init];
    [fieldname setTextColor:RGB(20, 20, 20)];
    [fieldname setFont:[UIFont systemFontOfSize:14]];
    [fieldname setTextAlignment:NSTextAlignmentLeft];
    [fieldname setPlaceholder:[MDB_UserDefault getSetStringNmae:@"qingshuruzhenshiname"]];
    [view addSubview:fieldname];
    [fieldname mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lbname.mas_right);
        make.right.equalTo(view).offset(-10);
        make.top.height.equalTo(lbname);
    }];
    
    UIView *viewline = [[UIView alloc] init];
    [viewline setBackgroundColor:RGB(245, 245, 245)];
    [view addSubview:viewline];
    [viewline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(fieldname);
        make.top.equalTo(fieldname.mas_bottom);
        make.height.offset(1);
    }];
    
    ///身份证号码
    UILabel *lbnumber = [[UILabel alloc] init];
    [lbnumber setText:[MDB_UserDefault getSetStringNmae:@"shenfenzhenhao"]];
    [lbnumber setTextColor:RGB(20, 20, 20)];
    [lbnumber setFont:[UIFont systemFontOfSize:14]];
    [lbnumber setTextAlignment:NSTextAlignmentLeft];
    [view addSubview:lbnumber];
    [lbnumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.height.equalTo(lbname);
        make.top.equalTo(lbname.mas_bottom).offset(10);
    }];
    
    UITextField *fieldnumber = [[UITextField alloc] init];
    [fieldnumber setTextColor:RGB(20, 20, 20)];
    [fieldnumber setFont:[UIFont systemFontOfSize:14]];
    [fieldnumber setTextAlignment:NSTextAlignmentLeft];
    [fieldnumber setPlaceholder:[MDB_UserDefault getSetStringNmae:@"qshurushenfenzhenhao"]];
    [view addSubview:fieldnumber];
    [fieldnumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lbnumber.mas_right);
        make.right.equalTo(view).offset(-10);
        make.top.height.equalTo(lbnumber);
    }];
    
    UIView *viewline1 = [[UIView alloc] init];
    [viewline1 setBackgroundColor:RGB(245, 245, 245)];
    [view addSubview:viewline1];
    [viewline1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(fieldnumber);
        make.top.equalTo(fieldnumber.mas_bottom);
        make.height.offset(1);
    }];
    
    ///性别
    UILabel *lbsex = [[UILabel alloc] init];
    [lbsex setText:[MDB_UserDefault getSetStringNmae:@"xingbie"]];
    [lbsex setTextColor:RGB(20, 20, 20)];
    [lbsex setFont:[UIFont systemFontOfSize:14]];
    [lbsex setTextAlignment:NSTextAlignmentLeft];
    [view addSubview:lbsex];
    [lbsex mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.height.equalTo(lbname);
        make.top.equalTo(lbnumber.mas_bottom).offset(10);
    }];
    
    UILabel *fieldsex = [[UILabel alloc] init];
    [fieldsex setTextColor:RGB(200, 200, 200)];
    [fieldsex setFont:[UIFont systemFontOfSize:14]];
    [fieldsex setTextAlignment:NSTextAlignmentLeft];
    [fieldsex setText:[MDB_UserDefault getSetStringNmae:@"qxuanzhexingbie"]];
    [view addSubview:fieldsex];
    [fieldsex mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lbsex.mas_right);
        make.right.equalTo(view).offset(-10);
        make.top.height.equalTo(lbsex);
    }];
    [fieldsex setUserInteractionEnabled:YES];
    UITapGestureRecognizer *tapsex = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sexAction)];
    [fieldsex addGestureRecognizer:tapsex];
    
    UIImageView *imgvnext = [[UIImageView alloc] init];
    [imgvnext setImage:[UIImage imageNamed:@"next_right"]];
    [view addSubview:imgvnext];
    [imgvnext mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.sizeOffset(CGSizeMake(15, 15));
        make.centerY.equalTo(fieldsex);
        make.right.equalTo(fieldsex);
    }];
    
    UIView *viewline2 = [[UIView alloc] init];
    [viewline2 setBackgroundColor:RGB(245, 245, 245)];
    [view addSubview:viewline2];
    [viewline2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(fieldsex);
        make.top.equalTo(fieldsex.mas_bottom);
        make.height.offset(1);
    }];
    
    ///出生日期
    UILabel *lbbrothday = [[UILabel alloc] init];
    [lbbrothday setText:[MDB_UserDefault getSetStringNmae:@"chushengriqi"]];
    [lbbrothday setTextColor:RGB(20, 20, 20)];
    [lbbrothday setFont:[UIFont systemFontOfSize:14]];
    [lbbrothday setTextAlignment:NSTextAlignmentLeft];
    [view addSubview:lbbrothday];
    [lbbrothday mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.height.equalTo(lbname);
        make.top.equalTo(lbsex.mas_bottom).offset(10);
    }];
    
    UILabel *fieldbrothday = [[UILabel alloc] init];
    [fieldbrothday setTextColor:RGB(200, 200, 200)];
    [fieldbrothday setFont:[UIFont systemFontOfSize:14]];
    [fieldbrothday setTextAlignment:NSTextAlignmentLeft];
    [fieldbrothday setText:[MDB_UserDefault getSetStringNmae:@"qxuanzhechushengriqi"]];
    [view addSubview:fieldbrothday];
    [fieldbrothday mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lbbrothday.mas_right);
        make.right.equalTo(view).offset(-10);
        make.top.height.equalTo(lbbrothday);
    }];
    [fieldbrothday setUserInteractionEnabled:YES];
    UITapGestureRecognizer *tapbrothday = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(brothdayAction)];
    [fieldbrothday addGestureRecognizer:tapbrothday];
    
    
    UIImageView *imgvnext1 = [[UIImageView alloc] init];
    [imgvnext1 setImage:[UIImage imageNamed:@"next_right"]];
    [view addSubview:imgvnext1];
    [imgvnext1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.sizeOffset(CGSizeMake(15, 15));
        make.centerY.equalTo(fieldbrothday);
        make.right.equalTo(fieldbrothday);
    }];
    
    UIView *viewline3 = [[UIView alloc] init];
    [viewline3 setBackgroundColor:RGB(245, 245, 245)];
    [view addSubview:viewline3];
    [viewline3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(fieldbrothday);
        make.top.equalTo(fieldbrothday.mas_bottom);
        make.height.offset(1);
    }];
    
    
    ////手机号
    UIButton *btselect = [[UIButton alloc] init];
    [btselect addTarget:self action:@selector(countryAction) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btselect];
    [btselect mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.height.equalTo(lbname);
        make.top.equalTo(lbbrothday.mas_bottom).offset(10);
    }];
    UILabel *lbcnumber = [[UILabel alloc] init];
    [lbcnumber setText:@"+95"];
    lbcnumber.lee_theme.LeeConfigTextColor(@"main_textblack01_color");
    [lbcnumber setFont:[UIFont systemFontOfSize:14]];
    [lbcnumber setTextAlignment:NSTextAlignmentLeft];
    [btselect addSubview:lbcnumber];
    [lbcnumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(btselect);
        make.top.bottom.equalTo(btselect);
    }];
    
    UILabel *lbcountry = [[UILabel alloc] init];
    [lbcountry setText:[MDB_UserDefault getSetStringNmae:@"miandian"]];
    lbcountry.lee_theme.LeeConfigTextColor(@"main_textblack01_color");
    [lbcountry setFont:[UIFont systemFontOfSize:10]];
    [lbcountry setTextAlignment:NSTextAlignmentLeft];
    [btselect addSubview:lbcountry];
    [lbcountry mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lbcnumber.mas_right);
        make.top.bottom.equalTo(btselect);
    }];
//    [lbcountry sizeToFit];
    lbselectcountry = lbcountry;
    
    UIImageView *imgvdown = [[UIImageView alloc] init];
    [imgvdown setImage:[UIImage imageNamed:@"next_down"]];
    [btselect addSubview:imgvdown];
    [imgvdown mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(btselect);
        make.size.sizeOffset(CGSizeMake(10, 10));
        make.left.equalTo(lbcountry.mas_right).offset(3);
    }];
    [btselect mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(imgvdown.mas_right).offset(3);
    }];
    
    UITextField *fieldphone = [[UITextField alloc] init];
    fieldphone.lee_theme.LeeConfigTextColor(@"main_textblack01_color");
    [fieldphone setTextAlignment:NSTextAlignmentLeft];
    [fieldphone setFont:[UIFont systemFontOfSize:14]];
    [fieldphone setPlaceholder:[MDB_UserDefault getSetStringNmae:@"qingshurunindeshoujihao"]];
    [view addSubview:fieldphone];
    [fieldphone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(btselect.mas_right);
        make.right.equalTo(view).offset(-10);
        make.top.height.equalTo(btselect);
    }];
    
    UIView *viewline4 = [[UIView alloc] init];
    [viewline4 setBackgroundColor:RGB(245, 245, 245)];
    [view addSubview:viewline4];
    [viewline4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(fieldphone);
        make.top.equalTo(fieldphone.mas_bottom);
        make.height.offset(1);
    }];
    
    
    ///验证码
    UITextField *fieldcode = [[UITextField alloc] init];
    fieldcode.lee_theme.LeeConfigTextColor(@"main_textblack01_color");
    [fieldcode setTextAlignment:NSTextAlignmentLeft];
    [fieldcode setFont:[UIFont systemFontOfSize:14]];
    [fieldcode setPlaceholder:[MDB_UserDefault getSetStringNmae:@"qingshurunindeyanzhenma"]];
    [view addSubview:fieldcode];
    [fieldcode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(btselect.mas_right);
        make.right.equalTo(view).offset(-10);
        make.height.equalTo(fieldphone);
        make.top.equalTo(fieldphone.mas_bottom).offset(10);
    }];
    UIView *viewline5 = [[UIView alloc] init];
    [viewline5 setBackgroundColor:RGB(245, 245, 245)];
    [view addSubview:viewline5];
    [viewline5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(fieldcode);
        make.top.equalTo(fieldcode.mas_bottom);
        make.height.offset(1);
    }];
    
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(fieldcode.mas_bottom).offset(5);
    }];
    
}

#pragma mark - 选择国家
-(void)countryAction
{
    SelectCountryViewController *svc = [[SelectCountryViewController alloc] init];
    svc.delegete = self;
    svc.inomoselect = 0;
    [self.viewController.navigationController pushViewController:svc animated:YES];
    
}
////缅甸0 中国1
-(void)selectCountry:(NSInteger)iselect
{
    if(iselect<0)
    {
        iselect = 0;
    }
    if(iselect>1)
    {
        iselect = 1;
    }
    NSArray *arrname = @[[MDB_UserDefault getSetStringNmae:@"miandian"],[MDB_UserDefault getSetStringNmae:@"zhongguo"]];
    [lbselectcountry setText:arrname[iselect]];
}


#pragma mark - 日期选择
-(void)brothdayAction
{
    TimeKeyboardView *alerView = [[TimeKeyboardView alloc] init];
    alerView.tag = 12;
    alerView.degelate = self;
    alerView.iline = 3;
    [[UIApplication sharedApplication].keyWindow addSubview:alerView];
}
-(void)changeValue:(NSString *)strvalue
{
    
}
#pragma mark - 性别选择
-(void)sexAction
{
    PersonalAlertView *alertV = [[PersonalAlertView alloc] init];
    alertV.tag = 11;
    alertV.delegate = self;
    [alertV show];
}

- (void)finishBtnClicked: (NSString *)text view:(UIView *)view
{
    
    
}

#pragma mark - 身份证选择
-(void)photoAction:(UIGestureRecognizer *)gesture
{
    imgvNowSelect = (UIImageView *)gesture.view;
    UIAlertController *alter = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:[MDB_UserDefault getSetStringNmae:@"paizhao"] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        DDPhotoViewController *vc = [[DDPhotoViewController alloc] init];
        
        vc.imageblock = ^(UIImage *image) {
            self->imgvNowSelect.image = image;
        };
        [self.viewController presentViewController:vc animated:YES completion:nil];
        
    }];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:[MDB_UserDefault getSetStringNmae:@"chongshoujixcxqu"] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerController * Imagepicker = [[UIImagePickerController alloc] init] ;
        Imagepicker.delegate=self;
        //从手机相册选择
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            Imagepicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self.viewController presentViewController:Imagepicker animated:YES completion:nil];
        }
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:[MDB_UserDefault getSetStringNmae:@"quxiao"] style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alter addAction:action];
    [alter addAction:action1];
    [alter addAction:action2];
    
    [self.viewController presentViewController:alter animated:YES completion:^{
        
    }];
    
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    imgvNowSelect.image = image;
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    
}


@end
