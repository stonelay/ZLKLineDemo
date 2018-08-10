//
//  MockServer.m
//  OpenGLDemo
//
//  Created by LayZhang on 2018/7/25.
//  Copyright © 2018年 Zhanglei. All rights reserved.
//

#import "MockServer.h"
#import "KLineModel.h"

#import "ZLQuoteNode.h"

#import "DateFormat.h"
#import "ZLDataParser.h"
@interface MockServer()

@property (nonatomic, strong) ZLQuoteNode *mockQuoteNode;

@property (nonatomic, strong) NSArray *mockHisData;

@end

@implementation MockServer

+ (instancetype)shareInstance {
    static MockServer *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[MockServer alloc] init];
    });
    return instance;
}

- (instancetype)init {
    if (self = [super init]) {
        [self mockSendQuoteData];
    }
    return self;
}

- (NSArray *)loadData {
    // 模拟数据
    ZLDataParser *parser = [[ZLDataParser alloc] init];
    self.mockHisData = [parser parseHisData];
    return self.mockHisData;
}

- (NSArray *)loadMore {
    if ([self isLastData]) return self.mockHisData;
    moreCount++;
    ZLDataParser *parser = [[ZLDataParser alloc] init];
    self.mockHisData = [[parser parseHisData] arrayByAddingObjectsFromArray:self.mockHisData];
    return self.mockHisData;
}

static int moreCount = 0;
static int const maxCount = 2;
- (BOOL)isLastData {
    return moreCount >= maxCount;
}

// 模拟实时发送交易行情
- (void)mockSendQuoteData {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        for (int i = 0; i < 10000; i++) {
            sleep(2);
            ZLQuoteNode *node = [self getMockQuoteNode];
            dispatch_async(dispatch_get_main_queue(), ^{
                [DefaultNotificationCenter postNotificationName:HandleNewQuoteEventNotification object:node];
            });
        }
    });
}

static float lastPercent = 1.0;
static NSDate *beginDate;
- (ZLQuoteNode *)getMockQuoteNode {
    if (!beginDate) {
        beginDate = [NSDate new];
    }
    KLineModel *lastModel = [[self.mockHisData objectAtIndex:self.mockHisData.count - 1] copy];
    ZLQuoteNode *newNode = [[ZLQuoteNode alloc] init];
    double randomPercent = (50 - random() % 100) / 10000.0;
    lastPercent *= (1 + randomPercent);
//    NSLog(@"%f", lastPercent);
    newNode.bid = lastModel.close * lastPercent;
    newNode.ask = lastModel.close * lastPercent;
    
    // 假的数据， 一秒等于一小时
    NSTimeInterval crossTime = [[NSDate new] timeIntervalSinceDate:beginDate];
    NSDate *mockDate = [NSDate dateWithTimeIntervalSinceNow:crossTime * 60 * 60];
    newNode.tradeDay = [DateFormat stringFromDate:mockDate withFormat:@"YYYYMMdd"];
    
    return newNode;
}


@end
