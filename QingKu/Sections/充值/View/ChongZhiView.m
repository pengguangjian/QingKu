//
//  ChongZhiView.m
//  QingKu
//
//  Created by mdb-losaic on 2019/9/2.
//  Copyright © 2019 mcxzfa. All rights reserved.
//

#import "ChongZhiView.h"


@interface ChongZhiView ()
{
    
    UIImageView *imgvewm;
}
@end

@implementation ChongZhiView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        
        [self drawUI];
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            UIImage *image = [self showerWeiMa:@"qwe"];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self->imgvewm setImage:image];
            });
        });
        
        
        
    }
    return self;
}

-(void)drawUI
{
    [self setBackgroundColor:RGB(234, 234, 234)];
    
    
    UIView *viewcenter = [[UIView alloc] init];
    [viewcenter setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:viewcenter];
    [viewcenter.layer setMasksToBounds:YES];
    [viewcenter.layer setCornerRadius:5];
    [viewcenter mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset(kMainScreenW-30);
        make.height.offset(kMainScreenW-30);
        make.center.equalTo(self);
    }];
    
    
    UIImageView *imgverweima = [[UIImageView alloc] init];
    [viewcenter addSubview:imgverweima];
    [imgverweima mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset(kMainScreenW-90);
        make.height.offset(kMainScreenW-90);
        make.centerX.equalTo(viewcenter);
        make.centerY.equalTo(viewcenter).offset(-10);
    }];
    imgvewm = imgverweima;
        
}

////生成二维码
- (UIImage *)showerWeiMa:(NSString *)value{
    if(value==nil)return [[UIImage alloc] init];
    // 1. 创建一个二维码滤镜实例(CIFilter)
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // 滤镜恢复默认设置
    [filter setDefaults];
    
    // 2. 给滤镜添加数据
    NSString *string = value;
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    // 使用KVC的方式给filter赋值
    [filter setValue:data forKeyPath:@"inputMessage"];
    
    // 3. 生成二维码
    CIImage *image = [filter outputImage];
    
    //4.在中心增加一张图片
    UIImage *img = [self createNonInterpolatedUIImageFormCIImage:image withSize:kMainScreenW*0.7];
    
    //5.把中央图片划入二维码里面
    //5.1开启图形上下文
    UIGraphicsBeginImageContext(img.size);
    //5.2将二维码的图片画入
    [img drawInRect:CGRectMake(0, 0, img.size.width, img.size.height)];
    
    ///二维码中心添加图标
    //    UIImage *centerImg = [UIImage imageNamed:@"home_Share_item0"];
    //    CGFloat centerW=img.size.width*0.3;
    //    CGFloat centerH=centerW;
    //    CGFloat centerX=(img.size.width-centerW)*0.5;
    //    CGFloat centerY=(img.size.height -centerH)*0.5;
    //    [centerImg drawInRect:CGRectMake(centerX, centerY, centerW, centerH)];
    //5.3获取绘制好的图片
    UIImage *finalImg=UIGraphicsGetImageFromCurrentImageContext();
    //5.4关闭图像上下文
    UIGraphicsEndImageContext();
    return finalImg;
}
/**
 *  调用该方法处理图像变清晰
 *  根据CIImage生成指定大小的UIImage
 *
 *  @param image CIImage
 *  @param size  图片宽度以及高度
 */
- (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size
{
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    //1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    //2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}


@end
