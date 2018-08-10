//
//  ZLQuoteNode.m
//  ZLKLineDemo
//
//  Created by LayZhang on 2018/8/7.
//  Copyright © 2018年 Zhanglei. All rights reserved.
//

#import "ZLQuoteNode.h"

@implementation ZLQuoteNode

- (NSString *)nodeDescription {
    return [NSString stringWithFormat:@"Day: %@, Bid: %.2f", self.tradeDay, self.bid];
}

@end
