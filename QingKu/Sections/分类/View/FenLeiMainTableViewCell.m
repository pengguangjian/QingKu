//
//  FenLeiMainTableViewCell.m
//  QingKu
//
//  Created by mdb-losaic on 2019/7/29.
//  Copyright © 2019 mcxzfa. All rights reserved.
//

#import "FenLeiMainTableViewCell.h"

@interface FenLeiMainTableViewCell ()
{
    UIView *viewback;
    UILabel *lbtitle;
    UIView *viewlline;
}

@end


@implementation FenLeiMainTableViewCell

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
        [self drawUI];
    }
    return self;
}

-(void)drawUI
{
    viewback = [[UIView alloc] init];
    [viewback setBackgroundColor:RGB(245, 245, 245)];
    [self.contentView addSubview:viewback];
    [viewback mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    lbtitle = [[UILabel alloc] init];
    [lbtitle setTextColor:RGB(0, 0, 0)];
    [lbtitle setTextAlignment:NSTextAlignmentCenter];
    [lbtitle setFont:[UIFont systemFontOfSize:14]];
    [viewback addSubview:lbtitle];
    [lbtitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self->viewback);
    }];
    
    UIView *viewline = [[UIView alloc] init];
    [viewline setBackgroundColor:RGB(231, 231, 231)];
    [viewback addSubview:viewline];
    [viewline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self->viewback);
        make.height.offset(1);
    }];
    
    viewlline = [[UIView alloc] init];
    [viewlline setBackgroundColor:RGB(231, 231, 231)];
    [viewback addSubview:viewlline];
    [viewlline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.equalTo(self->viewback);
        make.width.offset(1);
    }];
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    [lbtitle setText:@"美妆护肤"];
    if(_isselect)
    {
        [lbtitle setTextColor:RGB(9, 186, 104)];
        [viewlline setHidden:YES];
        [viewback setBackgroundColor:[UIColor whiteColor]];
    }
    else
    {
        [viewlline setHidden:NO];
        [viewback setBackgroundColor:RGB(245, 245, 245)];
        [lbtitle setTextColor:RGB(0, 0, 0)];
    }
    
}

@end
