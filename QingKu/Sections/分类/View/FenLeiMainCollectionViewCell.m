//
//  FenLeiMainCollectionViewCell.m
//  QingKu
//
//  Created by mdb-losaic on 2019/7/29.
//  Copyright © 2019 mcxzfa. All rights reserved.
//

#import "FenLeiMainCollectionViewCell.h"

@interface FenLeiMainCollectionViewCell ()
{
    UIImageView *imgvicn;
    UILabel *lbtitle;
}
@end

@implementation FenLeiMainCollectionViewCell

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
    UIView *viewback = [[UIView alloc] init];
    [viewback setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:viewback];
    [viewback mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    imgvicn = [[UIImageView alloc] init];
    [imgvicn setContentMode:UIViewContentModeScaleAspectFit];
    [imgvicn setBackgroundColor:[UIColor grayColor]];
    [viewback addSubview:imgvicn];
    [imgvicn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(viewback).multipliedBy(0.6);
        make.height.equalTo(viewback.mas_width).multipliedBy(0.6);
        make.centerX.equalTo(viewback);
        make.centerY.equalTo(viewback).offset(-15);
        
    }];
    
    lbtitle = [[UILabel alloc] init];
    [lbtitle setTextColor:RGB(130, 130, 130)];
    [lbtitle setTextAlignment:NSTextAlignmentCenter];
    [lbtitle setFont:[UIFont systemFontOfSize:14]];
    [viewback addSubview:lbtitle];
    [lbtitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(viewback);
        make.height.offset(30);
        make.top.equalTo(self->imgvicn.mas_bottom);
    }];
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [lbtitle setText:@"面部护肤"];
    
    
}

@end
