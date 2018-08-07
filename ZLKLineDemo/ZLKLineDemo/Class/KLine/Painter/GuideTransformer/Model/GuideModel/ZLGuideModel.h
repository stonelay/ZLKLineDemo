//
//  ZLGuideModel.h
//  OpenGLDemo
//
//  Created by LayZhang on 2018/7/30.
//  Copyright © 2018年 Zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZLGuideDataType.h"

@interface ZLGuideModel : NSObject

@property (nonatomic, strong) NSString *name;

@property (nonatomic, assign, readonly) CGFloat maxData;
@property (nonatomic, assign, readonly) CGFloat minData;

@property (nonatomic, assign) BOOL      isNeedDraw;

- (void)initDefault;

@end
