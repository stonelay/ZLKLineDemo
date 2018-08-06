//
//  ZLGuideBOLLModel.h
//  OpenGLDemo
//
//  Created by LayZhang on 2018/8/2.
//  Copyright © 2018年 Zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZLGuideBOLLModel : NSObject

@property (nonatomic, assign) CGFloat period;

@property (nonatomic, assign) CGFloat midData;
@property (nonatomic, assign) CGFloat upData;
@property (nonatomic, assign) CGFloat lowData;

@property (nonatomic, assign) BOOL isNeedDraw;

@end
