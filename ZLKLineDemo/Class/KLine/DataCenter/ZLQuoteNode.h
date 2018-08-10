//
//  ZLQuoteNode.h
//  ZLKLineDemo
//
//  Created by LayZhang on 2018/8/7.
//  Copyright © 2018年 Zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZLQuoteNode : NSObject

@property(nonatomic) double bid;            // 买
@property(nonatomic) double ask;            // 卖

@property(nonatomic) double value;          //

@property(strong, nonatomic) NSDate   * time;       //时间
@property(strong, nonatomic) NSString * instrument; //品名
@property(strong, nonatomic) NSString * tradeDay;   //交易时间

- (NSString *)nodeDescription;

@end
