//
//  NSMutableDictionary+Safe.m
//  LayZhangDemo
//
//  Created by LayZhang on 2017/8/25.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "NSMutableDictionary+Safe.h"
#import "NSObject+Safe.h"

@implementation NSMutableDictionary (Safe)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [NSClassFromString(@"__NSDictionaryM") exchangeInstanceMethodFromSel:@selector(setObject:forKey:)
                                                     toSel:@selector(setSafeObject:forKey:)];
        [NSClassFromString(@"__NSDictionaryM") exchangeInstanceMethodFromSel:@selector(removeObjectForKey:)
                                                     toSel:@selector(removeSafeObjectForKey:)];
    });
}

- (void)setSafeObject:(id)anObject forKey:(id<NSCopying>)aKey {
    @try {
        [self setSafeObject:anObject forKey:aKey];
    }
    @catch (NSException *exception) {
        NSString *reason = @"__NSDictionaryM set object or key is nil";
        [NSObject noticeException:exception withReason:reason];
    }
    @finally {
        
    }
}

- (void)removeSafeObjectForKey:(id)aKey {
    @try {
        [self removeSafeObjectForKey:aKey];
    }
    @catch (NSException *exception) {
        NSString *reason = @"__NSDictionaryM remove key is nil";
        [NSObject noticeException:exception withReason:reason];
    }
    @finally {
        
    }
}

@end
