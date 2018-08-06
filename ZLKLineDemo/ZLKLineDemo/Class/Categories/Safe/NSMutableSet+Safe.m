//
//  NSMutableSet+Safe.m
//  LayZhangDemo
//
//  Created by LayZhang on 2017/9/7.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "NSMutableSet+Safe.h"
#import "NSObject+Safe.h"

@implementation NSMutableSet (Safe)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [NSClassFromString(@"__NSSetM") exchangeInstanceMethodFromSel:@selector(addObject:)
                                                                toSel:@selector(addSafeObject:)];
        [NSClassFromString(@"__NSSetM") exchangeInstanceMethodFromSel:@selector(removeObject:)
                                                                       toSel:@selector(removeSafeObject:)];
    });
}

- (void)addSafeObject:(id)anObject {
    @try {
        [self addSafeObject:anObject];
    }
    @catch (NSException *exception) {
        NSString *reason = @"__NSSetM set object is nil";
        [NSObject noticeException:exception withReason:reason];
    }
    @finally {
        
    }
}

- (void)removeSafeObject:(id)anObject {
    @try {
        [self removeSafeObject:anObject];
    }
    @catch (NSException *exception) {
        NSString *reason = @"__NSSetM remove object is nil";
        [NSObject noticeException:exception withReason:reason];
    }
    @finally {
        
    }
}

@end
