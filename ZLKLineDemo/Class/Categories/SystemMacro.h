//
//  SystemMacro.h
//  LayZhangDemo
//
//  Created by LayZhang on 2017/9/18.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#ifndef SystemMacro_h
#define SystemMacro_h

#define SYSTEM_VERSION        [[[UIDevice currentDevice] systemVersion] floatValue]

#define IS_IOS9                     (SYSTEM_VERSION >= 9)
#define IS_IOS8                     (SYSTEM_VERSION >= 8)
#define IS_IOS7                     (SYSTEM_VERSION >= 7)
#define IS_IPHONE4                  (SCREENHEIGHT < 568)
#define IS_IPHONE5                  (SCREENHEIGHT == 568)
#define IS_IPHONE6                  (SCREENHEIGHT == 667)
#define IS_IPHONE6Plus              (SCREENHEIGHT == 736)

#endif /* SystemMacro_h */
