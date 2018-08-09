//
//  ZLQuoteDataCenter.h
//  OpenGLDemo
//
//  Created by LayZhang on 2018/7/25.
//  Copyright © 2018年 Zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ZLQuoteNode.h"

@protocol QuoteListener<NSObject>

- (void)recQuoteData:(ZLQuoteNode *)quoteNode;

@end

@interface ZLQuoteDataCenter : NSObject

@property (nonatomic, strong) NSMutableArray *hisKLineDataArray;

+ (instancetype)shareInstance;

- (void)loadHisData;
- (void)loadMoreHisData;
- (BOOL)isLastData;

- (void)addQuoteListener:(id<QuoteListener>)listener;
- (void)removeQuoteListener:(id<QuoteListener>)listener;

@end
