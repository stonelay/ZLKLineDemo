//
//  ZLGuideKDJModel.h
//  OpenGLDemo
//
//  Created by LayZhang on 2018/8/2.
//  Copyright © 2018年 Zhanglei. All rights reserved.
//

#import "ZLGuideModel.h"

@interface ZLGuideKDJModel : ZLGuideModel

@property (nonatomic, assign) CGFloat kData;
@property (nonatomic, assign) CGFloat dData;
@property (nonatomic, assign) CGFloat jData;

@property (nonatomic, assign, readonly) CGFloat maxData;
@property (nonatomic, assign, readonly) CGFloat minData;

@end
