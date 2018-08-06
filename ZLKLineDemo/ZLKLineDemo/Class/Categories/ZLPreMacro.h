//
//  ZLPreMacro.h
//  LayZhangDemo
//
//  Created by LayZhang on 2017/5/8.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#ifndef ZLPreMacro_h
#define ZLPreMacro_h

/** import category or other third part **/
#pragma mark - import file
#import "UIView+ZLEX.h"
#import "UIView+QuickNew.h"
#import "UIImage+ZLEX.h"
#import "CALayer+ZLEX.h"
#import "UIButton+ZLEX.h"
#import "NSString+ZLEX.h"
//#import "UIView+BlocksKit.h"

/** screen util**/
#pragma mark - screen
#define Screen [UIScreen mainScreen]
#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREENBOUNDS [UIScreen mainScreen].bounds
#define SCREENSCALE [UIScreen mainScreen].scale
#define LINEWIDTH   1.f / [UIScreen mainScreen].scale
#define STATUSBARHEIGHT             20.f
#define NAVBARCONTAINERHEIGHT       44.f
#define NAVBARHEIGHT                (NAVBARCONTAINERHEIGHT + STATUSBARHEIGHT)


/** color **/
#pragma mark - color
#define ZLWhiteColor    [UIColor whiteColor]
#define ZLClearColor    [UIColor clearColor]
#define ZLBlackColor    [UIColor blackColor]
#define ZLRedColor      [UIColor redColor]



#define ZLRGBA(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define ZLRGB(r,g,b)    ZLRGBA(r,g,b,1)
#define ZLGray(g)       ZLRGB(g,g,g)

#define ZLHEXA(hex,a)       [UIColor colorWithHexString:hex alpha:a]
#define ZLHEX(hex)          CHEXA(hex,1)


#define ZLHEXCOLOR_a(hex,a) [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16)) / 255.0 green:((float)((hex & 0xFF00) >> 8)) / 255.0 blue:((float)(hex & 0xFF)) / 255.0 alpha:(a)]
#define ZLHEXCOLOR(hex) [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16)) / 255.0 green:((float)((hex & 0xFF00) >> 8)) / 255.0 blue:((float)(hex & 0xFF)) / 255.0 alpha:1]

/** font **/
#pragma mark - font
#define ZLBoldFont(x)   [UIFont boldSystemFontOfSize:(x)]
#define ZLNormalFont(x) [UIFont systemFontOfSize:(x)]
#define ZLItalicFont(x) [UIFont italicSystemFontOfSize:(x)]

#pragma mark - scale
#define SCALE (SCREENWIDTH/750.0)

/** string **/
#define IsEmptyString(str)      (!str || [str.trim isEqualToString : @""])

/** log **/
#pragma mark - log
#ifdef DEBUG
#define ZLLog(...) NSLog(__VA_ARGS__)
#define ZLAllLog(format, ...) \
NSLog((@"[文件名:%s]" "[函数名:%s]" "[行号:%d] Log:" format), __FILE__, __FUNCTION__, __LINE__, ##__VA_ARGS__);
#define ZLFileLog(format, ...) \
NSLog((@"[文件名:%s] Log:" format), __FILE__, ##__VA_ARGS__);
#define ZLFuncLog(format, ...) \
NSLog((@"[函数名:%s] Log:" format), __FUNCTION__, ##__VA_ARGS__);
#define ZLFuncLineLog(format, ...) \
NSLog((@"[函数名:%s]" "[行号:%d] Log:" format), __FUNCTION__, __LINE__, ##__VA_ARGS__);

#define ZLWarningLog(format, ...) \
NSLog((@"[文件名:%s] Warning Log:" format), __FILE__, ##__VA_ARGS__);
#define ZLErrorLog(format, ...) \
NSLog((@"[文件名:%s] Error Log:" format), __FILE__, ##__VA_ARGS__);

#else
#define ZLLog(...);
#define ZLAllLog(...);
#define ZLFileLog(...);
#define ZLFuncLog(...);
#define ZLFuncLineLog(...);

#define ZLErrorLog(...);
#define ZLWarningLog(...);
#endif

#define LogGRect(rect)       ZLLog(@"%s x:%.4f, y:%.4f, w:%.4f, h:%.4f", #rect, rect.origin.x, rect.origin.y, rect.size.width, rect.size.height)
#define LogGSize(size)       ZLLog(@"%s w:%.4f, h:%.4f", #size, size.width, size.height)
#define LogGPoint(point)     ZLLog(@"%s x:%.4f, y:%.4f", #point, point.x, point.y)

/** notification **/
#pragma mark - notification
#define DefaultNotificationCenter [NSNotificationCenter defaultCenter]
#define TimerCellDeallocNotification @"TimerCellDeallocNotification"

//weakSelf & strongSelf
#define weakSelf( x ) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
__attribute__((objc_ownership(weak))) __typeof__(x) __weak_##x##__ = x; \
_Pragma("clang diagnostic pop")

#define strongSelf( x ) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
__attribute__((objc_ownership(strong))) __typeof__(x) x = __weak_##x##__; \
_Pragma("clang diagnostic pop")

#endif /* ZLPreMacro_h */
