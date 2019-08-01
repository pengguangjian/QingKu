//
//  AddressAddView.m
//  QingKu
//
//  Created by mdb-losaic on 2019/7/31.
//  Copyright © 2019 mcxzfa. All rights reserved.
//

#import "AddressAddView.h"

@interface AddressAddView ()<UIScrollViewDelegate>
{
    UIScrollView *scvback;
    
}

@end

@implementation AddressAddView

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
    scvback = [[UIScrollView alloc] init];
    [scvback setBackgroundColor:[UIColor whiteColor]];
    [scvback setDelegate:self];
    [self addSubview:scvback];
    [scvback mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self);
        make.width.offset(kMainScreenW);
        make.bottom.equalTo(self).offset(-120);
    }];
    [scvback setContentSize:CGSizeMake(0, kMainScreenH-kTopHeight-118)];
    
    UITextField *fieldname = [self drawItemView:@"收货人" andframe:CGRectMake(0, 0, kMainScreenW, 55*kScale) andidfieldtype:1];
    [fieldname setPlaceholder:@"姓名"];
    
    UITextField *fieldphone = [self drawItemView:@"手机号" andframe:CGRectMake(0, 55*kScale, kMainScreenW, 55*kScale) andidfieldtype:1];
    [fieldphone setPlaceholder:@"手机号"];
    [fieldphone setKeyboardType:UIKeyboardTypeNumberPad];
    
    UILabel *lbaddress = [self drawItemView:@"所在地区" andframe:CGRectMake(0, 55*kScale*2, kMainScreenW, 55*kScale) andidfieldtype:2];
    
    
    UITextView *textaddress = [self drawItemView:@"详细地址" andframe:CGRectMake(0, 55*kScale*3, kMainScreenW, 55*kScale) andidfieldtype:0];
    
    
    UITextField *fieldnumber = [self drawItemView:@"邮编" andframe:CGRectMake(0, 55*kScale*4, kMainScreenW, 55*kScale) andidfieldtype:1];
    [fieldnumber setPlaceholder:@"邮编"];
    [fieldnumber setKeyboardType:UIKeyboardTypeNumberPad];
    
    
    UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:saveBtn];
    [saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(180 *kScale, 51 *kScale));
        make.bottom.equalTo(self.mas_bottom).offset(-40 *kScale);
    }];
    saveBtn.layer.masksToBounds = YES;
    saveBtn.layer.cornerRadius = 4.f;
    saveBtn.backgroundColor = RadMenuColor;
    [saveBtn setTitle:@"提交" forState:UIControlStateNormal];
    [saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [saveBtn.titleLabel setFont:[UIFont systemFontOfSize:16.f]];
    [saveBtn addTarget:self
                action:@selector(respondsToBtnEvents)
      forControlEvents:UIControlEventTouchUpInside];
}

////ifield 1 uitextfield
-(id)drawItemView:(NSString *)strname andframe:(CGRect)rect andidfieldtype:(int)ifield
{
    UIView *view = [[UIView alloc] initWithFrame:rect];
    [view setBackgroundColor:[UIColor whiteColor]];
    [scvback addSubview:view];
    
    
    UIView *viewleft = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 110*kScale, view.height)];
    [viewleft setBackgroundColor:RGB(232, 232, 234)];
    [view addSubview:viewleft];
    
    UILabel *lbname = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, viewleft.width-20, viewleft.height)];
    [lbname setText:strname];
    [lbname setTextColor:RGB(30, 30, 30)];
    [lbname setTextAlignment:NSTextAlignmentLeft];
    [lbname setFont:[UIFont systemFontOfSize:14]];
    [viewleft addSubview:lbname];
    
    id valuetemp;
    if(ifield==1)
    {
        UITextField *field = [[UITextField alloc] initWithFrame:CGRectMake(viewleft.right+10, 0, view.width-viewleft.right-10, view.height)];
        [field setTextAlignment:NSTextAlignmentLeft];
        [field setTextColor:RGB(30, 30, 30)];
        [field setFont:[UIFont systemFontOfSize:14]];
        [view addSubview:field];
        valuetemp = field;
    }
    else if (ifield == 2)
    {
        UILabel *lbv = [[UILabel alloc] initWithFrame:CGRectMake(viewleft.right+10, 0, view.width-viewleft.right-10, view.height)];
        [lbv setTextColor:RGB(30, 30, 30)];
        [lbv setTextAlignment:NSTextAlignmentLeft];
        [lbv setFont:[UIFont systemFontOfSize:14]];
        [viewleft addSubview:lbv];
        valuetemp = lbv;
    }
    else
    {
        UITextView *textview = [[UITextView alloc] initWithFrame:CGRectMake(viewleft.right+10, 0, view.width-viewleft.right-10, view.height)];
        [textview setTextAlignment:NSTextAlignmentLeft];
        [textview setTextColor:RGB(30, 30, 30)];
        [textview setFont:[UIFont systemFontOfSize:14]];
        [view addSubview:textview];
        valuetemp = textview;
    }
    
    UIView *viewline = [[UIView alloc] initWithFrame:CGRectMake(0, view.height-1, view.width, 1)];
    [viewline setBackgroundColor:RGB(221, 221, 221)];
    [view addSubview:viewline];
    
    return valuetemp;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self endEditing:NO];
}

#pragma mark - 提交
-(void)respondsToBtnEvents
{
    
}

@end
