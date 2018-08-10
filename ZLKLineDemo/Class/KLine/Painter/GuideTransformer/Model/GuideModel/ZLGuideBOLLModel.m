//
//  ZLGuideBOLLModel.m
//  OpenGLDemo
//
//  Created by LayZhang on 2018/8/2.
//  Copyright © 2018年 Zhanglei. All rights reserved.
//

#import "ZLGuideBOLLModel.h"

@implementation ZLGuideBOLLModel

- (void)initDefault {
    [super initDefault];
    self.name = kGUIDE_ID_BOLL;
}

- (CGFloat)minData {
    return self.lowData;
}

- (CGFloat)maxData {
    return self.upData;
}

@end
