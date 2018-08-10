//
//  NSDictionary+Safe.m
//  LayZhangDemo
//
//  Created by LayZhang on 2017/8/25.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "NSDictionary+Safe.h"
#import "NSObject+Safe.h"

@implementation NSDictionary (Safe)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [NSDictionary exchangeClassMethodFromSel:@selector(dictionaryWithObjects:forKeys:count:)
                                           toSel:@selector(safeDictionaryWithObjects:forKeys:count:)];
    });
}

+ (instancetype)safeDictionaryWithObjects:(const id  _Nonnull __unsafe_unretained *)objects
                                  forKeys:(const id<NSCopying>  _Nonnull __unsafe_unretained *)keys
                                    count:(NSUInteger)count {
    id instance = nil;
    
    @try {
        instance = [self safeDictionaryWithObjects:objects
                                           forKeys:keys
                                             count:count];
    }
    @catch (NSException *exception) {
        
        NSString *reason = @"objects maybe nil.";
        [NSObject noticeException:exception withReason:reason];
        
        NSUInteger index = 0;
        id  _Nonnull __unsafe_unretained newObjects[count];
        id  _Nonnull __unsafe_unretained newkeys[count];
        
        for (int i = 0; i < count; i++) {
            if (objects[i] && keys[i]) {
                newObjects[index] = objects[i];
                newkeys[index] = keys[i];
                index++;
            }
        }
        instance = [self safeDictionaryWithObjects:objects
                                           forKeys:keys
                                             count:count];
    }
    @finally {
        return instance;
    }
}

@end
