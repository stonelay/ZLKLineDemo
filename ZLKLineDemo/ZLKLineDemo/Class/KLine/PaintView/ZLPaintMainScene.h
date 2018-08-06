//
//  ZLPaintView.h
//  OpenGLDemo
//
//  Created by LayZhang on 2018/7/24.
//  Copyright © 2018年 Zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLKLinePainter.h"

@class ZLPaintCore;

@interface ZLPaintMainScene : UIView<ZLKLinePainter>

@property (nonatomic, assign) UIEdgeInsets degeInsets;
@property (nonatomic, strong) ZLPaintCore *paintCore;

@end
