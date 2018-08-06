//
//  NSArray+Safe.m
//  LayZhangDemo
//
//  Created by LayZhang on 2017/8/24.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "NSArray+Safe.h"
#import "NSObject+Safe.h"

@implementation NSArray (Safe)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 2个及两个以上元素 数组
        [NSClassFromString(@"__NSArrayI") exchangeInstanceMethodFromSel:@selector(objectAtIndex:)
                                                                  toSel:@selector(safeObjectAtIndexI:)];
        // 单个元素 数组
        [NSClassFromString(@"__NSSingleObjectArrayI") exchangeInstanceMethodFromSel:@selector(objectAtIndex:)
                                                                              toSel:@selector(safeObjectAtIndexSingle:)];
        // 空数组 数组
        [NSClassFromString(@"__NSArray0") exchangeInstanceMethodFromSel:@selector(objectAtIndex:)
                                                                  toSel:@selector(safeObjectAtIndex0:)];
        // __NSPlaceHolderArray 没必要为 未初始化的数组做检查
        
        // 数组初始化方法 类方法
        [NSArray exchangeClassMethodFromSel:@selector(arrayWithObjects:count:)
                                      toSel:@selector(safeArrayWithObjects:count:)];
    });
}

#pragma mark - get object from array
- (id)safeObjectAtIndex0:(NSUInteger)index {
    
    id object = nil;
    @try {
        object = [self safeObjectAtIndex0:index];
    }
    @catch (NSException *exception) {
        NSString *reason = @"__NSArray0 objectAtIndex return nil.";
        [NSObject noticeException:exception withReason:reason];
    }
    @finally {
        return object;
    }
}

- (id)safeObjectAtIndexSingle:(NSUInteger)index {
    
    id object = nil;
    @try {
        object = [self safeObjectAtIndexSingle:index];
    }
    @catch (NSException *exception) {
        NSString *reason = @"__NSSingleObjectArrayI objectAtIndex return nil.";
        [NSObject noticeException:exception withReason:reason];
    }
    @finally {
        return object;
    }
}

- (id)safeObjectAtIndexI:(NSUInteger)index {
    
    id object = nil;
    @try {
        object = [self safeObjectAtIndexI:index];
    }
    @catch (NSException *exception) {
        NSString *reason = @"__NSArrayI objectAtIndex return nil.";
        [NSObject noticeException:exception withReason:reason];
    }
    @finally {
        return object;
    }
}

#pragma mark - init array
+ (instancetype)safeArrayWithObjects:(const id *)objects count:(NSUInteger)count {
    id instance = nil;
    @try {
        instance = [self safeArrayWithObjects:objects count:count];
    }
    @catch (NSException *exception) {
        
        NSString *reason = @"Array has nil object! It will cause crash!";
        [NSObject noticeException:exception withReason:reason];
        
        NSInteger newObjsIndex = 0;
        id  _Nonnull __unsafe_unretained newObjects[count];
        
        for (int i = 0; i < count; i++) {
            if (objects[i] != nil) {
                newObjects[newObjsIndex] = objects[i];
                newObjsIndex++;
            }
        }
        instance = [self safeArrayWithObjects:newObjects count:newObjsIndex];
    }
    @finally {
        return instance;
    }
}

@end
