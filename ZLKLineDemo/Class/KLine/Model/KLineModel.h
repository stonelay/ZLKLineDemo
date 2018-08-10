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
@property (nonatomic, assign) CGFloat high;
@property (nonatomic, assign) CGFloat low;
@property (nonatomic, assign) CGFloat open;
@property (nonatomic, assign) CGFloat close;
@property (nonatomic, strong) NSString *date;

- (instancetype)copy;

@end
