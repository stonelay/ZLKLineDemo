//
//  MockServer.h
//  OpenGLDemo
//
//  Created by LayZhang on 2018/7/25.
//  Copyright © 2018年 Zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZLQuoteNode;

@interface MockServer : NSObject

+ (instancetype)shareInstance;

- (BOOL)isLastData;
//- (ZLQuoteNode *)getMockQuoteNode;


- (NSArray *)loadData;
- (NSArray *)loadMore;

@end
