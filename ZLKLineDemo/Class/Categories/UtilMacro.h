//
//  UtilMacro.h
//  LayZhangDemo
//
//  Created by LayZhang on 2017/9/8.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#ifndef UtilMacro_h
#define UtilMacro_h

#define ZLBoldFont(x)   [UIFont boldSystemFontOfSize:(x)]

#define DelayEnableButton(s, t) UIButton *enableButton = (UIButton *)s;\
enableButton.enabled = NO;\
dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(t * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{\
enableButton.enabled = YES;\
});

#endif /* UtilMacro_h */
