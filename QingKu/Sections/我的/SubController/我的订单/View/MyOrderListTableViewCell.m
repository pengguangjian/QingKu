//
//  MyOrderListTableViewCell.m
//  QingKu
//
//  Created by mdb-losaic on 2019/7/31.
//  Copyright © 2019 mcxzfa. All rights reserved.
//

#import "MyOrderListTableViewCell.h"


@interface MyOrderListTableViewCell ()
{
    UIView *viewback;
    
    
    UIImageView *imgvpic;
    
    UILabel *lbpindan;
    
    UILabel *lbtuanzhang;
    
    UILabel *lbtitle;
    
    UILabel *lbprice;
    
    UILabel *lbpther;
    
    UILabel *lbcount;
    
    UILabel *lbxianhuo;
    
    UIView *viewline;
}
@end

@implementation MyOrderListTableViewCell

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
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        
        viewback = [[UIView alloc] initWithFrame:CGRectZero];
        [viewback setBackgroundColor:[UIColor whiteColor]];
        [self.contentView addSubview:viewback];
        
        
        imgvpic = [[UIImageView alloc] initWithFrame:CGRectZero];
        [imgvpic.layer setMasksToBounds:YES];
        [viewback addSubview:imgvpic];
        
//        lbpindan = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 37, 17)];
//        [lbpindan setTextColor:[UIColor whiteColor]];
//        [lbpindan setTextAlignment:NSTextAlignmentCenter];
//        [lbpindan setFont:[UIFont systemFontOfSize:11]];
//        [lbpindan setBackgroundColor:RGB(243,93,0)];
//        [lbpindan.layer setMasksToBounds:YES];
//        [lbpindan.layer setCornerRadius:2];
//        [lbpindan setText:@"拼单"];
//        [imgvpic addSubview:lbpindan];
//
//        lbtuanzhang = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, 37, 17)];
//        [lbtuanzhang setTextColor:RGB(243,93,0)];
//        [lbtuanzhang setTextAlignment:NSTextAlignmentCenter];
//        [lbtuanzhang setFont:[UIFont systemFontOfSize:11]];
//        [lbtuanzhang setBackgroundColor:[UIColor whiteColor]];
//        [lbtuanzhang.layer setMasksToBounds:YES];
//        [lbtuanzhang.layer setCornerRadius:2];
//        [lbtuanzhang.layer setBorderColor:RGB(243,93,0).CGColor];
//        [lbtuanzhang.layer setBorderWidth:1];
//        [lbtuanzhang setText:@"团长"];
//        [lbtuanzhang setHidden:YES];
//        [imgvpic addSubview:lbtuanzhang];
//
//        lbxianhuo = [[UILabel alloc] initWithFrame:CGRectMake(3, 0, 37, 17)];
//        [lbxianhuo setTextColor:RGB(243,93,0)];
//        [lbxianhuo setTextAlignment:NSTextAlignmentCenter];
//        [lbxianhuo setFont:[UIFont systemFontOfSize:11]];
//        [lbxianhuo setBackgroundColor:[UIColor whiteColor]];
//        [lbxianhuo.layer setMasksToBounds:YES];
//        [lbxianhuo.layer setCornerRadius:2];
//        [lbxianhuo.layer setBorderColor:RGB(243,93,0).CGColor];
//        [lbxianhuo.layer setBorderWidth:1];
//        [lbxianhuo setText:@"现货"];
//        [lbxianhuo setHidden:YES];
//        [imgvpic addSubview:lbxianhuo];
        
        lbtitle = [[UILabel alloc] initWithFrame:CGRectZero];
        [lbtitle setTextColor:RGB(102,102,102)];
        [lbtitle setTextAlignment:NSTextAlignmentLeft];
        [lbtitle setFont:[UIFont systemFontOfSize:14]];
        [lbtitle setNumberOfLines:2];
        [viewback addSubview:lbtitle];
        
        lbprice = [[UILabel alloc] initWithFrame:CGRectZero];
        [lbprice setTextColor:RGB(243,93,0)];
        [lbprice setTextAlignment:NSTextAlignmentRight];
        [lbprice setFont:[UIFont systemFontOfSize:13]];
        [lbprice setNumberOfLines:2];
        [viewback addSubview:lbprice];
        
        lbpther = [[UILabel alloc] initWithFrame:CGRectZero];
        [lbpther setTextColor:RGB(153,153,153)];
        [lbpther setTextAlignment:NSTextAlignmentLeft];
        [lbpther setFont:[UIFont systemFontOfSize:12]];
        [lbpther setNumberOfLines:2];
        [viewback addSubview:lbpther];
        
        lbcount = [[UILabel alloc] initWithFrame:CGRectZero];
        [lbcount setTextColor:RGB(153,153,153)];
        [lbcount setTextAlignment:NSTextAlignmentRight];
        [lbcount setFont:[UIFont systemFontOfSize:12]];
        [viewback addSubview:lbcount];
        
        
        viewline = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 1)];
        [viewline setBackgroundColor:RGB(236,236,236)];
        [viewback addSubview:viewline];
        
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    
    [viewback setFrame:CGRectMake(0, 0, self.width, self.height)];
    
    [imgvpic setFrame:CGRectMake(10, 10, 80, 80)];
    [imgvpic.layer setCornerRadius:4];
//    [[MDB_UserDefault defaultInstance] setViewWithImage:imgvpic url:_model.image];
    [imgvpic setContentMode:UIViewContentModeScaleAspectFit];
    [imgvpic setBackgroundColor:[UIColor grayColor]];
    
    [lbtitle setFrame:CGRectMake(imgvpic.right+8, imgvpic.top, viewback.width-imgvpic.right-90, 35)];
//    [lbtitle setText:_model.title];
    [lbtitle setText:@"商品标题商品标题商品标题商品标题"];
    
    [lbprice setFrame:CGRectMake(lbtitle.right, lbtitle.top, viewback.width-lbtitle.right-10, lbtitle.height)];
//    [lbprice setText:[NSString stringWithFormat:@"￥%@", _model.spprice]];
    [lbprice setText:@"￥120.0"];
    
    
    [lbpther setFrame:CGRectMake(lbtitle.left, lbtitle.bottom+5, lbtitle.width, 35)];
//    [lbpther setText:_model.spec_val];//
    [lbpther setText:@"规格"];
    
    [lbcount setFrame:CGRectMake(lbpther.right, lbpther.top, viewback.width-lbpther.right-10, lbpther.height)];
//    [lbcount setText:[NSString stringWithFormat:@"x%@",_model.num]];
    [lbcount setText:@"1"];
    
    [viewline setFrame:CGRectMake(0, viewback.height-1, viewback.width, 1)];
    if(_islast)
    {
        [viewline setHidden:YES];
    }
    else
    {
        [viewline setHidden:NO];
    }
    
}

@end
