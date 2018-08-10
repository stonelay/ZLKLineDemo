//
//  ZLBasePaintView.h
//  OpenGLDemo
//
//  Created by LayZhang on 2018/7/26.
//  Copyright © 2018年 Zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLKLinePainter.h"

@interface ZLBasePaintView : UIControl<ZLKLinePainter>

- (void)initDefault;

@end
