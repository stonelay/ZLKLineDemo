//
//  ZLGuideRSIModel.h
//  OpenGLDemo
//
//  Created by LayZhang on 2018/8/6.
//  Copyright © 2018年 Zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZLGuideRSIModel : NSObject

@property (nonatomic, assign) CGFloat longPeriod;
@property (nonatomic, assign) CGFloat shortPeriod;

@property (nonatomic, assign) CGFloat longData;
@property (nonatomic, assign) CGFloat shortData;

@property (nonatomic, assign) BOOL isNeedDraw;

@end
