//
//  UIImage+ZLEX.m
//  LayZhangDemo
//
//  Created by LayZhang on 2017/5/9.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "UIImage+ZLEX.h"

@implementation UIImage (ZLEX)

#pragma mark - 这边用的imageWithBgColor方法截取屏幕颜色图片
+ (UIImage *)imageWithBgColor:(UIColor *)color{
    
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
    
}

+ (UIImage *)rendImageWithView:(UIView *)view{
    
    //      1.开始位图上下文,不能高清的保存图片
    //    UIGraphicsBeginImageContext(view.frame.size);
    //这个方法可以保存高清的图片
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 0.0);
    //      2.获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //    3.截图
    [view.layer renderInContext:ctx];
    //    4.获取图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    //    5.关闭上下文
    UIGraphicsEndImageContext() ;
    
    return newImage;
    
}


@end
