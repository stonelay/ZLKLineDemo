//
//  NSString+ZLEX.h
//  LayZhangDemo
//
//  Created by LayZhang on 2017/5/12.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ZLEX)

- (void)showNotice;

- (NSString *)trim;


/**
 计算 size

 @param font 字体大小
 @param width 限定宽度
 @return 计算所得 size
 */
- (CGSize)sizeWithUIFont:(UIFont *)font forWidth:(CGFloat)width;


/**
 计算 size

 @param attribute 富文本 属性
 @param width 限定宽度
 @return 计算所得 size
 */
- (CGSize)sizeWithUIAttribute:(NSDictionary *)attribute forWidth:(CGFloat)width;

- (CGSize)sizeWithSize:(CGSize)size font:(NSInteger)font;

@end
