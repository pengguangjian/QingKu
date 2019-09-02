//
//  ChongZhiJiLuTableViewCell.m
//  QingKu
//
//  Created by mdb-losaic on 2019/9/2.
//  Copyright © 2019 mcxzfa. All rights reserved.
//

#import "ChongZhiJiLuTableViewCell.h"

@implementation ChongZhiJiLuTableViewCell

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
        [viewback setBackgroundColor:[UIColor whiteColor]];
        [self.contentView addSubview:viewback];
        [viewback mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.offset(15);
            make.right.equalTo(self).offset(-15);
            make.bottom.equalTo(self);
        }];
        [viewback.layer setMasksToBounds:YES];
        [viewback.layer setCornerRadius:5];
        
        UIImageView *imgvhead = [[UIImageView alloc] init];
        [imgvhead setImage:[UIImage imageNamed:@"chongzhijiluitem"]];
        [viewback addSubview:imgvhead];
        [imgvhead mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.offset(15);
            make.size.sizeOffset(CGSizeMake(35, 35));
        }];
        
        UILabel *lbtitle = [[UILabel alloc] init];
        [lbtitle setText:@"红旗河沟充值点（CZ90226）"];
        [lbtitle setTextColor:RGB(50, 50, 50)];
        [lbtitle setTextAlignment:NSTextAlignmentLeft];
        [lbtitle setNumberOfLines:2];
        [lbtitle setFont:[UIFont systemFontOfSize:15]];
        [viewback addSubview:lbtitle];
        [lbtitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(imgvhead.mas_right).offset(5);
            make.top.offset(5);
            make.right.equalTo(viewback).offset(-100);
            make.height.offset(40);
        }];
        
        
        
        UILabel *lbprice = [[UILabel alloc] init];
        [lbprice setText:@"+￥200.00"];
        [lbprice setTextColor:RadMenuColor];
        [lbprice setTextAlignment:NSTextAlignmentRight];
        [lbprice setFont:[UIFont systemFontOfSize:15]];
        [viewback addSubview:lbprice];
        [lbprice mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(viewback).offset(-10);
            make.top.equalTo(lbtitle);
            make.height.offset(40);
        }];
        
        
        UILabel *lbtime = [[UILabel alloc] init];
        [lbtime setText:@"2019-09-02 17:24:50"];
        lbtime.lee_theme.LeeConfigTextColor(@"lbtime");
        [lbtime setTextAlignment:NSTextAlignmentLeft];
        [lbtime setFont:[UIFont systemFontOfSize:13]];
        [viewback addSubview:lbtime];
        [lbtime mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(lbtitle);
            make.top.equalTo(lbtitle.mas_bottom);
            make.height.offset(20);
        }];
        
    }
    return self;
}



@end
