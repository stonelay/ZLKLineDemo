//
//  KLineModel.m
//  OpenGLDemo
//
//  Created by LayZhang on 2018/7/24.
//  Copyright © 2018年 Zhanglei. All rights reserved.
//

#import "KLineModel.h"

@implementation KLineModel

- (instancetype)copy {
    KLineModel *model = [[KLineModel alloc] init];
    model.high = self.high;
    model.low = self.low;
    model.open = self.open;
    model.close = self.close;
    model.date = self.date;
    return model;
}

@end
