//
//  NewPeopleBuyTableViewCell.m
//  QingKu
//
//  Created by mdb-losaic on 2019/7/30.
//  Copyright © 2019 mcxzfa. All rights reserved.
//

#import "NewPeopleBuyTableViewCell.h"
#import "MDB_UserDefault.h"

@interface NewPeopleBuyTableViewCell ()

@end

@implementation NewPeopleBuyTableViewCell

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
            make.edges.equalTo(self);
        }];
        
        UIImageView *imgvhead = [[UIImageView alloc] init];
        [imgvhead setBackgroundColor:[UIColor grayColor]];
        [viewback addSubview:imgvhead];
        [imgvhead mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.offset(15);
            make.bottom.equalTo(viewback).offset(-15);
            make.width.equalTo(viewback.mas_height).offset(-30);
        }];
        
        UILabel *lbtitle = [[UILabel alloc] init];
        [lbtitle setText:@"标题标题标题标题标题标题标题标题标题标题"];
        [lbtitle setTextColor:RGB(50, 50, 50)];
        [lbtitle setTextAlignment:NSTextAlignmentLeft];
        [lbtitle setNumberOfLines:2];
        [lbtitle setFont:[UIFont systemFontOfSize:15]];
        [viewback addSubview:lbtitle];
        [lbtitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(imgvhead.mas_right).offset(10);
            make.top.equalTo(imgvhead);
            make.right.equalTo(viewback).offset(-15);
            make.height.offset(40);
        }];
        
        
        
        UILabel *lbprice = [[UILabel alloc] init];
        [lbprice setText:@"￥199.00"];
        [lbprice setTextColor:[UIColor redColor]];
        [lbprice setTextAlignment:NSTextAlignmentLeft];
        [lbprice setFont:[UIFont systemFontOfSize:15]];
        [viewback addSubview:lbprice];
        [lbprice mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(lbtitle);
            make.top.equalTo(lbtitle.mas_bottom);
            make.height.offset(20);
        }];
        
        
        
        UILabel *lblastprice = [[UILabel alloc] init];
        [lblastprice setText:@"￥699.00"];
        [lblastprice setTextColor:RGB(180, 180, 180)];
        [lblastprice setTextAlignment:NSTextAlignmentLeft];
        [lblastprice setFont:[UIFont systemFontOfSize:14]];
        [viewback addSubview:lblastprice];
        [lblastprice mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(lbprice.mas_right).offset(10);
            make.bottom.equalTo(lbprice);
            make.height.offset(20);
        }];
        [lblastprice setAttributedText:[MDB_UserDefault arrstring:lblastprice.text andstart:0 andend:(int)lblastprice.text.length andNSAttributedStringKey:1]];
        
        
        
        
        UILabel *lbstate = [[UILabel alloc] init];
        [lbstate setText:@"已抢光"];
        [lbstate setTextColor:RGB(255, 255, 255)];
        [lbstate setTextAlignment:NSTextAlignmentCenter];
        [lbstate setFont:[UIFont systemFontOfSize:15]];
        [lbstate setBackgroundColor:RGBAlpha(0, 0, 0, 0.6)];
        [viewback addSubview:lbstate];
        [lbstate mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(lbtitle.mas_right);
            make.top.equalTo(lbtitle).offset(3);
            make.height.offset(70);
            make.width.offset(70);
        }];
        [lbstate.layer setMasksToBounds:YES];
        [lbstate.layer setCornerRadius:35];
        
        
    }
    return self;
}


@end
