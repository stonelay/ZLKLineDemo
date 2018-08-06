//
//  NSObject+ZLEX.m
//  LayZhangDemo
//
//  Created by LayZhang on 2017/11/7.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "NSObject+ZLEX.h"

@implementation NSObject (ZLEX)

+ (NSArray *)zl_subclasses {
    int numClasses = objc_getClassList(NULL, 0); // 获取当前所有类的个数
    
    Class *classes = (Class *)malloc(sizeof(Class) * numClasses);
    numClasses = objc_getClassList(classes, numClasses);// 配好内存空间的数组 classes 中存放元素
    
    NSMutableArray *result = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < numClasses; ++i) {
        Class superClass = classes[i];
        
        do {
            superClass = class_getSuperclass(superClass);
        } while(superClass && superClass != [self class]);
        
        if (superClass == nil) {
            continue;
        }
        
        [result addObject:classes[i]];
    }
    
    free(classes);
    
    return result;
}

@end
