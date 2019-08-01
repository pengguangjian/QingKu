//
//  OrderWuLiuDetailTableViewCell.m
//  QingKu
//
//  Created by mdb-losaic on 2019/8/1.
//  Copyright © 2019 mcxzfa. All rights reserved.
//

#import "OrderWuLiuDetailTableViewCell.h"


@interface OrderWuLiuDetailTableViewCell ()
{
    UIView *viewback;
    
    UIImageView *imgvyuan;
    
    UIView *viewline;
    
    UILabel *lbname;
    
    UILabel *lbtime;
}
@end

@implementation OrderWuLiuDetailTableViewCell
@synthesize iline,islast;

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
        
        viewback = [[UIView alloc] initWithFrame:CGRectZero];
        [viewback setBackgroundColor:[UIColor whiteColor]];
        [self.contentView addSubview:viewback];
        
        imgvyuan = [[UIImageView alloc] initWithFrame:CGRectZero];
        [viewback addSubview:imgvyuan];
        
        
        
        viewline = [[UIView alloc] initWithFrame:CGRectZero];
        [viewline setBackgroundColor:RGB(187,187,187)];
        [viewback addSubview:viewline];
        
        lbname = [[UILabel alloc] initWithFrame:CGRectZero];
        [lbname setTextColor:RGB(102,102,102)];
        [lbname setTextAlignment:NSTextAlignmentLeft];
        [lbname setFont:[UIFont systemFontOfSize:12]];
        [lbname setNumberOfLines:3];
        [viewback addSubview:lbname];
        
        lbtime = [[UILabel alloc] initWithFrame:CGRectZero];
        [lbtime setTextColor:RGB(153,153,153)];
        [lbtime setTextAlignment:NSTextAlignmentLeft];
        [lbtime setFont:[UIFont systemFontOfSize:12]];
        [viewback addSubview:lbtime];
        
        
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [viewback setFrame:CGRectMake(0, 0, self.width, self.height)];
    
    
    [viewline setFrame:CGRectMake(63*kScale, 0, 1, viewback.height)];
    if(islast)
    {
        [viewline setHeight:0];
    }
    
    
    [imgvyuan setFrame:CGRectMake(0, 0, 18*kScale, 18*kScale)];
    [imgvyuan setCenter:CGPointMake(viewline.center.x, 0)];
    [imgvyuan setTop:0];
    [imgvyuan setImage:[UIImage imageNamed:@"wuliu_other_no"]];
    
    [lbname setFrame:CGRectMake(imgvyuan.right+15, 0, viewback.width-imgvyuan.right-25, 20)];
//    [lbname setText:model.strname];
    [lbname setText:@"物流到达了哪里物流到达了哪里物流到达了哪"];
    [lbname sizeToFit];
    [lbname setTextColor:RGB(102,102,102)];
    
    [lbtime setFrame:CGRectMake(lbname.left, lbname.bottom, viewback.width-imgvyuan.right-25, 20)];
    [lbtime setText:@"2019.0801 11:05:30"];
    [lbtime setTextColor:RGB(153,153,153)];
    
    
    if(iline == 0)
    {
        [imgvyuan setImage:[UIImage imageNamed:@"wuliu_first_yes"]];
        [lbname setTextColor:RGB(248,134,28)];
        [lbtime setTextColor:RGB(248,134,28)];
    }
    
    [viewback bringSubviewToFront:imgvyuan];
    
    
    
    
}



@end
