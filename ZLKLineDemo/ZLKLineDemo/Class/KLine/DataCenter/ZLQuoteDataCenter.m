//
//  ZLQuoteDataCenter.m
//  OpenGLDemo
//
//  Created by LayZhang on 2018/7/25.
//  Copyright © 2018年 Zhanglei. All rights reserved.
//

#import "ZLQuoteDataCenter.h"
#import "MockServer.h"
#import "ZLGuideManager.h"
#import "ZLQuoteNode.h"

@interface ZLQuoteDataCenter()

@property (nonatomic, strong) NSMutableArray *quoteListeners;

@end

@implementation ZLQuoteDataCenter

+ (instancetype)shareInstance {
    static ZLQuoteDataCenter *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[ZLQuoteDataCenter alloc] init];
    });
    return instance;
}

- (instancetype)init {
    if (self = [super init]) {
        [self loadHisData];
        [self addListener];
    }
    return self;
}

- (void)loadHisData {
    // 模拟获取 hisdata
    self.hisKLineDataArray = [[[MockServer shareInstance] loadData] mutableCopy];
//    [DefaultNotificationCenter postNotificationName:LoadHisDataNotification object:nil];
}

- (void)loadMoreHisData {
    // 模拟获取 更多 hisdata
    self.hisKLineDataArray = [[[MockServer shareInstance] loadMore] mutableCopy];
//    [DefaultNotificationCenter postNotificationName:LoadHisDataNotification object:nil];
}

- (BOOL)isLastData {
    // 一个 标识位
    return [MockServer shareInstance].isLastData;
}

- (void)addListener {
    [DefaultNotificationCenter addObserver:self selector:@selector(handleNewQuoteEvent:) name:HandleNewQuoteEventNotification object:nil];
}

- (void)handleNewQuoteEvent:(NSNotification *)notify {
    // 如果是真实环境， 应该 是异步获取数据的
    // 这里是模拟异步获取行情
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        ZLQuoteNode *quoteNode = notify.object;
        if(!quoteNode || ![quoteNode isKindOfClass:[ZLQuoteNode class]]) {
            NSLog(@"获取的quote 未知错误.");
            return;
        }
        [self fireQuoteData:quoteNode];
    });
}

- (void)fireQuoteData:(ZLQuoteNode *)quoteNode {
    if (!self.quoteListeners || self.quoteListeners.count == 0) {
        return;
    }
    
    @synchronized(self.quoteListeners){
        for (id<QuoteListener>listener in self.quoteListeners) {
            [listener recQuoteData:quoteNode];
        }
    }
}

- (void)addQuoteListener:(id<QuoteListener>)listener {
    @synchronized(self.quoteListeners){
        if (![self.quoteListeners containsObject:listener]) {
            [self.quoteListeners addObject:listener];
        }
    }
}

- (void)removeQuoteListener:(id<QuoteListener>)listener {
    if (listener && [self.quoteListeners containsObject:listener]) {
        @synchronized(self.quoteListeners){
            if ([self.quoteListeners containsObject:listener]) {
                [self.quoteListeners removeObject:listener];
            }
        }
    }
}

- (NSMutableArray *)quoteListeners {
    if (!_quoteListeners) {
        _quoteListeners = [[NSMutableArray alloc] init];
    }
    return _quoteListeners;
}


@end




