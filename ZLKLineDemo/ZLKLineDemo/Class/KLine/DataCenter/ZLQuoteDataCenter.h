//
//  ZLQuoteDataCenter.h
//  OpenGLDemo
//
//  Created by LayZhang on 2018/7/25.
//  Copyright © 2018年 Zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZLQuoteDataCenter : NSObject

@property (nonatomic, strong) NSMutableArray *hisKLineDataArray;

+ (instancetype)shareInstance;

- (void)loadHisData;

@end
