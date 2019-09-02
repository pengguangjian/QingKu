//
//  SetPayPasswordView.m
//  QingKu
//
//  Created by mdb-losaic on 2019/9/2.
//  Copyright © 2019 mcxzfa. All rights reserved.
//

#import "SetPayPasswordView.h"

#import "SetNewPayPasswordViewController.h"


@interface SetPayPasswordView () <UITextFieldDelegate>
{
    UITextField *fieldpass;
    NSMutableArray *arrallLB;
}
@end

@implementation SetPayPasswordView

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
    
    UILabel *lbtop = [[UILabel alloc] init];
    [lbtop setText:[MDB_UserDefault getSetStringNmae:@"shezhizhifumima"]];
    [lbtop setTextColor:[UIColor blackColor]];
    [lbtop setTextAlignment:NSTextAlignmentCenter];
    [lbtop setFont:[UIFont systemFontOfSize:38]];
    [self addSubview:lbtop];
    [lbtop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.offset(110*kScale);
        make.height.offset(40);
    }];
    
    UILabel *lbtopmin = [[UILabel alloc] init];
    [lbtopmin setText:[MDB_UserDefault getSetStringNmae:@"qingshuruzhifumima"]];
    [lbtopmin setTextColor:RGB(150, 150, 150)];
    [lbtopmin setTextAlignment:NSTextAlignmentCenter];
    [lbtopmin setFont:[UIFont systemFontOfSize:14]];
    [self addSubview:lbtopmin];
    [lbtopmin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(lbtop);
        make.top.equalTo(lbtop.mas_bottom);
        make.height.offset(20);
    }];
    
    
    UITextField *field = [[UITextField alloc] init];
    [field setTextColor:[UIColor whiteColor]];
    [field setKeyboardType:UIKeyboardTypeNumberPad];
    [field setDelegate:self];
    [self addSubview:field];
    [field mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(40);
        make.top.equalTo(lbtopmin.mas_bottom).offset(30);
        make.width.offset(50);
        make.height.offset(20);
    }];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fieldChangeAction) name:UITextFieldTextDidChangeNotification object:nil];
    [field becomeFirstResponder];
    fieldpass = field;
    
    UIView *viewpass = [[UIView alloc] init];
    [viewpass.layer setBorderColor:RGB(220, 220, 220).CGColor];
    [viewpass.layer setBorderWidth:1];
    [viewpass setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:viewpass];
    [viewpass mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(20);
        make.right.equalTo(self).offset(-20);
        make.top.equalTo(field);
        make.height.offset(55*kScale);
    }];
    
    UIView *viewleft = nil;
    arrallLB = [NSMutableArray new];
    for(int i = 0 ; i < 6; i++)
    {
        UILabel *lbitem = [[UILabel alloc] init];
        [lbitem setTextColor:RGB(0, 0, 0)];
        [lbitem setTextAlignment:NSTextAlignmentCenter];
        [lbitem setFont:[UIFont systemFontOfSize:22]];
        [viewpass addSubview:lbitem];
        [lbitem mas_makeConstraints:^(MASConstraintMaker *make) {
            if(viewleft==nil)
            {
                make.left.offset(0);
            }
            else
            {
                make.left.equalTo(viewleft.mas_right);
            }
            
            make.top.bottom.equalTo(viewpass);
            make.width.equalTo(viewpass).multipliedBy(1/6.0);
        }];
        [arrallLB addObject:lbitem];
        UIView *viewline = [[UIView alloc] init];
        [viewline setBackgroundColor:RGB(220, 220, 220)];
        [viewpass addSubview:viewline];
        [viewline mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.right.equalTo(lbitem);
            make.width.offset(1);
        }];
        if(i==5)
        {
            [viewline setHidden:YES];
        }
        viewleft = lbitem;
    }
    
}

////
-(void)fieldChangeAction
{
    
    if(fieldpass.text.length>=6)
    {
        fieldpass.text = [fieldpass.text substringWithRange:NSMakeRange(0, 6)];
        ///输入完成
        [self payOver];
    }
    
    for(int i = 0 ; i < arrallLB.count; i++)
    {
        UILabel *lb = arrallLB[i];
        if(i<fieldpass.text.length)
        {
            [lb setText:@"*"];
        }
        else
        {
            [lb setText:@""];
        }
        
        
    }
    
}


-(void)payOver
{
    SetNewPayPasswordViewController *svc = [[SetNewPayPasswordViewController alloc] init];
    [self.viewController.navigationController pushViewController:svc animated:YES];
    
}

@end
