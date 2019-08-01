//
//  CollectsTableViewCell.m
//  QingKu
//
//  Created by mdb-losaic on 2019/7/31.
//  Copyright © 2019 mcxzfa. All rights reserved.
//

#import "CollectsTableViewCell.h"


@implementation CollectsTableViewCell

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
            make.left.right.equalTo(lbtitle);
            make.top.equalTo(lbtitle.mas_bottom).offset(10);
            make.height.offset(20);
        }];
        
        
        
    }
    return self;
}


@end
