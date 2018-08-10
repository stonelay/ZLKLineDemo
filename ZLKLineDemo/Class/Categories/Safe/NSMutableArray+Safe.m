//
//  NSMutableArray+Safe.m
//  LayZhangDemo
//
//  Created by LayZhang on 2017/8/24.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "NSMutableArray+Safe.h"
#import "NSObject+Safe.h"

@implementation NSMutableArray (Safe)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Class arrayMClass = NSClassFromString(@"__NSArrayM");
        // 获取索引元素
        [arrayMClass exchangeInstanceMethodFromSel:@selector(objectAtIndex:)
                                             toSel:@selector(safeObjectAtIndexM:)];
        
        [arrayMClass exchangeInstanceMethodFromSel:@selector(objectAtIndexedSubscript:)
                                             toSel:@selector(safeObjectAtIndexedSubscriptM:)];
        
        // 索替换
        [arrayMClass exchangeInstanceMethodFromSel:@selector(setObject:atIndexedSubscript:)
                                             toSel:@selector(setSafeObject:atIndexedSubscript:)];
        
        // 索引移除
        [arrayMClass exchangeInstanceMethodFromSel:@selector(removeObjectAtIndex:)
                                             toSel:@selector(safeRemoveObjectAtIndex:)];
        
        // 索引插入
        [arrayMClass exchangeInstanceMethodFromSel:@selector(insertObject:atIndex:)
                                             toSel:@selector(insertSafeObject:atIndex:)];
    });
}

#pragma mark - get object from array
- (id)safeObjectAtIndexM:(NSUInteger)index {
    
    id object = nil;
    @try {
        object = [self safeObjectAtIndexM:index];
    }
    @catch (NSException *exception) {
        NSString *reason = @"__NSArrayM objectAtIndex return nil.";
        [NSObject noticeException:exception withReason:reason];
    }
    @finally {
        return object;
    }
}

- (id)safeObjectAtIndexedSubscriptM:(NSUInteger)index {
    
    id object = nil;
    @try {
        // iOS 11
        object = [self safeObjectAtIndexM:index];
    }
    @catch (NSException *exception) {
        NSString *reason = @"__NSArrayM objectAtIndexedSubscript return nil.";
        [NSObject noticeException:exception withReason:reason];
    }
    @finally {
        return object;
    }
}

#pragma mark - set object
- (void)setSafeObject:(id)obj atIndexedSubscript:(NSUInteger)idx {
    @try {
        [self setSafeObject:obj atIndexedSubscript:idx];
    }
    @catch (NSException *exception) {
        NSString *reason = @"__NSArrayM setObject maybe nil";
        [NSObject noticeException:exception withReason:reason];
    }
    @finally {
        
    }
}

#pragma mark - removeObject at index
- (void)safeRemoveObjectAtIndex:(NSUInteger)index {
    @try {
        [self safeRemoveObjectAtIndex:index];
    }
    @catch (NSException *exception) {
        NSString *reason = @"__NSArrayM removeIndex is crosse";
        [NSObject noticeException:exception withReason:reason];
    }
    @finally {
        
    }
}

- (void)insertSafeObject:(id)anObject atIndex:(NSUInteger)index {
    @try {
        [self insertSafeObject:anObject atIndex:index];
    }
    @catch (NSException *exception) {
        NSString *reason = @"__NSArrayM insertObject is nil or index cross";
        [NSObject noticeException:exception withReason:reason];
    }
    @finally {
        
    }
}

@end
