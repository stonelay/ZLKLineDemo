//
//  UIView+QuickNew.h
//  LayZhangDemo
//
//  Created by LayZhang on 2017/5/25.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (QuickNew)

//快速创建一个按钮
+ (UIButton *)buttonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor titleFont:(NSInteger)font;

+ (UIButton *)buttonWithImage:(NSString *)imageName backImageNamed:(NSString *)backName;

//快速创建一个按钮带背景图
+ (UIButton *)buttonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor titleFont:(NSInteger)font backImageNamed:(NSString *)name;

//快速创建一个按钮 带图片
+ (UIButton *)buttonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor titleFont:(NSInteger)font imageNamed:(NSString *)imageNamed;

//UILabel
+ (UILabel *)labelWithText:(NSString *)text textColor:(UIColor *)color font:(NSInteger)font textAliment:(NSTextAlignment)textAliment;


#pragma mark - 快速创建button的方法
+ (UIButton *)buttonWithTitle:(NSString *)title action:(SEL)action tag:(NSInteger)tag buttonWidth:(CGFloat)buttonWidth buttonHeight:(CGFloat)buttonHeight color:(NSInteger)color font:(NSInteger)font;

//在导航栏上加一个按钮
+ (UIButton *)getTopButton;

//创建一个圆角按钮
+ (UIButton *)roundButtonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor titleFont:(CGFloat)font backgroundColor:(UIColor *)backgroundColor frame:(CGRect)frame;

//输入框
+ (UITextField *)textFieldWithFont:(CGFloat)font color:(UIColor *)color placeholder:(NSString *)placeholder;

@end
