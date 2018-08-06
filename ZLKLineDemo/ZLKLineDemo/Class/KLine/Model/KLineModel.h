//
//  KLineModel.h
//  OpenGLDemo
//
//  Created by LayZhang on 2018/7/24.
//  Copyright © 2018年 Zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KLineModel : NSObject

// k线数据 开高低收
@property (assign, nonatomic) CGFloat high;
@property (assign, nonatomic) CGFloat low;
@property (assign, nonatomic) CGFloat open;
@property (assign, nonatomic) CGFloat close;
@property (copy,   nonatomic) NSString *date;

@end
