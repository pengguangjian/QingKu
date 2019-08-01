//
//  MyYouHuiQuanTableViewCell.m
//  QingKu
//
//  Created by mdb-losaic on 2019/7/31.
//  Copyright © 2019 mcxzfa. All rights reserved.
//

#import "MyYouHuiQuanTableViewCell.h"
#import "MDB_UserDefault.h"


@interface MyYouHuiQuanTableViewCell ()

@end

@implementation MyYouHuiQuanTableViewCell

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
        UIView *viewback = [[UIView alloc] init];
        [self.contentView addSubview:viewback];
        [viewback.layer setBorderColor:RGB(230, 230, 230).CGColor];
        [viewback.layer setBorderWidth:1];
        [viewback mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.offset(20);
            make.right.equalTo(self).offset(-20);
            make.bottom.equalTo(self);
        }];
        
        
        UILabel *lbmoney = [[UILabel alloc] init];
        [lbmoney setText:@"8元 免邮券"];
        [lbmoney setTextColor:RGB(30, 30, 30)];
        [lbmoney setTextAlignment:NSTextAlignmentCenter];
        [lbmoney setFont:[UIFont systemFontOfSize:14]];
        [viewback addSubview:lbmoney];
        [lbmoney setAttributedText:[MDB_UserDefault arrstring:lbmoney.text andstart:0 andend:1 andfont:[UIFont boldSystemFontOfSize:30] andcolor:[UIColor redColor]]];
        
        float fmwidth = [MDB_UserDefault countTextSize:CGSizeMake(150, 20) andtextfont:[UIFont systemFontOfSize:14] andtext:lbmoney.text].width+18;
        if(fmwidth<80)
        {
            fmwidth = 80;
        }
        [lbmoney mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(10);
            make.bottom.equalTo(viewback.mas_centerY);
            make.width.offset(fmwidth);
        }];
        
        UILabel *lbstate = [[UILabel alloc] init];
        [lbstate setTextAlignment:NSTextAlignmentCenter];
        [lbstate setTextColor:[UIColor whiteColor]];
        [lbstate setText:@"未使用"];
        [lbstate setFont:[UIFont systemFontOfSize:15]];
        [lbstate setBackgroundColor:RGB(49, 161, 255)];
        [lbstate.layer setMasksToBounds:YES];
        [lbstate.layer setCornerRadius:2];
        [viewback addSubview:lbstate];
        [lbstate mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lbmoney.mas_bottom).offset(2);
            make.height.offset(22);
            make.width.offset(60);
            make.centerX.equalTo(lbmoney);
        }];
        
        
        UIView *viewline = [[UIView alloc] init];
        [viewline setBackgroundColor:RGB(230, 230, 230)];
        [viewback addSubview:viewline];
        [viewline mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(10);
            make.width.offset(1);
            make.bottom.equalTo(viewback).offset(-10);
            make.left.equalTo(lbmoney.mas_right).offset(10);
            
        }];
        
        
        
        UILabel *lbname = [[UILabel alloc] init];
        [lbname setText:@"无门槛使用"];
        [lbname setTextColor:RGB(30, 30, 30)];
        [lbname setTextAlignment:NSTextAlignmentLeft];
        [lbname setFont:[UIFont systemFontOfSize:14]];
        [lbname setNumberOfLines:2];
        [viewback addSubview:lbname];
        [lbname mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(viewline.mas_right).offset(10);
            make.bottom.equalTo(viewback.mas_centerY);
            make.right.equalTo(viewback).offset(-90);
            make.height.offset(40);
        }];
        
        
        UILabel *lbtime = [[UILabel alloc] init];
        [lbtime setText:@"2019.07.30-2019.08.30"];
        [lbtime setTextColor:RGB(130, 130, 130)];
        [lbtime setTextAlignment:NSTextAlignmentLeft];
        [lbtime setFont:[UIFont systemFontOfSize:12]];
        [lbtime setNumberOfLines:2];
        [viewback addSubview:lbtime];
        [lbtime mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(lbname);
            make.top.equalTo(lbname.mas_bottom);
            make.height.offset(30);
        }];
        
        
        UIButton *btuse = [[UIButton alloc] init];
        [btuse setTitle:@"立即使用" forState:UIControlStateNormal];
        [btuse setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btuse.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [btuse setBackgroundColor:RadMenuColor];
        [btuse.layer setMasksToBounds:YES];
        [btuse.layer setCornerRadius:2];
        [viewback addSubview:btuse];
        [btuse mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.offset(80);
            make.height.offset(40);
            make.right.equalTo(viewback).offset(-10);
            make.centerY.equalTo(viewback);
        }];
        
        
    }
    return self;
}

@end
