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

@interface ZLQuoteDataCenter()

//@property (nonatomic, strong) ZLGuideManager *guideManager;

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
    }
    return self;
}

- (void)loadHisData {
    self.hisKLineDataArray = [[MockServer getMockHisData] mutableCopy];
//    [self updateGuideWithData:self.hisKLineDataArray];
}

- (void)loadMoreHisData {
    NSMutableArray *nArray = [[MockServer getMoreMockHisData] mutableCopy];
    [nArray addObjectsFromArray:self.hisKLineDataArray];
    self.hisKLineDataArray = nArray;
}

- (BOOL)isLastData {
    return [MockServer isLastData];
}

@end




