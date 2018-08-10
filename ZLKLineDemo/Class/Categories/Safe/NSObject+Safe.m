//
//  NSObject+Safe.m
//  LayZhangDemo
//
//  Created by LayZhang on 2017/8/24.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "NSObject+Safe.h"

@implementation NSObject (Safe)

+ (void)exchangeClassMethodFromSel:(SEL)fromSel toSel:(SEL)toSel {
    Method fromMethod = class_getClassMethod([self class], fromSel);
    Method toMethod = class_getClassMethod([self class], toSel);
    if (!class_addMethod(object_getClass(self), fromSel, method_getImplementation(toMethod), method_getTypeEncoding(toMethod))) {
        method_exchangeImplementations(fromMethod, toMethod);
    }
}

+ (void)exchangeInstanceMethodFromSel:(SEL)fromSel toSel:(SEL)toSel {
    Method fromMethod = class_getInstanceMethod([self class], fromSel);
    Method toMethod = class_getInstanceMethod([self class], toSel);
    if (!class_addMethod([self class], fromSel, method_getImplementation(toMethod), method_getTypeEncoding(toMethod))) {
        method_exchangeImplementations(fromMethod, toMethod);
    }
}

+ (void)noticeException:(NSException *)exception withReason:(NSString *)reason {
    //堆栈数据
    NSArray *callStackSymbolsArr = [NSThread callStackSymbols];
    
    //获取在哪个类的哪个方法中实例化的数组  字符串格式 -[类名 方法名]  或者 +[类名 方法名]
    NSString *mainCallStackSymbolMsg = [self getMainCallStackSymbolMessage:callStackSymbolsArr[2]];
    
    if (mainCallStackSymbolMsg == nil) {
        mainCallStackSymbolMsg = @"崩溃方法定位失败!";
    }
    
    NSString *errorName = exception.name;
    NSString *errorReason = exception.reason;
    //errorReason 可能为 -[__NSCFConstantString JQSafeKitCharacterAtIndex:]: Range or index out of bounds
    //将JQSafeKit去掉
    
    NSString *errorPlace = [NSString stringWithFormat:@"Error Place:%@",mainCallStackSymbolMsg];
    
    NSString *logErrorMessage = [NSString stringWithFormat:@"\n\n%@\n\n%@\n%@\n%@\n\n%@\n\n",SafeKitSeparatorBegin, errorName, errorReason, errorPlace, SafeKitSeparatorEnd];
    NSLog(@"%@", logErrorMessage);
    
    NSDictionary *errorInfoDic = @{
                                   key_errorName        : errorName,
                                   key_errorReason      : errorReason,
                                   key_errorPlace       : errorPlace,
                                   key_exception        : exception,
                                   key_callStackSymbols : callStackSymbolsArr
                                   };
    
    //将错误信息放在字典里，用通知的形式发送出去
    [[NSNotificationCenter defaultCenter] postNotificationName:NSKeyValueChangeNotificationIsPriorKey
                                                        object:nil userInfo:errorInfoDic];
}

#pragma mark - private method
/**
 *  获取堆栈主要崩溃精简化的信息<根据正则表达式匹配出来>
 *
 *  @param callStackSymbolStr 堆栈主要崩溃信息
 *
 *  @return 堆栈主要崩溃精简化的信息
 */

+ (NSString *)getMainCallStackSymbolMessage:(NSString *)callStackSymbolStr {
    
    //mainCallStackSymbolMsg的格式为   +[类名 方法名]  或者 -[类名 方法名]
    __block NSString *mainCallStackSymbolMsg = nil;
    
    //匹配出来的格式为 +[类名 方法名]  或者 -[类名 方法名]
    NSString *regularExpStr = @"[-\\+]\\[.+\\]";
    
    NSRegularExpression *regularExp = [[NSRegularExpression alloc] initWithPattern:regularExpStr options:NSRegularExpressionCaseInsensitive error:nil];
    
    [regularExp enumerateMatchesInString:callStackSymbolStr options:NSMatchingReportProgress range:NSMakeRange(0, callStackSymbolStr.length) usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
        if (result) {
            mainCallStackSymbolMsg = [callStackSymbolStr substringWithRange:result.range];
            *stop = YES;
        }
    }];
    return mainCallStackSymbolMsg;
}


@end
