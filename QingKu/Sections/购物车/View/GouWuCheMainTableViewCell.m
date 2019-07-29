//
//  GouWuCheMainTableViewCell.m
//  QingKu
//
//  Created by mdb-losaic on 2019/7/29.
//  Copyright © 2019 mcxzfa. All rights reserved.
//

#import "GouWuCheMainTableViewCell.h"


@interface GouWuCheMainTableViewCell ()
{
    UIView *viewback;
    
    ///选中
    UIButton *btselect;
    
    ///头图
    UIImageView *imgvhead;
    
    ///已截单
    UILabel *lbjiedan;
    
    UILabel *lbtitle;
    UILabel *lbprice;
    
    ///规格
    UILabel *lbguige;
    UIView *viewguigeback;
    
    
    UIView *viewline;
    
    ///数量
    UIView *viewnumber;
    UIButton *btdel;
    UIView *viewline0;
    UITextField *fieldnumber;
    UIView *viewline1;
    UIButton *btadd;
    
}
@end

@implementation GouWuCheMainTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        viewback = [[UIView alloc] init];
        [viewback setBackgroundColor:[UIColor whiteColor]];
        [self.contentView addSubview:viewback];
        [viewback mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        
        btselect = [[UIButton alloc] init];
        [viewback addSubview:btselect];
        [btselect mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(5);
            make.top.offset(17);
            make.height.offset(81);
            make.width.offset(40);
        }];
        [btselect setImage:[UIImage imageNamed:@"yuan_select_no"] forState:UIControlStateNormal];
        [btselect addTarget:self action:@selector(selectAction) forControlEvents:UIControlEventTouchUpInside];
        
        imgvhead = [[UIImageView alloc] init];
        [viewback addSubview:imgvhead];
        [imgvhead mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self->btselect.mas_right);
            make.top.bottom.equalTo(self->btselect);
            make.width.offset(81);
        }];
        
        
        lbjiedan = [[UILabel alloc] init];
        [viewback addSubview:lbjiedan];
        [lbjiedan mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self->imgvhead.mas_left).offset(15);
            make.top.equalTo(self->imgvhead.mas_top).offset(15);
            make.bottom.equalTo(self->imgvhead.mas_bottom).offset(-15);
            make.right.equalTo(self->imgvhead.mas_right).offset(-15);
        }];
        [lbjiedan setBackgroundColor:RGBAlpha(0, 0, 0, 0.5)];
        [lbjiedan setText:@"已截单"];
        [lbjiedan setTextColor:[UIColor whiteColor]];
        [lbjiedan setTextAlignment:NSTextAlignmentCenter];
        [lbjiedan setFont:[UIFont systemFontOfSize:14]];
        [lbjiedan.layer setMasksToBounds:YES];
        [lbjiedan.layer setCornerRadius:51/2.0];
        
        
        
        lbtitle = [[UILabel alloc] init];
        [viewback addSubview:lbtitle];
        [lbtitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self->imgvhead.mas_right).offset(10);
            make.top.equalTo(self->imgvhead).offset(-5);
            make.right.equalTo(self->viewback).offset(-10);
            make.height.offset(41);
        }];
        [lbtitle setTextColor:RGB(30, 30, 30)];
        [lbtitle setTextAlignment:NSTextAlignmentLeft];
        [lbtitle setNumberOfLines:2];
        [lbtitle setFont:[UIFont systemFontOfSize:16]];
        
        lbprice = [[UILabel alloc] init];
        [viewback addSubview:lbprice];
        [lbprice mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self->lbtitle);
            make.top.equalTo(self->lbtitle.mas_bottom).offset(3);
            make.height.offset(20);
        }];
        [lbprice setTextColor:RGB(243,93,0)];
        [lbprice setTextAlignment:NSTextAlignmentLeft];
        [lbprice setFont:[UIFont systemFontOfSize:15]];
        
        
        
        viewline = [[UIView alloc] init];
        [viewline setBackgroundColor:RGB(231, 231, 231)];
        [viewback addSubview:viewline];
        [viewline mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self->viewback);
            make.height.offset(1);
            make.bottom.equalTo(self->viewback);
        }];
        
        [self drawNumberSelect:CGRectMake(0, 0, 50, 26*kScale)];
        [viewnumber mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self->lbprice.mas_top).offset(-3*kScale);
            make.right.equalTo(self->lbtitle.mas_right);
            make.height.offset(26*kScale);
            make.width.offset(self->viewnumber.width);
        }];
        
        
        viewguigeback = [[UIView alloc] init];
        [viewguigeback setBackgroundColor:RGB(234, 234, 234)];
        [viewback addSubview:viewguigeback];
        
        
        lbguige = [[UILabel alloc] init];
        [viewback addSubview:lbguige];
        [lbguige mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self->lbtitle);
            make.top.equalTo(self->viewnumber.mas_bottom).offset(2);
            make.width.offset(0);
            make.height.offset(20);
        }];
        [lbguige setNumberOfLines:2];
        [lbguige setBackgroundColor:RGB(234, 234, 234)];
        [lbguige setTextColor:RGB(153,153,153)];
        [lbguige setTextAlignment:NSTextAlignmentLeft];
        [lbguige setFont:[UIFont systemFontOfSize:10]];
        [lbguige setUserInteractionEnabled:YES];
        UITapGestureRecognizer *tapguige = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(guigeAction)];
        [lbguige addGestureRecognizer:tapguige];
        
        [viewguigeback mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self->lbtitle).offset(-5);
            make.top.equalTo(self->viewnumber.mas_bottom).offset(2);
            make.width.equalTo(self->lbguige.mas_width);
            make.height.equalTo(self->lbguige.mas_height);
        }];
        
        
    }
    return self;
}


#pragma mark - 数量选择
-(void)drawNumberSelect:(CGRect)rect
{
    viewnumber = [[UIView alloc] initWithFrame:rect];
    [viewnumber.layer setMasksToBounds:YES];
    [viewnumber.layer setCornerRadius:3];
    [viewnumber.layer setBorderColor:RGB(204,204,204).CGColor];
    [viewnumber.layer setBorderWidth:1];
    [viewnumber setClipsToBounds:YES];
    [viewback addSubview:viewnumber];
    
    btdel = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, viewnumber.height, viewnumber.height)];
    [btdel setTitle:@"-" forState:UIControlStateNormal];
    [btdel setTitleColor:RGB(153,153,153) forState:UIControlStateNormal];
    [btdel.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [btdel addTarget:self action:@selector(delNumberAction) forControlEvents:UIControlEventTouchUpInside];
    [viewnumber addSubview:btdel];
    
    viewline0 = [[UIView alloc] initWithFrame:CGRectMake(btdel.right, 0, 1, viewnumber.height)];
    [viewline0 setBackgroundColor:RGB(204,204,204)];
    [viewnumber addSubview:viewline0];
    
    fieldnumber = [[UITextField alloc] initWithFrame:CGRectMake(viewline0.right, 0, viewnumber.height*1.1, viewnumber.height)];
    [fieldnumber setText:@"1"];
    [fieldnumber setTextColor:RadMenuColor];
    [fieldnumber setTextAlignment:NSTextAlignmentCenter];
    [fieldnumber setFont:[UIFont systemFontOfSize:12]];
    [fieldnumber setUserInteractionEnabled:NO];
    [fieldnumber setBackgroundColor:[UIColor whiteColor]];
    [viewnumber addSubview:fieldnumber];
    
    
    viewline1 = [[UIView alloc] initWithFrame:CGRectMake(fieldnumber.right, 0, 1, viewnumber.height)];
    [viewline1 setBackgroundColor:RGB(204,204,204)];
    [viewnumber addSubview:viewline1];
    
    
    btadd = [[UIButton alloc] initWithFrame:CGRectMake(viewline1.right, 0, viewnumber.height, viewnumber.height)];
    [btadd setTitle:@"+" forState:UIControlStateNormal];
    [btadd setTitleColor:RGB(153,153,153) forState:UIControlStateNormal];
    [btadd.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [viewnumber addSubview:btadd];
    [btadd addTarget:self action:@selector(addNumberAction) forControlEvents:UIControlEventTouchUpInside];
    [viewnumber setWidth:btadd.right];
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    [imgvhead setContentMode:UIViewContentModeScaleAspectFit];
    [imgvhead setBackgroundColor:[UIColor grayColor]];
    
    [lbtitle setText:@"商品标题商品标题商品标题商品标题商品标题商品标题"];
    
    [lbprice setText:[NSString stringWithFormat:@"￥%@",@"123.00"]];
//    [btselect setImage:[UIImage imageNamed:@"yuan_select_yes"] forState:UIControlStateNormal];
//    [btselect setImage:[UIImage imageNamed:@"yuan_select_no"] forState:UIControlStateNormal];
    
    [viewguigeback setHidden:NO];
    [lbguige setHidden:NO];
    
    [lbjiedan setHidden:YES];
    
}

#pragma mark - 选中商品
-(void)selectAction
{
    
}
///点击规格
-(void)guigeAction
{
    
}
///数量减
-(void)delNumberAction
{
    
}
///数量加
-(void)addNumberAction
{
    
}


@end
