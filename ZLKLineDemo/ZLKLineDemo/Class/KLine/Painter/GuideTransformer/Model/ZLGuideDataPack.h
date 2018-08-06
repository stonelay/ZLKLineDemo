//
//  ZLGuideDataPack.h
//  OpenGLDemo
//
//  Created by LayZhang on 2018/7/30.
//  Copyright © 2018年 Zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ZLGuideParam.h"

//#import "ZLMAParam.h"

@interface ZLGuideDataPack : NSObject

- (instancetype)initWithParams:(ZLGuideParam *)param;

@property (nonatomic, strong) ZLGuideParam *param;
@property (nonatomic, strong) NSArray *dataArray;

@end
