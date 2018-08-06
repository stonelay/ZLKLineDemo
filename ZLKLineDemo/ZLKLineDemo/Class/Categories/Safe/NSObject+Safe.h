//
//  NSObject+Safe.h
//  LayZhangDemo
//
//  Created by LayZhang on 2017/8/24.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

#define SafeKitSeparatorBegin         @"====================== Err Log Begin ==========================="
#define SafeKitSeparatorEnd           @"====================== Err Log End ============================="

#define key_errorName        @"errorName"
#define key_errorReason      @"errorReason"
#define key_errorPlace       @"errorPlace"
#define key_callStackSymbols @"callStackSymbols"
#define key_exception        @"exception"

static const NSString *kNotify_objectSafe_exception = @"kNotify_ObjectSafe_exception";

@interface NSObject (Safe)

/**
 类方法替换
 
 @param fromSel 被替换的方法
 @param toSel 替换的方法
 */
+ (void)exchangeClassMethodFromSel:(SEL)fromSel toSel:(SEL)toSel;

/**
 对象方法替换
 
 @param fromSel 被替换的方法
 @param toSel 替换的方法
 */
+ (void)exchangeInstanceMethodFromSel:(SEL)fromSel toSel:(SEL)toSel;

/**
 抛异常原因

 @param exception 异常
 @param reason 自定义异常原因
 */
+ (void)noticeException:(NSException *)exception withReason:(NSString *)reason;


@end
