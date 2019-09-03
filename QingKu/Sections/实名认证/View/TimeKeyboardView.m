//
//  TimeKeyboardView.m
//  JWT
//
//  Created by MACPRO  on 16/7/20.
//  Copyright © 2016年 com.cn. All rights reserved.
//

#import "TimeKeyboardView.h"

@implementation TimeKeyboardView
@synthesize viewselect,pickview,viewline1,viewline2,lbday,lbyear,lbhouar,lbmouth,lbmintes;
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.frame = CGRectMake(0, 0, kMainScreenW, kMainScreenH);
        
        viewselect = [[UIView alloc]initWithFrame:CGRectZero];
        [viewselect setBackgroundColor:[UIColor whiteColor]];
        
        viewline1 = [[UIView alloc]initWithFrame:CGRectZero];
        [viewline1 setBackgroundColor:[UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1]];
        
        viewline2 = [[UIView alloc]initWithFrame:CGRectZero];
        [viewline2 setBackgroundColor:[UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1]];
        
        
        pickview = [[UIPickerView alloc]initWithFrame:CGRectZero];
        [pickview setDelegate:self];
        [pickview setDataSource:self];
        [pickview setBackgroundColor:[UIColor whiteColor]];
        
        lbyear = [[UILabel alloc]initWithFrame:CGRectZero];
        [lbyear setTextColor:[UIColor colorWithRed:84/255.0 green:84/255.0 blue:84/255.0 alpha:1]];
        [lbyear setTextAlignment:NSTextAlignmentCenter];
        [lbyear setFont:[UIFont fontWithName:@"Arial" size:14]];
        
        lbmouth = [[UILabel alloc]initWithFrame:CGRectZero];
        [lbmouth setTextColor:[UIColor colorWithRed:84/255.0 green:84/255.0 blue:84/255.0 alpha:1]];
        [lbmouth setTextAlignment:NSTextAlignmentCenter];
        [lbmouth setFont:[UIFont fontWithName:@"Arial" size:14]];
        
        
        lbday = [[UILabel alloc]initWithFrame:CGRectZero];
        [lbday setTextColor:[UIColor colorWithRed:84/255.0 green:84/255.0 blue:84/255.0 alpha:1]];
        [lbday setTextAlignment:NSTextAlignmentCenter];
        [lbday setFont:[UIFont fontWithName:@"Arial" size:14]];
        
        lbhouar = [[UILabel alloc]initWithFrame:CGRectZero];
        [lbhouar setTextColor:[UIColor colorWithRed:84/255.0 green:84/255.0 blue:84/255.0 alpha:1]];
        [lbhouar setTextAlignment:NSTextAlignmentCenter];
        [lbhouar setFont:[UIFont fontWithName:@"Arial" size:14]];
        
        lbmintes = [[UILabel alloc]initWithFrame:CGRectZero];
        [lbmintes setTextColor:[UIColor colorWithRed:84/255.0 green:84/255.0 blue:84/255.0 alpha:1]];
        [lbmintes setTextAlignment:NSTextAlignmentCenter];
        [lbmintes setFont:[UIFont fontWithName:@"Arial" size:14]];
        
        
        UIButton *cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        cancleBtn.tag = 3;
        [cancleBtn setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
        [cancleBtn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [cancleBtn setBackgroundColor:[UIColor whiteColor]];
        [cancleBtn setTitle:[MDB_UserDefault getSetStringNmae:@"quxiao"] forState:UIControlStateNormal];
        [self addSubview:cancleBtn];
        btquxiao = cancleBtn;
        
        UIButton *finishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        finishBtn.tag = 4;
        [finishBtn setTitle:[MDB_UserDefault getSetStringNmae:@"queding"] forState:UIControlStateNormal];
        [finishBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [finishBtn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [finishBtn setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:finishBtn];
        btqueding = finishBtn;
        
        viewline00 = [[UIView alloc]initWithFrame:CGRectZero];
        [viewline00 setBackgroundColor:[UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1]];
        [self addSubview:viewline00];
        
        viewline01 = [[UIView alloc]initWithFrame:CGRectZero];
        [viewline01 setBackgroundColor:[UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1]];
        [self addSubview:viewline01];
    }
    return self;
}
///获取当前时间 yyyy-MM-dd HH:mm:ss
-(NSString *)getnowdata:(NSString *)strtype
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:strtype];
    
    NSDate *data = [NSDate date];
    NSString *str = [formatter stringFromDate:data];
    return str;
}
#pragma mark - 根据年和月  返回当前月的天数
-(int)countday:(NSString *)year andmouth:(NSString *)mouth
{
    NSMutableArray *arrdata = [[NSMutableArray alloc]initWithObjects:@"31",@"28",@"31",@"30",@"31",@"30",@"31",@"31",@"30",@"31",@"30",@"31", nil];
    if([year intValue]%4 == 0)
    {
        if([year intValue]%100 == 0)
        {
            if([year intValue]%400 == 0)
            {
                arrdata[1] = @"29";
            }
            else
            {
                arrdata[1] = @"28";
            }
            
        }
        else
        {
            arrdata[1] = @"29";
        }
        
    }
    else
    {
        arrdata[1] = @"28";
    }
    return [arrdata[[mouth intValue]-1] intValue];
}
-(void)getdata
{
    arryear = [NSMutableArray new];
    arrmouth = [NSMutableArray new];
    arrday = [NSMutableArray new];
    arrhouar = [NSMutableArray new];
    arrmintes = [NSMutableArray new];
    
    NSString *strnowtime = [self getnowdata:@"yyyy-MM-dd HH:mm:ss"];
    strnowtime = [strnowtime stringByReplacingOccurrencesOfString:@" " withString:@":"];
    strnowtime = [strnowtime stringByReplacingOccurrencesOfString:@"-" withString:@":"];
    arrnowtime = [strnowtime componentsSeparatedByString:@":"];
    
    stryear = arrnowtime[0];
    strmouth= arrnowtime[1];
    strday= arrnowtime[2];
    strhouar= arrnowtime[3];
    strmintes= arrnowtime[4];
    if(_isNotnowtime == YES)
    {
        for(int i = 1900;i<=[arrnowtime[0] intValue]+10;i++)
        {
            
            [arryear addObject:[NSString stringWithFormat:@"%d",i]];
            
        }
        for(int j = 1;j<=12;j++)
        {
            [arrmouth addObject:[NSString stringWithFormat:@"%d",j]];
        }
        for(int j = 1;j<=31;j++)
        {
            [arrday addObject:[NSString stringWithFormat:@"%d",j]];
        }
        for(int j = 0;j<=24;j++)
        {
            [arrhouar addObject:[NSString stringWithFormat:@"%d",j]];
        }
        for(int j = 0;j<=60;j++)
        {
            [arrmintes addObject:[NSString stringWithFormat:@"%d",j]];
        }
    }
    else
    {
        for(int i = 1900;i<=[arrnowtime[0] intValue];i++)
        {
            
            [arryear addObject:[NSString stringWithFormat:@"%d",i]];
            
        }
        for(int j = 1;j<=[arrnowtime[1] intValue];j++)
        {
            [arrmouth addObject:[NSString stringWithFormat:@"%d",j]];
        }
        for(int j = 1;j<=[arrnowtime[2] intValue];j++)
        {
            [arrday addObject:[NSString stringWithFormat:@"%d",j]];
        }
        for(int j = 0;j<=[arrnowtime[3] intValue];j++)
        {
            [arrhouar addObject:[NSString stringWithFormat:@"%d",j]];
        }
        for(int j = 0;j<=[arrnowtime[4] intValue];j++)
        {
            [arrmintes addObject:[NSString stringWithFormat:@"%d",j]];
        }
    }
    
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [self setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.4]];
    
//    UITapGestureRecognizer *tapview = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismisself)];
//    [self addGestureRecognizer:tapview];
    
    if(viewselect.height <= 1)
    {
        [self getdata];
        
        [pickview setFrame:CGRectMake(0, self.height-240, self.width, 200)];
        [self addSubview:pickview];
        [pickview setBottom:self.height-40];
        
        [viewselect setFrame:CGRectMake(0, pickview.top-40, self.width, 40)];
        [self addSubview:viewselect];
        
        if(_iline == 3)
        {
            [lbyear setFrame:CGRectMake(0, 0, viewselect.width/3.0, viewselect.height)];
            [lbyear setText:[MDB_UserDefault getSetStringNmae:@"nian"]];
            [viewselect addSubview:lbyear];
            
            [lbmouth setFrame:CGRectMake(lbyear.right, 0, viewselect.width/3.0, viewselect.height)];
            [lbmouth setText:[MDB_UserDefault getSetStringNmae:@"yue"]];
            [viewselect addSubview:lbmouth];
            
            [lbday setFrame:CGRectMake(lbmouth.right, 0, viewselect.width/3.0, viewselect.height)];
            [lbday setText:[MDB_UserDefault getSetStringNmae:@"ri"]];
            [viewselect addSubview:lbday];
            
        }
        else
        {
            [lbyear setFrame:CGRectMake(0, 0, viewselect.width/5.0, viewselect.height)];
            [lbyear setText:[MDB_UserDefault getSetStringNmae:@"nian"]];
            [viewselect addSubview:lbyear];
            
            [lbmouth setFrame:CGRectMake(lbyear.right, 0, viewselect.width/5.0, viewselect.height)];
            [lbmouth setText:[MDB_UserDefault getSetStringNmae:@"yue"]];
            [viewselect addSubview:lbmouth];
            
            [lbday setFrame:CGRectMake(lbmouth.right, 0, viewselect.width/5.0, viewselect.height)];
            [lbday setText:[MDB_UserDefault getSetStringNmae:@"ri"]];
            [viewselect addSubview:lbday];
            
            [lbhouar setFrame:CGRectMake(lbday.right, 0, viewselect.width/5.0, viewselect.height)];
            [lbhouar setText:@"时"];
            [viewselect addSubview:lbhouar];
            
            [lbmintes setFrame:CGRectMake(lbhouar.right, 0, viewselect.width/5.0, viewselect.height)];
            [lbmintes setText:@"分"];
            [viewselect addSubview:lbmintes];
        }
        
        
        
        [viewline1 setFrame:CGRectMake(0, 0, viewselect.width, 1)];
        [viewselect addSubview:viewline1];
        
        
        [viewline2 setFrame:CGRectMake(0, viewselect.height-1, viewselect.width, 1)];
        [viewselect addSubview:viewline2];
        
        
        [btquxiao setFrame:CGRectMake(0, pickview.bottom, pickview.width/2.0, 40)];
        [btqueding setFrame:CGRectMake(btquxiao.right, btquxiao.top, btquxiao.width, btquxiao.height)];
        [viewline00 setFrame:CGRectMake(0, pickview.bottom, pickview.width, 1)];
        [viewline01 setFrame:CGRectMake(btquxiao.right, pickview.bottom, 1, btqueding.height)];
        
        
        
        [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(selecttempaction) userInfo:nil repeats:NO];
        
    }
    
    
}

-(void)selecttempaction
{
    if(_iline == 3)
    {
        [pickview selectRow:100 inComponent:0 animated:YES];
        [pickview selectRow:1 inComponent:1 animated:YES];
        [pickview selectRow:1 inComponent:2 animated:YES];
        
        
        [self.degelate changeValue:[NSString stringWithFormat:@"%@-%@-%@",stryear,strmouth,strday]];
    }
    else
    {
        [pickview selectRow:arryear.count-1 inComponent:0 animated:YES];
        [pickview selectRow:arrmouth.count-1 inComponent:1 animated:YES];
        [pickview selectRow:arrday.count-1 inComponent:2 animated:YES];
        [pickview selectRow:arrhouar.count-1 inComponent:3 animated:YES];
        [pickview selectRow:arrmintes.count-1 inComponent:4 animated:YES];
        
        [self.degelate changeValue:[NSString stringWithFormat:@"%@-%@-%@ %@:%@",stryear,strmouth,strday,strhouar,strmintes]];
    }
    
}


-(void)dismisself
{
    
    
}

-(void)btnClicked:(UIButton *)btn
{
    if (btn.tag == 3) {
        [self removeFromSuperview];
    }else if (btn.tag == 4){
        if ([self.degelate respondsToSelector:@selector(changeValue:)]) {
            [self.degelate changeValue:[NSString stringWithFormat:@"%@-%@-%@",stryear,strmouth,strday]];
        }
        [self removeFromSuperview];
    }
}

#pragma mark - UIPickerView
// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return _iline;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if(component == 0)
    {
        return arryear.count;
    }
    else if(component == 1)
    {
        return arrmouth.count;
    }
    else if(component == 2)
    {
        return arrday.count;
    }
    else if(component == 3)
    {
        return arrhouar.count;
    }
    else if(component == 4)
    {
        return arrmintes.count;
    }
    return 0;
}
// returns width of column and height of row for each component.
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    float fline = 5.2;
    if(_iline == 3)
    {
        fline = 3.2;
    }
    return pickerView.width/fline;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 40;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:( UIView *)view
{
    float fline = 5.2;
    if(_iline == 3)
    {
        fline = 3.2;
    }
    UILabel *lb = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, pickerView.width/fline, 40)];
    if(component == 0)
    {
        [lb setText:arryear[row]];
    }
    else if(component == 1)
    {
        [lb setText:arrmouth[row]];
    }
    else if(component == 2)
    {
        [lb setText:arrday[row]];
    }
    else if(component == 3)
    {
        [lb setText:arrhouar[row]];
    }
    else if(component == 4)
    {
        [lb setText:arrmintes[row]];
    }
    
    [lb setTextColor:[UIColor colorWithRed:84/255.0 green:84/255.0 blue:84/255.0 alpha:1]];
    [lb setTextAlignment:NSTextAlignmentCenter];
    [lb setFont:[UIFont fontWithName:@"Arial" size:14]];
    return lb;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if(component == 0)
    {
        stryear = arryear[row];
        
        [self yearjudge];
        [self mouthjudge];
        [self dayjudge];
        [self houarjudge];
        
        
        [pickerView reloadAllComponents];
        
    }
    else if(component == 1)
    {
        strmouth = arrmouth[row];
        
        [self mouthjudge];
        [self dayjudge];
        [self houarjudge];
        
        [pickerView reloadAllComponents];
        
    }
    else if(component == 2)
    {
     
        strday = arrday[row];
        
        [self dayjudge];
        [self houarjudge];
        
        [pickerView reloadAllComponents];
        
        
    }
    else if(component == 3)
    {
        
        strhouar = arrhouar[row];
        
        [self houarjudge];
        
        [pickerView reloadComponent:4];
        
    }
    else if(component == 4)
    {
        strmintes = arrmintes[row];
    }
    
    if([strmouth intValue] < 10)
    {
        strmouth = [NSString stringWithFormat:@"0%d",[strmouth intValue]];
    }
    if([strday intValue] < 10)
    {
        strday = [NSString stringWithFormat:@"0%d",[strday intValue]];
    }
    if([strhouar intValue] < 10)
    {
        strhouar = [NSString stringWithFormat:@"0%d",[strhouar intValue]];
    }
    if([strmintes intValue] < 10)
    {
        strmintes = [NSString stringWithFormat:@"0%d",[strmintes intValue]];
    }
    
    [self.degelate changeValue:[NSString stringWithFormat:@"%@-%@-%@",stryear,strmouth,strday]];
    
}

-(void)yearjudge
{
    if(_isNotnowtime == YES)
    {
        arrmouth = [NSMutableArray new];
        for(int i =1; i <= 12;i++)
        {
            [arrmouth addObject:[NSString stringWithFormat:@"%d",i]];
        }
    }
    else
    {
        if([stryear intValue] == [arrnowtime[0]intValue])
        {
            arrmouth = [NSMutableArray new];
            for(int i =1; i <= [arrnowtime[1] intValue];i++)
            {
                [arrmouth addObject:[NSString stringWithFormat:@"%d",i]];
            }
            if([strmouth intValue] > [arrnowtime[1] intValue])
            {
                strmouth =arrnowtime[1];
            }
            [self mouthjudge];
            
        }
        else
        {
            arrmouth = [NSMutableArray new];
            for(int i =1; i <= 12;i++)
            {
                [arrmouth addObject:[NSString stringWithFormat:@"%d",i]];
            }
        }
    }
    
    
}

-(void)mouthjudge
{
    if(_isNotnowtime == YES)
    {
        arrday = [NSMutableArray new];
        for(int i =1; i <= [self countday:stryear andmouth:strmouth];i++)
        {
            [arrday addObject:[NSString stringWithFormat:@"%d",i]];
        }
    }
    else
    {
        if([strmouth intValue] == [arrnowtime[1]intValue]&&[stryear intValue] == [arrnowtime[0]intValue])
        {
            arrday = [NSMutableArray new];
            for(int i =1; i <= [arrnowtime[2] intValue];i++)
            {
                [arrday addObject:[NSString stringWithFormat:@"%d",i]];
            }
            if([strday intValue] > [arrnowtime[2] intValue])
            {
                strday =arrnowtime[2];
            }
            
            [self dayjudge];
        }
        else
        {
            arrday = [NSMutableArray new];
            for(int i =1; i <= [self countday:stryear andmouth:strmouth];i++)
            {
                [arrday addObject:[NSString stringWithFormat:@"%d",i]];
            }
        }
    }
    
}

-(void)dayjudge
{
    
    if([strday intValue] == [arrnowtime[2]intValue]&&[strmouth intValue] == [arrnowtime[1]intValue]&&[stryear intValue] == [arrnowtime[0]intValue])
    {
        arrhouar = [NSMutableArray new];
        for(int i =0; i <= [arrnowtime[3] intValue];i++)
        {
            [arrhouar addObject:[NSString stringWithFormat:@"%d",i]];
        }
        if([strhouar intValue] > [arrnowtime[3] intValue])
        {
            strhouar =arrnowtime[3];
        }
        [self houarjudge];
    }
    else
    {
        arrhouar = [NSMutableArray new];
        for(int i =0; i <= 23;i++)
        {
            [arrhouar addObject:[NSString stringWithFormat:@"%d",i]];
        }
    }
}

-(void)houarjudge
{
    
    if([strhouar intValue] == [arrnowtime[3]intValue]&&[strday intValue] == [arrnowtime[2]intValue]&&[strmouth intValue] == [arrnowtime[1]intValue]&&[stryear intValue] == [arrnowtime[0]intValue])
    {
        arrmintes = [NSMutableArray new];
        for(int i =0; i <= [arrnowtime[4] intValue];i++)
        {
            [arrmintes addObject:[NSString stringWithFormat:@"%d",i]];
        }
    }
    else
    {
        arrmintes = [NSMutableArray new];
        for(int i =0; i <= 59;i++)
        {
            [arrmintes addObject:[NSString stringWithFormat:@"%d",i]];
        }
    }
}

@end
