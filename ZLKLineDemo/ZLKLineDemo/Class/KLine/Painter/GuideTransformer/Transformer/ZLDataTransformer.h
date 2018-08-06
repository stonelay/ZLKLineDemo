//
//  ZLDataTransformer.h
//  OpenGLDemo
//
//  Created by LayZhang on 2018/7/30.
//  Copyright © 2018年 Zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ZLGuideDataPack.h"
#import "ZLGuideParam.h"


@interface ZLDataTransformer : NSObject

- (NSString *)guideID;

- (ZLGuideDataPack *)transToGuideData:(NSArray *)chartDataArray
                           guideParam:(ZLGuideParam *)guideParam;


@end
